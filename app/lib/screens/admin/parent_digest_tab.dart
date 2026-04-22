import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import '../../graphql/operations/fragments.graphql.dart';
import '../../graphql/operations/queries.graphql.dart';
import '../../graphql/schema.graphql.dart';
import '../../theme.dart';
import '../../widgets/savanna/category_style.dart';
import '../../widgets/savanna/icons.dart';

class ParentDigestTab extends ConsumerWidget {
  const ParentDigestTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Query(
      options: QueryOptions(document: documentNodeQueryHousehold, fetchPolicy: FetchPolicy.cacheAndNetwork),
      builder: (hh, {refetch, fetchMore}) {
        final refetchHousehold = refetch;
        return Query(
          options: QueryOptions(document: documentNodeQueryAssignments, fetchPolicy: FetchPolicy.cacheAndNetwork),
          builder: (aResult, {refetch, fetchMore}) {
            final refetchA = refetch;
            if (aResult.isLoading && aResult.data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            final members = hh.data == null
                ? <Fragment$UserFields>[]
                : Query$Household.fromJson(hh.data!).members;
            final kids = members.where((m) => m.role == Enum$Role.child).toList();
            final assignments = aResult.data == null
                ? <Fragment$AssignmentFields>[]
                : Query$Assignments.fromJson(aResult.data!).assignments;

            final now = DateTime.now();
            final weekStart = DateTime(now.year, now.month, now.day)
                .subtract(Duration(days: now.weekday - 1));

            // Tokens earned per day (last 7) per kid
            final days = List.generate(7, (i) => weekStart.add(Duration(days: i)));
            final dayLabels = days.map((d) => DateFormat('EEE').format(d).substring(0, 3)).toList();

            final earnedByDay = <DateTime, List<Fragment$AssignmentFields>>{
              for (final d in days) d: <Fragment$AssignmentFields>[],
            };
            final earnedByKid = <String, int>{for (final k in kids) k.id: 0};
            final categoryTotals = <String, int>{};

            for (final a in assignments) {
              if (a.status != Enum$ChoreStatus.approved) continue;
              final when = a.approvedAt?.toLocal();
              if (when == null) continue;
              final day = DateTime(when.year, when.month, when.day);
              if (day.isBefore(weekStart)) continue;
              if (earnedByDay.containsKey(day)) {
                earnedByDay[day]!.add(a);
              }
              earnedByKid[a.assignedTo.id] = (earnedByKid[a.assignedTo.id] ?? 0) + a.chore.tokenValue;
              final cat = guessCategory(a.chore.title);
              categoryTotals[cat] = (categoryTotals[cat] ?? 0) + a.chore.tokenValue;
            }
            final weekTotal = earnedByKid.values.fold<int>(0, (a, b) => a + b);
            final maxDay = earnedByDay.values
                .map((l) => l.fold<int>(0, (a, b) => a + b.chore.tokenValue))
                .fold<int>(0, (a, b) => a > b ? a : b);

            return RefreshIndicator(
              onRefresh: () async {
                refetchHousehold?.call();
                refetchA?.call();
              },
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _WeekHeader(weekStart: weekStart, weekTotal: weekTotal),
                  const SizedBox(height: 20),
                  _BarChart(
                    days: days,
                    labels: dayLabels,
                    earnedByDay: earnedByDay,
                    kids: kids,
                    maxDay: maxDay,
                  ),
                  const SizedBox(height: 24),
                  _KidTotalsBar(kids: kids, earnedByKid: earnedByKid, weekTotal: weekTotal),
                  const SizedBox(height: 24),
                  _CategoryMix(categoryTotals: categoryTotals),
                  const SizedBox(height: 24),
                  _Highlights(kids: kids, earnedByKid: earnedByKid),
                  const SizedBox(height: 40),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _WeekHeader extends StatelessWidget {
  const _WeekHeader({required this.weekStart, required this.weekTotal});
  final DateTime weekStart;
  final int weekTotal;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final end = weekStart.add(const Duration(days: 6));
    final label = '${DateFormat.MMMd().format(weekStart)} – ${DateFormat.MMMd().format(end)}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'WEEK OF',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.4,
            color: tokens.ink2,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w900,
            fontSize: 26,
            color: tokens.ink,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            SavannaIcons.sparkle(size: 16, color: tokens.gold),
            const SizedBox(width: 6),
            Text(
              '$weekTotal tokens earned this week',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
                color: tokens.ink,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BarChart extends StatelessWidget {
  const _BarChart({
    required this.days,
    required this.labels,
    required this.earnedByDay,
    required this.kids,
    required this.maxDay,
  });
  final List<DateTime> days;
  final List<String> labels;
  final Map<DateTime, List<Fragment$AssignmentFields>> earnedByDay;
  final List<Fragment$UserFields> kids;
  final int maxDay;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final colors = [tokens.accent, tokens.gold, tokens.green, tokens.sky, tokens.brown];
    final kidColor = {for (var i = 0; i < kids.length; i++) kids[i].id: colors[i % colors.length]};
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: tokens.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tokens per day',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w800,
              fontSize: 15,
              color: tokens.ink,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 140,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var i = 0; i < days.length; i++)
                  Expanded(
                    child: _DayBar(
                      label: labels[i],
                      events: earnedByDay[days[i]] ?? const [],
                      maxDay: maxDay,
                      kidColor: kidColor,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              for (var i = 0; i < kids.length; i++)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: colors[i % colors.length],
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      kids[i].name,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: tokens.ink2,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DayBar extends StatelessWidget {
  const _DayBar({
    required this.label,
    required this.events,
    required this.maxDay,
    required this.kidColor,
  });
  final String label;
  final List<Fragment$AssignmentFields> events;
  final int maxDay;
  final Map<String, Color> kidColor;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final total = events.fold<int>(0, (a, b) => a + b.chore.tokenValue);
    final height = maxDay == 0 ? 0.0 : (total / maxDay) * 100;

    // Group events by kid for stacked segments
    final segments = <String, int>{};
    for (final a in events) {
      segments[a.assignedTo.id] = (segments[a.assignedTo.id] ?? 0) + a.chore.tokenValue;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (total > 0)
            Text(
              '$total',
              style: spaceGrotesk(fontSize: 11, fontWeight: FontWeight.w800, color: tokens.ink),
            ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: height.clamp(1, 100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: total == 0 ? tokens.line : null,
            ),
            child: total == 0
                ? null
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      for (final entry in segments.entries)
                        Expanded(
                          flex: entry.value * 100,
                          child: Container(color: kidColor[entry.key] ?? tokens.ink2),
                        ),
                    ],
                  ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: tokens.ink2,
            ),
          ),
        ],
      ),
    );
  }
}

class _KidTotalsBar extends StatelessWidget {
  const _KidTotalsBar({required this.kids, required this.earnedByKid, required this.weekTotal});
  final List<Fragment$UserFields> kids;
  final Map<String, int> earnedByKid;
  final int weekTotal;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final palette = [tokens.accent, tokens.gold, tokens.green, tokens.sky, tokens.brown];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: tokens.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Per-kid progress',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w800,
              fontSize: 15,
              color: tokens.ink,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < kids.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  SizedBox(
                    width: 90,
                    child: Text(
                      '${kids[i].avatarEmoji} ${kids[i].name}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        color: tokens.ink,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: weekTotal == 0 ? 0 : (earnedByKid[kids[i].id] ?? 0) / weekTotal,
                        minHeight: 8,
                        backgroundColor: const Color(0x14000000),
                        color: palette[i % palette.length],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${earnedByKid[kids[i].id] ?? 0}',
                    style: spaceGrotesk(fontSize: 14, fontWeight: FontWeight.w800, color: tokens.ink),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CategoryMix extends StatelessWidget {
  const _CategoryMix({required this.categoryTotals});
  final Map<String, int> categoryTotals;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final total = categoryTotals.values.fold<int>(0, (a, b) => a + b);
    if (total == 0) {
      return const SizedBox.shrink();
    }
    final entries = categoryTotals.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: tokens.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category mix',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w800,
              fontSize: 15,
              color: tokens.ink,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: SizedBox(
              height: 12,
              child: Row(
                children: [
                  for (final e in entries)
                    Expanded(
                      flex: e.value,
                      child: Container(color: categoryStyle(e.key).ink),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 6,
            children: [
              for (final e in entries)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: categoryStyle(e.key).ink,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${e.key} · ${e.value}',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: tokens.ink2,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Highlights extends StatelessWidget {
  const _Highlights({required this.kids, required this.earnedByKid});
  final List<Fragment$UserFields> kids;
  final Map<String, int> earnedByKid;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final ranked = [...kids]..sort((a, b) => (earnedByKid[b.id] ?? 0).compareTo(earnedByKid[a.id] ?? 0));
    if (ranked.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [tokens.accent, tokens.gold]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HIGHLIGHTS',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w800,
              fontSize: 11,
              letterSpacing: 1.4,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${ranked.first.avatarEmoji} ${ranked.first.name} leads the week '
            'with ${earnedByKid[ranked.first.id] ?? 0} tokens.',
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: Colors.white,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }
}
