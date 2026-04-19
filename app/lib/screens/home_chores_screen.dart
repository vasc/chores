import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import '../auth/auth_controller.dart';
import '../graphql/operations/chores.graphql.dart';
import '../graphql/operations/fragments.graphql.dart';
import '../graphql/operations/queries.graphql.dart';
import '../graphql/schema.graphql.dart';
import '../widgets/error_box.dart';

class HomeChoresScreen extends ConsumerWidget {
  const HomeChoresScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    final me = auth.me;
    if (me == null) return const SizedBox.shrink();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(me.avatarEmoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Flexible(child: Text(me.name, overflow: TextOverflow.ellipsis)),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${me.tokenBalance} 🪙',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [
          if (auth.isAdult)
            IconButton(
              tooltip: 'Approvals',
              icon: const Icon(Icons.fact_check_outlined),
              onPressed: () => context.push('/approvals'),
            ),
          IconButton(
            tooltip: 'Rewards',
            icon: const Icon(Icons.card_giftcard_outlined),
            onPressed: () => context.push('/rewards'),
          ),
          if (auth.isAdult)
            IconButton(
              tooltip: 'Admin',
              icon: const Icon(Icons.settings_outlined),
              onPressed: () => context.push('/admin'),
            ),
          IconButton(
            tooltip: 'Log out',
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authControllerProvider.notifier).logout(),
          ),
        ],
      ),
      body: Query(
        options: QueryOptions(
          document: documentNodeQueryHome,
          fetchPolicy: FetchPolicy.cacheAndNetwork,
        ),
        builder: (result, {refetch, fetchMore}) {
          if (result.isLoading && result.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (result.hasException) {
            return Center(child: Text(result.exception!.toString()));
          }
          final parsed = Query$Home.fromJson(result.data!);
          final assignments = parsed.assignments;
          // On-demand chores the kid can claim right now (server enforces the
          // cooldown on submit; we just hide archived ones here).
          final claimable = parsed.chores
              .where((c) =>
                  c.kind == Enum$ChoreKind.on_demand && !c.archived)
              .toList();

          if (assignments.isEmpty && claimable.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async => refetch?.call(),
              child: ListView(
                children: const [
                  SizedBox(height: 120),
                  Center(child: Text('No chores yet.')),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async => refetch?.call(),
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                if (assignments.isNotEmpty) ...[
                  const _SectionHeader('Assigned to you'),
                  for (final a in assignments) _AssignmentTile(a: a),
                ],
                if (claimable.isNotEmpty) ...[
                  const _SectionHeader('Claim a chore'),
                  for (final c in claimable)
                    _ClaimableTile(chore: c, onClaimed: () => refetch?.call()),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AssignmentTile extends StatelessWidget {
  const _AssignmentTile({required this.a});
  final Fragment$AssignmentFields a;

  static final _df = DateFormat.yMMMd().add_jm();

  @override
  Widget build(BuildContext context) {
    final color = switch (a.status) {
      Enum$ChoreStatus.pending => Colors.blueGrey,
      Enum$ChoreStatus.submitted => Colors.amber,
      Enum$ChoreStatus.approved => Colors.green,
      Enum$ChoreStatus.rejected => Colors.red,
      _ => Colors.grey,
    };
    return Card(
      child: ListTile(
        onTap: () => context.push('/chore/${a.id}'),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.18),
          child: Text(a.assignedTo.avatarEmoji),
        ),
        title: Text(a.chore.title),
        subtitle: Text(
          '${a.assignedTo.name} · ${a.chore.tokenValue} 🪙'
          '${a.dueDate != null ? '\nDue ${_df.format(a.dueDate!.toLocal())}' : ''}',
        ),
        isThreeLine: a.dueDate != null,
        trailing: _StatusChip(status: a.status, color: color),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.label);
  final String label;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      );
}

class _ClaimableTile extends ConsumerStatefulWidget {
  const _ClaimableTile({required this.chore, required this.onClaimed});
  final Fragment$ChoreFields chore;
  final VoidCallback onClaimed;

  @override
  ConsumerState<_ClaimableTile> createState() => _ClaimableTileState();
}

class _ClaimableTileState extends ConsumerState<_ClaimableTile> {
  bool _busy = false;

  Future<void> _claim() async {
    setState(() => _busy = true);
    final result = await GraphQLProvider.of(context).value.mutate(
          MutationOptions(
            document: documentNodeMutationClaimChore,
            variables: Variables$Mutation$ClaimChore(choreId: widget.chore.id)
                .toJson(),
          ),
        );
    if (!mounted) return;
    setState(() => _busy = false);
    if (result.hasException) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(prettifyError(result.exception!))),
      );
      return;
    }
    widget.onClaimed();
  }

  @override
  Widget build(BuildContext context) {
    final cooldownLabel = widget.chore.cooldownMinutes > 0
        ? ' · cooldown ${widget.chore.cooldownMinutes}m'
        : '';
    return Card(
      child: ListTile(
        title: Text(widget.chore.title),
        subtitle: Text(
          '${widget.chore.tokenValue} 🪙$cooldownLabel'
          '${widget.chore.description != null ? '\n${widget.chore.description}' : ''}',
        ),
        isThreeLine: widget.chore.description != null,
        trailing: FilledButton.tonal(
          onPressed: _busy ? null : _claim,
          child: _busy
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Claim'),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status, required this.color});
  final Enum$ChoreStatus status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final label = switch (status) {
      Enum$ChoreStatus.pending => 'To do',
      Enum$ChoreStatus.submitted => 'Pending',
      Enum$ChoreStatus.approved => 'Done',
      Enum$ChoreStatus.rejected => 'Redo',
      _ => '?',
    };
    return Chip(
      label: Text(label),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.w600),
      backgroundColor: color.withOpacity(0.12),
      side: BorderSide(color: color.withOpacity(0.4)),
    );
  }
}
