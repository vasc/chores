import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import '../auth/auth_controller.dart';
import '../graphql/operations/fragments.graphql.dart';
import '../graphql/operations/queries.graphql.dart';
import '../graphql/schema.graphql.dart';
import '../theme.dart';
import '../widgets/savanna/atoms.dart';
import '../widgets/savanna/category_style.dart';
import '../widgets/savanna/icons.dart';
import '../widgets/savanna/mascots.dart';
import '../widgets/savanna/savanna_bg.dart';

class HomeChoresScreen extends ConsumerWidget {
  const HomeChoresScreen({super.key});

  static final _dateFmt = DateFormat('EEEE · MMM d');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    final me = auth.me;
    if (me == null) return const SizedBox.shrink();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          if (auth.isAdult)
            IconButton(
              tooltip: 'Approvals',
              icon: const Icon(Icons.fact_check_outlined),
              onPressed: () => context.push('/approvals'),
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
      body: SavannaBg(
        variant: SavannaBgVariant.day,
        child: Query(
          options: QueryOptions(
            document: documentNodeQueryAssignments,
            variables: Variables$Query$Assignments(mineOnly: !auth.isAdult).toJson(),
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
            final assignments = parsed.assignments;
            final active = assignments.where((a) =>
                a.status == Enum$ChoreStatus.pending ||
                a.status == Enum$ChoreStatus.submitted ||
                a.status == Enum$ChoreStatus.rejected).toList();
            final done = assignments
                .where((a) => a.status == Enum$ChoreStatus.approved)
                .toList();
            final doneCount = done.length;

            return RefreshIndicator(
              onRefresh: () async => refetch?.call(),
              child: ListView(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 8,
                  bottom: 120,
                ),
                children: [
                  _TopBar(me: me, dateLabel: _dateFmt.format(DateTime.now())),
                  const SizedBox(height: 12),
                  _XpTokenCard(me: me, doneCount: doneCount),
                  const SizedBox(height: 16),
                  _DailyQuestBanner(doneToday: doneCount.clamp(0, 3), goal: 3),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Today's chores",
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: context.savanna.ink,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                        Text(
                          '${active.length} left',
                          style: spaceGrotesk(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: context.savanna.ink2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (assignments.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: context.savanna.card,
                          borderRadius: BorderRadius.circular(context.density.radius),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'No chores yet. Enjoy the savanna. 🌾',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                            color: context.savanna.ink2,
                          ),
                        ),
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          for (final a in active) ...[
                            _ChoreRow(a: a, onTap: () => context.push('/chore/${a.id}')),
                            SizedBox(height: context.density.gap),
                          ],
                          for (final a in done) ...[
                            _ChoreRow(a: a, onTap: () => context.push('/chore/${a.id}')),
                            SizedBox(height: context.density.gap),
                          ],
                        ],
                      ),
                    ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _RewardsTeaser(onTap: () => context.push('/rewards')),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const _BottomTabs(active: _Tab.home),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.me, required this.dateLabel});
  final Fragment$UserFields me;
  final String dateLabel;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final mascot = mascotFromEmoji(me.avatarEmoji);
    final streak = _derivedStreak(me.tokenBalance);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(22),
            onTap: () => context.push('/buddy'),
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Color(0x143C2814), blurRadius: 6, offset: Offset(0, 2)),
                ],
              ),
              alignment: Alignment.center,
              child: mascot != null
                  ? Mascot(kind: mascot, size: 40)
                  : Text(me.avatarEmoji, style: const TextStyle(fontSize: 26)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Hey, ${me.name}!',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: tokens.ink,
                    letterSpacing: -0.3,
                    height: 1.1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  dateLabel,
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
          StreakPill(days: streak),
        ],
      ),
    );
  }
}

class _XpTokenCard extends StatelessWidget {
  const _XpTokenCard({required this.me, required this.doneCount});
  final Fragment$UserFields me;
  final int doneCount;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final level = _derivedLevel(me.tokenBalance);
    final xpMax = _derivedXpMax(level);
    final xp = _derivedXp(me.tokenBalance, level);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: EdgeInsets.all(context.density.cardPad),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.density.radius),
          boxShadow: const [
            BoxShadow(color: Color(0x0F3C2814), blurRadius: 14, offset: Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            Expanded(child: XpBar(xp: xp, max: xpMax, level: level)),
            const SizedBox(width: 14),
            Container(width: 1, height: 36, color: tokens.line),
            const SizedBox(width: 14),
            TokenPill(value: me.tokenBalance),
          ],
        ),
      ),
    );
  }
}

class _DailyQuestBanner extends StatelessWidget {
  const _DailyQuestBanner({required this.doneToday, required this.goal});
  final int doneToday;
  final int goal;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final pct = goal == 0 ? 0.0 : (doneToday / goal).clamp(0.0, 1.0);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.density.radius),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [tokens.green, shade(tokens.green, 20)],
          ),
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              right: -10,
              top: -10,
              child: Opacity(
                opacity: 0.2,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SavannaIcons.quest(size: 16, color: Colors.white),
                    const SizedBox(width: 6),
                    Text(
                      'DAILY QUEST',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Finish 3 chores for a mystery box!',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                    color: Colors.white,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    height: 8,
                    color: const Color(0x33000000),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: pct,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: tokens.gold, borderRadius: BorderRadius.circular(999)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$doneToday / $goal done',
                      style: spaceGrotesk(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withValues(alpha: 0.95),
                      ),
                    ),
                    Text(
                      '+50 XP · 🎁 Loot',
                      style: spaceGrotesk(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withValues(alpha: 0.95),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ChoreRow extends StatelessWidget {
  const _ChoreRow({required this.a, required this.onTap});
  final Fragment$AssignmentFields a;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final category = guessCategory(a.chore.title);
    final style = categoryStyle(category);
    final emoji = guessChoreEmoji(a.chore.title);
    final isDone = a.status == Enum$ChoreStatus.approved;
    final isPending = a.status == Enum$ChoreStatus.submitted;
    return Material(
      color: isDone ? Colors.white.withValues(alpha: 0.55) : Colors.white,
      borderRadius: BorderRadius.circular(context.density.radius),
      child: InkWell(
        borderRadius: BorderRadius.circular(context.density.radius),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(context.density.cardPad),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: style.bg,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(emoji, style: const TextStyle(fontSize: 26)),
              ),
              const SizedBox(width: 12),
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
                        fontSize: 16,
                        color: tokens.ink,
                        letterSpacing: -0.2,
                        height: 1.2,
                        decoration: isDone ? TextDecoration.lineThrough : null,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        SavannaChip(
                          label: category,
                          background: style.chip,
                          color: style.ink,
                        ),
                        if (a.assignedTo.name.isNotEmpty) ...[
                          const SizedBox(width: 6),
                          SavannaChip(
                            label: a.assignedTo.name,
                            background: const Color(0x143C2814),
                            color: tokens.ink2,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (isDone)
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(color: tokens.green, shape: BoxShape.circle),
                      alignment: Alignment.center,
                      child: SavannaIcons.check(size: 20, color: Colors.white),
                    )
                  else
                    TokenPill(value: a.chore.tokenValue, size: TokenPillSize.sm),
                  if (isPending) ...[
                    const SizedBox(height: 4),
                    Text(
                      '⏳ AWAITING',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: tokens.ink2,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RewardsTeaser extends StatelessWidget {
  const _RewardsTeaser({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    return Material(
      borderRadius: BorderRadius.circular(context.density.radius),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(context.density.radius),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.density.radius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [tokens.accent, tokens.gold],
            ),
            boxShadow: [
              BoxShadow(color: tokens.accent.withValues(alpha: 0.25), blurRadius: 16, offset: const Offset(0, 6)),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: SavannaIcons.gift(size: 26, color: Colors.white),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Rewards Shop',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                        color: Colors.white,
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(height: 1),
                    Text(
                      'Spend your tokens on treats',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SavannaIcons.chevron(size: 14, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

enum _Tab { home, quests, shop, buddy }

class _BottomTabs extends StatelessWidget {
  const _BottomTabs({required this.active});
  final _Tab active;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final entries = <({_Tab id, String label, Widget Function(double, Color) icon, VoidCallback? onTap})>[
      (
        id: _Tab.home,
        label: 'Today',
        icon: (s, c) => SavannaIcons.home(size: s, color: c),
        onTap: () {},
      ),
      (
        id: _Tab.quests,
        label: 'Quests',
        icon: (s, c) => SavannaIcons.quest(size: s, color: c),
        onTap: () => context.push('/reminders'),
      ),
      (
        id: _Tab.shop,
        label: 'Shop',
        icon: (s, c) => SavannaIcons.gift(size: s, color: c),
        onTap: () => context.push('/rewards'),
      ),
      (
        id: _Tab.buddy,
        label: 'Buddy',
        icon: (s, c) => SavannaIcons.heart(size: s, color: c),
        onTap: () => context.push('/buddy'),
      ),
    ];
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.92),
          border: Border(top: BorderSide(color: tokens.line)),
        ),
        child: Row(
          children: [
            for (final e in entries)
              Expanded(
                child: InkWell(
                  onTap: e.onTap,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        e.icon(24, e.id == active ? tokens.accent : tokens.ink2),
                        const SizedBox(height: 3),
                        Text(
                          e.label,
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: e.id == active ? tokens.accent : tokens.ink2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// --- Derived game metrics (no backend support yet) ---------------------

int _derivedLevel(int tokens) => (tokens ~/ 60) + 1;
int _derivedXpMax(int level) => 100 + (level - 1) * 20;
int _derivedXp(int tokens, int level) => tokens % 60 * 2;
int _derivedStreak(int tokens) {
  if (tokens <= 0) return 0;
  if (tokens < 10) return 2;
  if (tokens < 40) return 5;
  if (tokens < 80) return 9;
  return 12;
}
