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
import '../graphql/schema.graphql.dart';
import '../theme.dart';
import '../widgets/error_box.dart';
import '../widgets/savanna/atoms.dart';
import '../widgets/savanna/category_style.dart';
import '../widgets/savanna/icons.dart';
import '../widgets/savanna/loot_box_overlay.dart';
import '../widgets/savanna/savanna_bg.dart';

class ChoreDetailScreen extends ConsumerStatefulWidget {
  const ChoreDetailScreen({super.key, required this.assignmentId});
  final String assignmentId;

  @override
  ConsumerState<ChoreDetailScreen> createState() => _ChoreDetailScreenState();
}

class _ChoreDetailScreenState extends ConsumerState<ChoreDetailScreen> {
  bool _busy = false;
  String? _error;
  bool _showLoot = false;
  int _lootTokens = 0;
  int _lootXp = 0;

  static final _df = DateFormat.yMMMd().add_jm();

  Future<void> _runMutation({
    required DocumentNode document,
    required Map<String, dynamic> variables,
    bool popOnDone = true,
  }) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    final result = await ref.read(graphqlClientProvider).mutate(MutationOptions(
          document: document,
          variables: variables,
        ));
    if (!mounted) return;
    if (result.hasException) {
      setState(() {
        _busy = false;
        _error = prettifyError(result.exception!);
      });
      return;
    }
    await ref.read(authControllerProvider.notifier).refreshMe();
    if (!mounted) return;
    if (popOnDone) {
      context.pop();
    } else {
      setState(() => _busy = false);
    }
  }

  Future<void> _submitChore(Fragment$AssignmentFields a) async {
    setState(() {
      _lootTokens = a.chore.tokenValue;
      _lootXp = a.chore.tokenValue * 4;
      _showLoot = true;
    });
    // Kick off the server submit in parallel — we'll still show the animation.
    unawaitedMutation(
      ref.read(graphqlClientProvider),
      document: documentNodeMutationSubmitChore,
      variables: Variables$Mutation$SubmitChore(assignmentId: widget.assignmentId).toJson(),
    );
  }

  Future<void> _reject(Fragment$AssignmentFields a) async {
    final reason = await showDialog<String>(
      context: context,
      builder: (_) {
        final ctrl = TextEditingController();
        return AlertDialog(
          title: const Text('Send back?'),
          content: TextField(
            controller: ctrl,
            decoration: const InputDecoration(hintText: 'Why? (optional)'),
            autofocus: true,
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            FilledButton(
              onPressed: () => Navigator.pop(context, ctrl.text),
              child: const Text('Send back'),
            ),
          ],
        );
      },
    );
    if (reason == null) return;
    await _runMutation(
      document: documentNodeMutationRejectChore,
      variables: Variables$Mutation$RejectChore(
        assignmentId: widget.assignmentId,
        reason: reason.trim().isEmpty ? null : reason.trim(),
      ).toJson(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);
    final tokens = context.savanna;
    return Scaffold(
      backgroundColor: tokens.bg,
      body: Query(
        options: QueryOptions(
          document: documentNodeQueryAssignments,
          fetchPolicy: FetchPolicy.cacheAndNetwork,
        ),
        builder: (result, {refetch, fetchMore}) {
          if (result.isLoading && result.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (result.hasException) {
            return Center(child: Text(result.exception!.toString()));
          }
          final parsed = Query$Assignments.fromJson(result.data!);
          final a = parsed.assignments.where((x) => x.id == widget.assignmentId).firstOrNull;
          if (a == null) {
            return const Center(child: Text('Assignment not found'));
          }
          final isMine = a.assignedTo.id == auth.me?.id;
          final canSubmit = isMine &&
              (a.status == Enum$ChoreStatus.pending ||
                  a.status == Enum$ChoreStatus.rejected);
          final canApprove = auth.isAdult && a.status == Enum$ChoreStatus.submitted;
          return Stack(
            children: [
              SavannaBg(
                variant: SavannaBgVariant.plain,
                child: SafeArea(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
                          child: Material(
                            color: Colors.white,
                            shape: const CircleBorder(),
                            elevation: 2,
                            shadowColor: const Color(0x143C2814),
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: () => context.pop(),
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: Center(
                                  child: Icon(Icons.arrow_back, color: tokens.ink, size: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                          children: [
                            _Hero(a: a),
                            const SizedBox(height: 16),
                            _RewardCards(tokens: a.chore.tokenValue),
                            const SizedBox(height: 12),
                            if (a.rejectReason != null && a.rejectReason!.isNotEmpty) ...[
                              _RejectCard(reason: a.rejectReason!),
                              const SizedBox(height: 12),
                            ],
                            if (a.dueDate != null) ...[
                              _MetaCard(label: 'Due', value: _df.format(a.dueDate!.toLocal())),
                              const SizedBox(height: 12),
                            ],
                            _StepsCard(description: a.chore.description),
                            const SizedBox(height: 20),
                            if (_error != null) Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: ErrorBox(_error!),
                            ),
                            if (canSubmit)
                              CuteButton(
                                full: true,
                                onPressed: _busy ? null : () => _submitChore(a),
                                child: const Text('I did it! 🎉'),
                              ),
                            if (canSubmit)
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Center(
                                  child: Text(
                                    'A grown-up will approve to credit tokens',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 12,
                                      color: tokens.ink2,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            if (canApprove) ...[
                              CuteButton(
                                full: true,
                                color: tokens.green,
                                onPressed: _busy
                                    ? null
                                    : () => _runMutation(
                                          document: documentNodeMutationApproveChore,
                                          variables: Variables$Mutation$ApproveChore(
                                            assignmentId: widget.assignmentId,
                                          ).toJson(),
                                        ),
                                child: Text('Approve · +${a.chore.tokenValue} 🪙'),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  onPressed: _busy ? null : () => _reject(a),
                                  icon: const Icon(Icons.thumb_down_outlined),
                                  label: const Text('Send back'),
                                ),
                              ),
                            ],
                            if (a.status == Enum$ChoreStatus.submitted && isMine)
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(context.density.radius),
                                  border: Border.all(color: tokens.line),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.hourglass_top_rounded, color: tokens.ink2),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        'Sent for approval — a grown-up will check.',
                                        style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w700,
                                          color: tokens.ink,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (a.status == Enum$ChoreStatus.approved)
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: tokens.green.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(context.density.radius),
                                ),
                                child: Row(
                                  children: [
                                    SavannaIcons.check(size: 20, color: tokens.green),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        'Approved! Tokens credited.',
                                        style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w800,
                                          color: tokens.green,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_showLoot)
                Positioned.fill(
                  child: LootBoxOverlay(
                    tokens: _lootTokens,
                    xp: _lootXp,
                    onDone: () {
                      if (!mounted) return;
                      setState(() => _showLoot = false);
                      context.pop();
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.a});
  final Fragment$AssignmentFields a;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final style = categoryStyle(guessCategory(a.chore.title));
    final emoji = guessChoreEmoji(a.chore.title);
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
      decoration: BoxDecoration(
        color: style.bg,
        borderRadius: BorderRadius.circular(context.density.radius),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 72, height: 1)),
          const SizedBox(height: 12),
          Text(
            a.chore.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w900,
              fontSize: 28,
              color: tokens.ink,
              letterSpacing: -0.6,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              SavannaChip(
                label: guessCategory(a.chore.title),
                background: const Color(0x99FFFFFF),
                color: style.ink,
              ),
              SavannaChip(
                label: _recurrenceLabel(a.chore.recurrence),
                background: const Color(0x99FFFFFF),
                color: style.ink,
              ),
              if (a.assignedTo.name.isNotEmpty)
                SavannaChip(
                  label: 'For ${a.assignedTo.name}',
                  background: const Color(0x99FFFFFF),
                  color: style.ink,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

String _recurrenceLabel(Enum$Recurrence r) => switch (r) {
      Enum$Recurrence.daily => '📅 Daily',
      Enum$Recurrence.weekly => '📅 Weekly',
      Enum$Recurrence.one_off => '✨ One-off',
      _ => '✨ One-off',
    };

class _RewardCards extends StatelessWidget {
  const _RewardCards({required this.tokens});
  final int tokens;

  @override
  Widget build(BuildContext context) {
    final t = context.savanna;
    return Row(
      children: [
        Expanded(
          child: _RewardCard(
            label: 'Tokens',
            value: '+$tokens',
            icon: SavannaIcons.coin(size: 26, fill: t.gold),
            background: const Color(0xFFFFF5D8),
            color: t.gold,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _RewardCard(
            label: 'XP',
            value: '+${tokens * 4}',
            icon: SavannaIcons.star(size: 26, fill: t.accent),
            background: const Color(0xFFFFE5DC),
            color: t.accent,
          ),
        ),
      ],
    );
  }
}

class _RewardCard extends StatelessWidget {
  const _RewardCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.background,
    required this.color,
  });

  final String label;
  final String value;
  final Widget icon;
  final Color background;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(context.density.radius),
      ),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 12),
          Expanded(
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
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  value,
                  style: spaceGrotesk(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: color,
                    letterSpacing: -0.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepsCard extends StatelessWidget {
  const _StepsCard({required this.description});
  final String? description;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final steps = _deriveSteps(description);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 2),
          child: Text(
            'How to do it',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w800,
              fontSize: 15,
              color: tokens.ink,
              letterSpacing: -0.2,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(context.density.radius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Column(
            children: [
              for (int i = 0; i < steps.length; i++)
                Container(
                  decoration: BoxDecoration(
                    border: i < steps.length - 1
                        ? Border(bottom: BorderSide(color: tokens.line))
                        : null,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  child: Row(
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(color: tokens.bg, shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: Text(
                          '${i + 1}',
                          style: spaceGrotesk(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: tokens.ink2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          steps[i],
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 15,
                            color: tokens.ink,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

List<String> _deriveSteps(String? description) {
  if (description == null || description.trim().isEmpty) {
    return const ['Take your time — do it carefully'];
  }
  final lines = description
      .split(RegExp(r'\r?\n|·|•'))
      .map((s) => s.trim())
      .where((s) => s.isNotEmpty)
      .toList();
  if (lines.length <= 1) return [description.trim()];
  return lines;
}

class _MetaCard extends StatelessWidget {
  const _MetaCard({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.density.radius),
        border: Border.all(color: tokens.line),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 13,
              color: tokens.ink2,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w800,
                color: tokens.ink,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RejectCard extends StatelessWidget {
  const _RejectCard({required this.reason});
  final String reason;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: tokens.accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(context.density.radius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.feedback_outlined, color: tokens.accent),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sent back',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w800,
                    color: tokens.accent,
                  ),
                ),
                Text(
                  reason,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                    color: tokens.ink,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void unawaitedMutation(
  GraphQLClient client, {
  required DocumentNode document,
  required Map<String, dynamic> variables,
}) {
  // Fire-and-forget mutation. Errors are logged to the GraphQL client's
  // exception handler but intentionally not surfaced here — the animation
  // is the user-visible success signal; the actual state will converge on
  // the next refetch.
  client.mutate(MutationOptions(document: document, variables: variables));
}
