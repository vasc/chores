import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import '../../graphql/operations/fragments.graphql.dart';
import '../../graphql/operations/queries.graphql.dart';
import '../../graphql/schema.graphql.dart';
import '../../theme.dart';
import '../../widgets/savanna/atoms.dart';

class ParentActivityTab extends ConsumerWidget {
  const ParentActivityTab({super.key});

  static final _dayFmt = DateFormat.MMMEd();
  static final _timeFmt = DateFormat.jm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Query(
      options: QueryOptions(
        document: documentNodeQueryAssignments,
        fetchPolicy: FetchPolicy.cacheAndNetwork,
      ),
      builder: (choresResult, {refetch, fetchMore}) {
        final refetchChores = refetch;
        return Query(
          options: QueryOptions(
            document: documentNodeQueryRedemptions,
            fetchPolicy: FetchPolicy.cacheAndNetwork,
          ),
          builder: (redResult, {refetch, fetchMore}) {
            final refetchRed = refetch;
            if (choresResult.isLoading && choresResult.data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            final chores = choresResult.data == null
                ? <Fragment$AssignmentFields>[]
                : Query$Assignments.fromJson(choresResult.data!).assignments;
            final redemptions = redResult.data == null
                ? <Fragment$RedemptionFields>[]
                : Query$Redemptions.fromJson(redResult.data!).redemptions;

            final events = <_ActivityEvent>[];
            for (final a in chores) {
              if (a.status == Enum$ChoreStatus.approved && a.approvedAt != null) {
                events.add(_ActivityEvent(
                  when: a.approvedAt!,
                  kind: _EventKind.approvedChore,
                  title: a.chore.title,
                  who: a.assignedTo,
                  tokens: a.chore.tokenValue,
                ));
              } else if (a.status == Enum$ChoreStatus.submitted && a.submittedAt != null) {
                events.add(_ActivityEvent(
                  when: a.submittedAt!,
                  kind: _EventKind.submittedChore,
                  title: a.chore.title,
                  who: a.assignedTo,
                  tokens: a.chore.tokenValue,
                ));
              }
            }
            for (final r in redemptions) {
              events.add(_ActivityEvent(
                when: r.decidedAt ?? r.requestedAt,
                kind: r.status == Enum$RedemptionStatus.fulfilled
                    ? _EventKind.fulfilledRedemption
                    : r.status == Enum$RedemptionStatus.approved
                        ? _EventKind.approvedRedemption
                        : r.status == Enum$RedemptionStatus.denied
                            ? _EventKind.deniedRedemption
                            : _EventKind.requestedRedemption,
                title: r.reward.title,
                who: r.user,
                tokens: r.tokensSpent,
              ));
            }
            events.sort((a, b) => b.when.compareTo(a.when));

            final byDay = <String, List<_ActivityEvent>>{};
            for (final e in events) {
              final key = _dayFmt.format(e.when.toLocal());
              byDay.putIfAbsent(key, () => []).add(e);
            }

            return RefreshIndicator(
              onRefresh: () async {
                refetchChores?.call();
                refetchRed?.call();
              },
              child: events.isEmpty
                  ? ListView(
                      children: [
                        const SizedBox(height: 120),
                        Center(
                          child: Text(
                            'No activity yet — encourage a chore.',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              color: context.savanna.ink2,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    )
                  : ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        for (final entry in byDay.entries) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 12, bottom: 8),
                            child: Text(
                              entry.key.toUpperCase(),
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: context.savanna.ink2,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          for (final ev in entry.value)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: _EventRow(event: ev, time: _timeFmt.format(ev.when.toLocal())),
                            ),
                        ],
                      ],
                    ),
            );
          },
        );
      },
    );
  }
}

enum _EventKind {
  approvedChore,
  submittedChore,
  requestedRedemption,
  approvedRedemption,
  fulfilledRedemption,
  deniedRedemption,
}

class _ActivityEvent {
  _ActivityEvent({
    required this.when,
    required this.kind,
    required this.title,
    required this.who,
    required this.tokens,
  });
  final DateTime when;
  final _EventKind kind;
  final String title;
  final Fragment$UserFields who;
  final int tokens;
}

class _EventRow extends StatelessWidget {
  const _EventRow({required this.event, required this.time});
  final _ActivityEvent event;
  final String time;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final (icon, color, summary) = _presentation(event, tokens);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: tokens.line),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${event.who.avatarEmoji} ${event.who.name} ',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w800,
                          color: tokens.ink,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: summary,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                          color: tokens.ink,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: ' "${event.title}"',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w800,
                          color: tokens.ink,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  time,
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
          TokenPill(value: event.tokens, size: TokenPillSize.sm),
        ],
      ),
    );
  }
}

(IconData, Color, String) _presentation(_ActivityEvent e, SavannaTokens t) {
  switch (e.kind) {
    case _EventKind.approvedChore:
      return (Icons.check_circle_outline, t.green, 'earned tokens for');
    case _EventKind.submittedChore:
      return (Icons.hourglass_top_rounded, t.gold, 'sent for review');
    case _EventKind.requestedRedemption:
      return (Icons.card_giftcard_outlined, t.gold, 'wants to redeem');
    case _EventKind.approvedRedemption:
      return (Icons.check_circle_outline, t.green, 'redeemed');
    case _EventKind.fulfilledRedemption:
      return (Icons.emoji_events_outlined, t.green, 'enjoyed');
    case _EventKind.deniedRedemption:
      return (Icons.block, t.accent, 'was denied');
  }
}

