import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gql/ast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../auth/auth_controller.dart';
import '../graphql/operations/chores.graphql.dart';
import '../graphql/operations/fragments.graphql.dart';
import '../graphql/operations/queries.graphql.dart';
import '../graphql/operations/rewards.graphql.dart';
import '../widgets/error_box.dart';

class ApprovalsScreen extends ConsumerStatefulWidget {
  const ApprovalsScreen({super.key});

  @override
  ConsumerState<ApprovalsScreen> createState() => _ApprovalsScreenState();
}

class _ApprovalsScreenState extends ConsumerState<ApprovalsScreen> {
  String? _error;

  Future<void> _run({
    required DocumentNode doc,
    required Map<String, dynamic> vars,
    required VoidCallback onAfter,
  }) async {
    setState(() => _error = null);
    final result = await ref.read(graphqlClientProvider).mutate(
          MutationOptions(document: doc, variables: vars),
        );
    if (!mounted) return;
    if (result.hasException) {
      setState(() => _error = prettifyError(result.exception!));
      return;
    }
    onAfter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Approvals')),
      body: Query(
        options: QueryOptions(
          document: documentNodeQueryPendingApprovals,
          fetchPolicy: FetchPolicy.cacheAndNetwork,
        ),
        builder: (result, {refetch, fetchMore}) {
          if (result.isLoading && result.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (result.hasException) {
            return Center(child: Text(result.exception!.toString()));
          }
          final parsed = Query$PendingApprovals.fromJson(result.data!);
          final chores = parsed.pendingApprovals;
          final redemptions = parsed.pendingRedemptions;
          if (chores.isEmpty && redemptions.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async => refetch?.call(),
              child: ListView(
                children: const [
                  SizedBox(height: 120),
                  Center(child: Text('All caught up ✨')),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async => refetch?.call(),
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                if (_error != null) ErrorBox(_error!),
                if (chores.isNotEmpty) ...[
                  const _SectionHeader('Chores to review'),
                  for (final a in chores)
                    _ChoreApprovalCard(
                      a: a,
                      onApprove: () => _run(
                        doc: documentNodeMutationApproveChore,
                        vars: Variables$Mutation$ApproveChore(assignmentId: a.id).toJson(),
                        onAfter: () => refetch?.call(),
                      ),
                      onReject: () async {
                        final reason = await _askReason(context, 'Send back');
                        if (reason == null) return;
                        await _run(
                          doc: documentNodeMutationRejectChore,
                          vars: Variables$Mutation$RejectChore(
                            assignmentId: a.id,
                            reason: reason.isEmpty ? null : reason,
                          ).toJson(),
                          onAfter: () => refetch?.call(),
                        );
                      },
                      onTap: () => context.push('/chore/${a.id}'),
                    ),
                ],
                if (redemptions.isNotEmpty) ...[
                  const _SectionHeader('Reward requests'),
                  for (final r in redemptions)
                    _RedemptionCard(
                      r: r,
                      onApprove: () => _run(
                        doc: documentNodeMutationApproveRedemption,
                        vars: Variables$Mutation$ApproveRedemption(id: r.id).toJson(),
                        onAfter: () => refetch?.call(),
                      ),
                      onDeny: () async {
                        final reason = await _askReason(context, 'Deny');
                        if (reason == null) return;
                        await _run(
                          doc: documentNodeMutationDenyRedemption,
                          vars: Variables$Mutation$DenyRedemption(
                            id: r.id,
                            reason: reason.isEmpty ? null : reason,
                          ).toJson(),
                          onAfter: () => refetch?.call(),
                        );
                      },
                    ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

Future<String?> _askReason(BuildContext context, String label) {
  final ctrl = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(label),
      content: TextField(
        controller: ctrl,
        decoration: const InputDecoration(hintText: 'Reason (optional)'),
        autofocus: true,
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: () => Navigator.pop(context, ctrl.text.trim()),
          child: Text(label),
        ),
      ],
    ),
  );
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

class _ChoreApprovalCard extends StatelessWidget {
  const _ChoreApprovalCard({
    required this.a,
    required this.onApprove,
    required this.onReject,
    required this.onTap,
  });
  final Fragment$AssignmentFields a;
  final VoidCallback onApprove;
  final VoidCallback onReject;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            onTap: onTap,
            leading: CircleAvatar(child: Text(a.assignedTo.avatarEmoji)),
            title: Text(a.chore.title),
            subtitle: Text('${a.assignedTo.name} · ${a.chore.tokenValue} 🪙'),
          ),
          OverflowBar(
            alignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: onReject, child: const Text('Send back')),
              FilledButton(
                onPressed: onApprove,
                child: Text('Approve · +${a.chore.tokenValue} 🪙'),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}

class _RedemptionCard extends StatelessWidget {
  const _RedemptionCard({
    required this.r,
    required this.onApprove,
    required this.onDeny,
  });
  final Fragment$RedemptionFields r;
  final VoidCallback onApprove;
  final VoidCallback onDeny;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(child: Text(r.user.avatarEmoji)),
            title: Text(r.reward.title),
            subtitle: Text('${r.user.name} wants to spend ${r.tokensSpent} 🪙'),
          ),
          OverflowBar(
            alignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: onDeny, child: const Text('Deny')),
              FilledButton(onPressed: onApprove, child: const Text('Approve')),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
