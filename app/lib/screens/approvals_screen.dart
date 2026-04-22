import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gql/ast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import '../auth/auth_controller.dart';
import '../graphql/operations/chores.graphql.dart';
import '../graphql/operations/fragments.graphql.dart';
import '../graphql/operations/queries.graphql.dart';
import '../graphql/operations/rewards.graphql.dart';
import '../theme.dart';
import '../widgets/error_box.dart';
import '../widgets/savanna/atoms.dart';
import '../widgets/savanna/category_style.dart';
import '../widgets/savanna/icons.dart';
import '../widgets/savanna/mascots.dart';
import '../widgets/savanna/parent_theme.dart';

class ApprovalsScreen extends ConsumerStatefulWidget {
  const ApprovalsScreen({super.key});

  @override
  ConsumerState<ApprovalsScreen> createState() => _ApprovalsScreenState();
}

class _ApprovalsScreenState extends ConsumerState<ApprovalsScreen> {
  String? _error;
  Fragment$AssignmentFields? _selectedChore;
  Fragment$RedemptionFields? _selectedRedemption;

  static final _df = DateFormat.jm();

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
    return ParentTheme(
      child: Builder(
        builder: (context) {
          final tokens = context.savanna;
          return Scaffold(
            backgroundColor: tokens.bg,
            appBar: AppBar(
              title: const Text('Approvals'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              ),
            ),
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
                final wide = MediaQuery.of(context).size.width >= 820;
                final listView = _buildList(
                  chores: chores,
                  redemptions: redemptions,
                  refetch: refetch,
                );
                if (!wide) return listView;
                return Row(
                  children: [
                    Expanded(flex: 5, child: listView),
                    Container(width: 1, color: tokens.line),
                    Expanded(
                      flex: 4,
                      child: _DetailPane(
                        chore: _selectedChore,
                        redemption: _selectedRedemption,
                        onApproveChore: _selectedChore == null
                            ? null
                            : () => _run(
                                  doc: documentNodeMutationApproveChore,
                                  vars: Variables$Mutation$ApproveChore(assignmentId: _selectedChore!.id).toJson(),
                                  onAfter: () {
                                    setState(() => _selectedChore = null);
                                    refetch?.call();
                                  },
                                ),
                        onRejectChore: _selectedChore == null
                            ? null
                            : () async {
                                final reason = await _askReason(context, 'Send back');
                                if (reason == null) return;
                                await _run(
                                  doc: documentNodeMutationRejectChore,
                                  vars: Variables$Mutation$RejectChore(
                                    assignmentId: _selectedChore!.id,
                                    reason: reason.isEmpty ? null : reason,
                                  ).toJson(),
                                  onAfter: () {
                                    setState(() => _selectedChore = null);
                                    refetch?.call();
                                  },
                                );
                              },
                        onApproveRedemption: _selectedRedemption == null
                            ? null
                            : () => _run(
                                  doc: documentNodeMutationApproveRedemption,
                                  vars: Variables$Mutation$ApproveRedemption(id: _selectedRedemption!.id).toJson(),
                                  onAfter: () {
                                    setState(() => _selectedRedemption = null);
                                    refetch?.call();
                                  },
                                ),
                        onDenyRedemption: _selectedRedemption == null
                            ? null
                            : () async {
                                final reason = await _askReason(context, 'Deny');
                                if (reason == null) return;
                                await _run(
                                  doc: documentNodeMutationDenyRedemption,
                                  vars: Variables$Mutation$DenyRedemption(
                                    id: _selectedRedemption!.id,
                                    reason: reason.isEmpty ? null : reason,
                                  ).toJson(),
                                  onAfter: () {
                                    setState(() => _selectedRedemption = null);
                                    refetch?.call();
                                  },
                                );
                              },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildList({
    required List<Fragment$AssignmentFields> chores,
    required List<Fragment$RedemptionFields> redemptions,
    required VoidCallback? refetch,
  }) {
    if (chores.isEmpty && redemptions.isEmpty) {
      return RefreshIndicator(
        onRefresh: () async => refetch?.call(),
        child: ListView(
          children: const [
            SizedBox(height: 180),
            _EmptyState(),
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: () async => refetch?.call(),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          if (_error != null) Padding(padding: const EdgeInsets.only(bottom: 12), child: ErrorBox(_error!)),
          _StatsRow(chores: chores.length, redemptions: redemptions.length),
          const SizedBox(height: 20),
          if (chores.isNotEmpty) ...[
            _SectionHeader(label: 'Chores to review', count: chores.length),
            const SizedBox(height: 10),
            for (final a in chores) Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _ChoreApprovalRow(
                a: a,
                time: _df.format((a.submittedAt ?? a.createdAt).toLocal()),
                selected: _selectedChore?.id == a.id,
                onTap: () => setState(() {
                  _selectedChore = a;
                  _selectedRedemption = null;
                }),
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
              ),
            ),
            const SizedBox(height: 16),
          ],
          if (redemptions.isNotEmpty) ...[
            _SectionHeader(label: 'Reward requests', count: redemptions.length),
            const SizedBox(height: 10),
            for (final r in redemptions) Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _RedemptionRow(
                r: r,
                time: _df.format(r.requestedAt.toLocal()),
                selected: _selectedRedemption?.id == r.id,
                onTap: () => setState(() {
                  _selectedRedemption = r;
                  _selectedChore = null;
                }),
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
            ),
          ],
        ],
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

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.chores, required this.redemptions});
  final int chores;
  final int redemptions;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    return Row(
      children: [
        Expanded(child: _StatCard(
          label: 'Chores waiting',
          value: '$chores',
          hint: chores == 0 ? 'All caught up' : 'Tap a row to review',
          color: tokens.accent,
        )),
        const SizedBox(width: 12),
        Expanded(child: _StatCard(
          label: 'Reward requests',
          value: '$redemptions',
          hint: redemptions == 0 ? 'Nothing pending' : 'Pending payouts',
          color: tokens.gold,
        )),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value, required this.hint, required this.color});
  final String label;
  final String value;
  final String hint;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: tokens.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: tokens.ink2,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: spaceGrotesk(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: color,
              letterSpacing: -0.8,
            ),
          ),
          Text(
            hint,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 12,
              color: tokens.ink2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label, required this.count});
  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w800,
            fontSize: 16,
            color: tokens.ink,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: tokens.accent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            '$count',
            style: spaceGrotesk(fontSize: 12, fontWeight: FontWeight.w800, color: tokens.accent),
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Mascot(kind: MascotKind.meerkat, size: 140),
        const SizedBox(height: 16),
        Text(
          "All caught up!",
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w900,
            fontSize: 24,
            color: context.savanna.ink,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'No approvals pending. Relax on the savanna.',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 14,
            color: context.savanna.ink2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _ChoreApprovalRow extends StatelessWidget {
  const _ChoreApprovalRow({
    required this.a,
    required this.time,
    required this.selected,
    required this.onTap,
    required this.onApprove,
    required this.onReject,
  });
  final Fragment$AssignmentFields a;
  final String time;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final style = categoryStyle(guessCategory(a.chore.title));
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: selected ? tokens.accent : tokens.line, width: selected ? 2 : 1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: style.bg,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(guessChoreEmoji(a.chore.title), style: const TextStyle(fontSize: 24)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      a.chore.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: tokens.ink,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          a.assignedTo.avatarEmoji,
                          style: const TextStyle(fontSize: 13),
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            '${a.assignedTo.name} · $time',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 12,
                              color: tokens.ink2,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              TokenPill(value: a.chore.tokenValue, size: TokenPillSize.sm),
              const SizedBox(width: 8),
              _IconAction(
                color: tokens.green,
                icon: Icons.check_rounded,
                tooltip: 'Approve',
                onPressed: onApprove,
              ),
              const SizedBox(width: 4),
              _IconAction(
                color: tokens.ink2,
                icon: Icons.close_rounded,
                tooltip: 'Send back',
                onPressed: onReject,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RedemptionRow extends StatelessWidget {
  const _RedemptionRow({
    required this.r,
    required this.time,
    required this.selected,
    required this.onTap,
    required this.onApprove,
    required this.onDeny,
  });
  final Fragment$RedemptionFields r;
  final String time;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onApprove;
  final VoidCallback onDeny;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: selected ? tokens.accent : tokens.line, width: selected ? 2 : 1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: tokens.gold.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.card_giftcard_rounded, color: tokens.gold, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      r.reward.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: tokens.ink,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${r.user.avatarEmoji} ${r.user.name} · $time',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        color: tokens.ink2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              TokenPill(value: r.tokensSpent, size: TokenPillSize.sm),
              const SizedBox(width: 8),
              _IconAction(
                color: tokens.green,
                icon: Icons.check_rounded,
                tooltip: 'Approve',
                onPressed: onApprove,
              ),
              const SizedBox(width: 4),
              _IconAction(
                color: tokens.ink2,
                icon: Icons.close_rounded,
                tooltip: 'Deny',
                onPressed: onDeny,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconAction extends StatelessWidget {
  const _IconAction({
    required this.color,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });
  final Color color;
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: color.withValues(alpha: 0.12),
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: SizedBox(
            width: 36,
            height: 36,
            child: Icon(icon, color: color, size: 20),
          ),
        ),
      ),
    );
  }
}

class _DetailPane extends StatelessWidget {
  const _DetailPane({
    required this.chore,
    required this.redemption,
    required this.onApproveChore,
    required this.onRejectChore,
    required this.onApproveRedemption,
    required this.onDenyRedemption,
  });
  final Fragment$AssignmentFields? chore;
  final Fragment$RedemptionFields? redemption;
  final VoidCallback? onApproveChore;
  final VoidCallback? onRejectChore;
  final VoidCallback? onApproveRedemption;
  final VoidCallback? onDenyRedemption;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    if (chore == null && redemption == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Text(
            'Pick an item to review',
            style: TextStyle(
              fontFamily: 'Nunito',
              color: tokens.ink2,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }
    final a = chore;
    if (a != null) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              a.chore.title,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w900,
                fontSize: 22,
                color: tokens.ink,
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                SavannaChip(label: guessCategory(a.chore.title)),
                SavannaChip(label: '${a.assignedTo.avatarEmoji} ${a.assignedTo.name}'),
                SavannaChip(label: '${a.chore.tokenValue} tokens'),
              ],
            ),
            if (a.chore.description != null && a.chore.description!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                a.chore.description!,
                style: TextStyle(fontFamily: 'Nunito', fontSize: 14, color: tokens.ink, fontWeight: FontWeight.w500),
              ),
            ],
            const SizedBox(height: 28),
            CuteButton(
              full: true,
              color: tokens.green,
              onPressed: onApproveChore,
              child: Text('Approve · +${a.chore.tokenValue} 🪙'),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onRejectChore,
                icon: const Icon(Icons.thumb_down_outlined),
                label: const Text('Send back'),
              ),
            ),
          ],
        ),
      );
    }
    final r = redemption!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            r.reward.title,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w900,
              fontSize: 22,
              color: tokens.ink,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              SavannaChip(label: '${r.user.avatarEmoji} ${r.user.name}'),
              SavannaChip(label: 'Cost ${r.tokensSpent}'),
            ],
          ),
          if (r.reward.description != null && r.reward.description!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              r.reward.description!,
              style: TextStyle(fontFamily: 'Nunito', fontSize: 14, color: tokens.ink, fontWeight: FontWeight.w500),
            ),
          ],
          const SizedBox(height: 28),
          CuteButton(
            full: true,
            color: tokens.green,
            icon: SavannaIcons.check(size: 18, color: Colors.white),
            onPressed: onApproveRedemption,
            child: const Text('Approve redemption'),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onDenyRedemption,
              icon: const Icon(Icons.close),
              label: const Text('Deny'),
            ),
          ),
        ],
      ),
    );
  }
}
