import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import '../graphql/operations/fragments.graphql.dart';
import '../graphql/operations/queries.graphql.dart';
import '../graphql/schema.graphql.dart';
import '../theme.dart';
import '../widgets/savanna/atoms.dart';
import '../widgets/savanna/category_style.dart';
import '../widgets/savanna/icons.dart';
import '../widgets/savanna/savanna_bg.dart';

/// Reminders inbox — compact urgent/later list of open chores.
/// Uses the active assignments as the source for now.
class RemindersScreen extends ConsumerWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokens = context.savanna;
    return Scaffold(
      appBar: AppBar(title: const Text('Reminders')),
      body: SavannaBg(
        variant: SavannaBgVariant.plain,
        child: SafeArea(
          child: Query(
            options: QueryOptions(
              document: documentNodeQueryAssignments,
              variables: Variables$Query$Assignments(mineOnly: true).toJson(),
              fetchPolicy: FetchPolicy.cacheAndNetwork,
            ),
            builder: (result, {refetch, fetchMore}) {
              if (result.isLoading && result.data == null) {
                return const Center(child: CircularProgressIndicator());
              }
              final assignments = result.data == null
                  ? <Fragment$AssignmentFields>[]
                  : Query$Assignments.fromJson(result.data!).assignments;
              final now = DateTime.now();
              final urgent = <Fragment$AssignmentFields>[];
              final later = <Fragment$AssignmentFields>[];
              for (final a in assignments) {
                if (a.status == Enum$ChoreStatus.approved) continue;
                final due = a.dueDate?.toLocal();
                if (due == null) {
                  later.add(a);
                } else if (due.isBefore(now.add(const Duration(hours: 3)))) {
                  urgent.add(a);
                } else {
                  later.add(a);
                }
              }
              return RefreshIndicator(
                onRefresh: () async => refetch?.call(),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
                  children: [
                    _StreakBanner(),
                    const SizedBox(height: 16),
                    if (urgent.isNotEmpty) ...[
                      _SectionLabel(label: 'Now', accent: tokens.accent),
                      const SizedBox(height: 8),
                      for (final a in urgent)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _ReminderRow(a: a, urgent: true, onTap: () => context.push('/chore/${a.id}')),
                        ),
                      const SizedBox(height: 8),
                    ],
                    if (later.isNotEmpty) ...[
                      _SectionLabel(label: 'Later today', accent: tokens.ink2),
                      const SizedBox(height: 8),
                      for (final a in later)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _ReminderRow(a: a, urgent: false, onTap: () => context.push('/chore/${a.id}')),
                        ),
                    ],
                    if (urgent.isEmpty && later.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 60),
                        child: Center(
                          child: Text(
                            'All caught up. Relax on the savanna. 🌿',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              color: tokens.ink2,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    _QuietHoursRow(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label, required this.accent});
  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 6, height: 6, decoration: BoxDecoration(color: accent, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: context.savanna.ink2,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

class _ReminderRow extends StatelessWidget {
  const _ReminderRow({required this.a, required this.urgent, required this.onTap});
  final Fragment$AssignmentFields a;
  final bool urgent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final style = categoryStyle(guessCategory(a.chore.title));
    final emoji = guessChoreEmoji(a.chore.title);
    final due = a.dueDate?.toLocal();
    final dueLabel = due == null ? 'No time set' : DateFormat.jm().format(due);
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(color: style.bg, borderRadius: BorderRadius.circular(12)),
                alignment: Alignment.center,
                child: Text(emoji, style: const TextStyle(fontSize: 22)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      a.chore.title,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: tokens.ink,
                        letterSpacing: -0.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$dueLabel · ${a.chore.tokenValue} 🪙',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: tokens.ink2,
                      ),
                    ),
                  ],
                ),
              ),
              if (urgent)
                CuteButton(
                  size: CuteButtonSize.md,
                  onPressed: onTap,
                  child: const Text('Do it'),
                )
              else
                IconButton(
                  icon: Icon(Icons.snooze, color: tokens.ink2),
                  tooltip: 'Snooze',
                  onPressed: () {},
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StreakBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [tokens.accent, tokens.gold]),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          SavannaIcons.flame(size: 22),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Streak at risk — 1 chore left to keep the fire alive',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w800,
                fontSize: 14,
                color: Colors.white,
                letterSpacing: -0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuietHoursRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: tokens.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: tokens.line),
      ),
      child: Row(
        children: [
          Icon(Icons.nightlight_outlined, color: tokens.ink2),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Quiet hours · 8:30pm – 7:00am',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
                color: tokens.ink,
                fontSize: 14,
              ),
            ),
          ),
          Switch.adaptive(value: true, onChanged: (_) {}),
        ],
      ),
    );
  }
}
