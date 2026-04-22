import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import '../../graphql/operations/fragments.graphql.dart';
import '../../graphql/operations/queries.graphql.dart';
import '../../graphql/schema.graphql.dart';
import '../../theme.dart';
import '../../widgets/savanna/atoms.dart';
import '../../widgets/savanna/mascots.dart';

class ParentLedgerTab extends ConsumerWidget {
  const ParentLedgerTab({super.key});

  static final _fmt = DateFormat.MMMd();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Query(
      options: QueryOptions(document: documentNodeQueryHousehold, fetchPolicy: FetchPolicy.cacheAndNetwork),
      builder: (householdResult, {refetch, fetchMore}) {
        final refetchHousehold = refetch;
        return Query(
          options: QueryOptions(document: documentNodeQueryAssignments, fetchPolicy: FetchPolicy.cacheAndNetwork),
          builder: (assignmentsResult, {refetch, fetchMore}) {
            final refetchA = refetch;
            return Query(
              options: QueryOptions(document: documentNodeQueryRedemptions, fetchPolicy: FetchPolicy.cacheAndNetwork),
              builder: (redResult, {refetch, fetchMore}) {
                final refetchR = refetch;
                if ((householdResult.isLoading && householdResult.data == null) ||
                    (assignmentsResult.isLoading && assignmentsResult.data == null)) {
                  return const Center(child: CircularProgressIndicator());
                }
                final household = householdResult.data == null
                    ? null
                    : Query$Household.fromJson(householdResult.data!);
                if (household == null) return const SizedBox.shrink();
                final members = household.members;
                final kids = members.where((m) => m.role == Enum$Role.child).toList();
                final assignments = assignmentsResult.data == null
                    ? <Fragment$AssignmentFields>[]
                    : Query$Assignments.fromJson(assignmentsResult.data!).assignments;
                final redemptions = redResult.data == null
                    ? <Fragment$RedemptionFields>[]
                    : Query$Redemptions.fromJson(redResult.data!).redemptions;

                return RefreshIndicator(
                  onRefresh: () async {
                    refetchHousehold?.call();
                    refetchA?.call();
                    refetchR?.call();
                  },
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      for (final kid in kids)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _KidLedger(
                            kid: kid,
                            earned: assignments
                                .where((a) =>
                                    a.assignedTo.id == kid.id &&
                                    a.status == Enum$ChoreStatus.approved)
                                .toList(),
                            spent: redemptions
                                .where((r) =>
                                    r.user.id == kid.id &&
                                    (r.status == Enum$RedemptionStatus.approved ||
                                        r.status == Enum$RedemptionStatus.fulfilled))
                                .toList(),
                            fmt: _fmt,
                          ),
                        ),
                      if (kids.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 60),
                          child: Center(
                            child: Text(
                              'No kids in this household yet.',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                color: context.savanna.ink2,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _KidLedger extends StatelessWidget {
  const _KidLedger({
    required this.kid,
    required this.earned,
    required this.spent,
    required this.fmt,
  });
  final Fragment$UserFields kid;
  final List<Fragment$AssignmentFields> earned;
  final List<Fragment$RedemptionFields> spent;
  final DateFormat fmt;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final totalEarned = earned.fold<int>(0, (a, b) => a + b.chore.tokenValue);
    final totalSpent = spent.fold<int>(0, (a, b) => a + b.tokensSpent);
    final mascot = mascotFromEmoji(kid.avatarEmoji);

    final combined = <_LedgerRowData>[
      for (final a in earned)
        _LedgerRowData(
          when: a.approvedAt ?? a.createdAt,
          label: a.chore.title,
          sign: '+',
          tokens: a.chore.tokenValue,
          icon: Icons.check_circle_outline,
          color: tokens.green,
        ),
      for (final r in spent)
        _LedgerRowData(
          when: r.decidedAt ?? r.requestedAt,
          label: r.reward.title,
          sign: '-',
          tokens: r.tokensSpent,
          icon: Icons.card_giftcard_outlined,
          color: tokens.accent,
        ),
    ]..sort((a, b) => b.when.compareTo(a.when));

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: tokens.line),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (mascot != null)
                  Mascot(kind: mascot, size: 44)
                else
                  Text(kid.avatarEmoji, style: const TextStyle(fontSize: 36)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        kid.name,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                          color: tokens.ink,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            'Earned ',
                            style: TextStyle(fontFamily: 'Nunito', fontSize: 12, color: tokens.ink2, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '$totalEarned',
                            style: spaceGrotesk(fontSize: 12, fontWeight: FontWeight.w800, color: tokens.green),
                          ),
                          Text(
                            ' · Spent ',
                            style: TextStyle(fontFamily: 'Nunito', fontSize: 12, color: tokens.ink2, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '$totalSpent',
                            style: spaceGrotesk(fontSize: 12, fontWeight: FontWeight.w800, color: tokens.accent),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                TokenPill(value: kid.tokenBalance),
              ],
            ),
          ),
          if (combined.isNotEmpty) Divider(height: 1, color: tokens.line),
          if (combined.isEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                'No transactions yet.',
                style: TextStyle(fontFamily: 'Nunito', fontSize: 13, color: tokens.ink2, fontWeight: FontWeight.w600),
              ),
            )
          else
            for (final row in combined.take(10))
              _LedgerRowView(row: row, fmt: fmt, divider: row != combined.take(10).last),
        ],
      ),
    );
  }
}

class _LedgerRowData {
  _LedgerRowData({
    required this.when,
    required this.label,
    required this.sign,
    required this.tokens,
    required this.icon,
    required this.color,
  });
  final DateTime when;
  final String label;
  final String sign;
  final int tokens;
  final IconData icon;
  final Color color;
}

class _LedgerRowView extends StatelessWidget {
  const _LedgerRowView({required this.row, required this.fmt, required this.divider});
  final _LedgerRowData row;
  final DateFormat fmt;
  final bool divider;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    return Container(
      decoration: divider ? BoxDecoration(border: Border(bottom: BorderSide(color: tokens.line))) : null,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Icon(row.icon, color: row.color, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              row.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontFamily: 'Nunito', fontSize: 14, fontWeight: FontWeight.w700, color: tokens.ink),
            ),
          ),
          Text(
            fmt.format(row.when.toLocal()),
            style: TextStyle(fontFamily: 'Nunito', fontSize: 12, color: tokens.ink2, fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 10),
          Text(
            '${row.sign}${row.tokens}',
            style: spaceGrotesk(fontSize: 14, fontWeight: FontWeight.w800, color: row.color),
          ),
        ],
      ),
    );
  }
}
