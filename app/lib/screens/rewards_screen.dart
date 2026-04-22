import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../auth/auth_controller.dart';
import '../graphql/operations/fragments.graphql.dart';
import '../graphql/operations/queries.graphql.dart';
import '../graphql/operations/rewards.graphql.dart';
import '../theme.dart';
import '../widgets/error_box.dart';
import '../widgets/savanna/atoms.dart';
import '../widgets/savanna/icons.dart';
import '../widgets/savanna/savanna_bg.dart';

class RewardsScreen extends ConsumerStatefulWidget {
  const RewardsScreen({super.key});

  @override
  ConsumerState<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends ConsumerState<RewardsScreen> {
  String _filter = 'All';
  final _cats = const ['All', 'Screen time', 'Treats', 'Outings', 'Cash'];

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);
    final me = auth.me;
    final tokens = context.savanna;
    return Scaffold(
      backgroundColor: tokens.bg,
      body: SavannaBg(
        variant: SavannaBgVariant.plain,
        child: SafeArea(
          child: Query(
            options: QueryOptions(
              document: documentNodeQueryRewards,
              fetchPolicy: FetchPolicy.cacheAndNetwork,
            ),
            builder: (result, {refetch, fetchMore}) {
              if (result.isLoading && result.data == null) {
                return const Center(child: CircularProgressIndicator());
              }
              if (result.hasException) {
                return Center(child: Text(result.exception!.toString()));
              }
              final parsed = Query$Rewards.fromJson(result.data!);
              final items = _filter == 'All'
                  ? parsed.rewards
                  : parsed.rewards.where((r) => _rewardCategory(r.title) == _filter).toList();
              return RefreshIndicator(
                onRefresh: () async => refetch?.call(),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: _TopRow(me: me)),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rewards shop',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                                color: tokens.ink,
                                letterSpacing: -0.6,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Spend tokens on stuff you love 💫',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                color: tokens.ink2,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
                        child: Row(
                          children: [
                            for (final c in _cats)
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: _FilterChip(
                                  label: c,
                                  selected: c == _filter,
                                  onTap: () => setState(() => _filter = c),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (items.isEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                          child: Center(
                            child: Text(
                              'No rewards here yet.',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                color: tokens.ink2,
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                        sliver: SliverGrid(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.78,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (ctx, i) => _RewardTile(
                              reward: items[i],
                              myBalance: me?.tokenBalance ?? 0,
                              onTap: auth.isAdult
                                  ? null
                                  : () => _openRedeemSheet(items[i]),
                            ),
                            childCount: items.length,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _openRedeemSheet(Fragment$RewardFields r) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _RedeemSheet(reward: r),
    );
  }
}

class _TopRow extends StatelessWidget {
  const _TopRow({required this.me});
  final Fragment$UserFields? me;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      child: Row(
        children: [
          Material(
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
                  child: Icon(Icons.arrow_back, color: context.savanna.ink, size: 20),
                ),
              ),
            ),
          ),
          const Spacer(),
          if (me != null) TokenPill(value: me!.tokenBalance),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    return Material(
      color: selected ? tokens.ink : Colors.white,
      borderRadius: BorderRadius.circular(999),
      elevation: selected ? 0 : 1,
      shadowColor: const Color(0x143C2814),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: selected ? Colors.white : tokens.ink,
            ),
          ),
        ),
      ),
    );
  }
}

class _RewardTile extends StatelessWidget {
  const _RewardTile({
    required this.reward,
    required this.myBalance,
    required this.onTap,
  });

  final Fragment$RewardFields reward;
  final int myBalance;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final affordable = myBalance >= reward.tokenCost;
    return Opacity(
      opacity: affordable ? 1 : 0.6,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.density.radius),
        child: InkWell(
          borderRadius: BorderRadius.circular(context.density.radius),
          onTap: onTap,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _rewardBg(reward.title),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _rewardEmoji(reward.title),
                          style: const TextStyle(fontSize: 52),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      reward.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        color: tokens.ink,
                        letterSpacing: -0.2,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _rewardCategory(reward.title),
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 11,
                        color: tokens.ink2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    TokenPill(value: reward.tokenCost, size: TokenPillSize.sm),
                  ],
                ),
              ),
              if (!affordable)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xB3000000),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      '${reward.tokenCost - myBalance} more',
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RedeemSheet extends ConsumerStatefulWidget {
  const _RedeemSheet({required this.reward});
  final Fragment$RewardFields reward;

  @override
  ConsumerState<_RedeemSheet> createState() => _RedeemSheetState();
}

class _RedeemSheetState extends ConsumerState<_RedeemSheet> {
  bool _busy = false;
  bool _sent = false;
  String? _error;

  Future<void> _confirm() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    final result = await ref.read(graphqlClientProvider).mutate(MutationOptions(
          document: documentNodeMutationRequestRedemption,
          variables: Variables$Mutation$RequestRedemption(rewardId: widget.reward.id).toJson(),
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
    setState(() {
      _busy = false;
      _sent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final auth = ref.watch(authControllerProvider);
    final me = auth.me;
    final newBalance = (me?.tokenBalance ?? 0) - widget.reward.tokenCost;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 180),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: tokens.bg,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0x333C2814),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                if (_sent) ..._sentBody(tokens) else ..._confirmBody(tokens, newBalance),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _confirmBody(SavannaTokens t, int newBalance) => [
        AspectRatio(
          aspectRatio: 1.4,
          child: Container(
            decoration: BoxDecoration(
              color: _rewardBg(widget.reward.title),
              borderRadius: BorderRadius.circular(context.density.radius),
            ),
            alignment: Alignment.center,
            child: Text(_rewardEmoji(widget.reward.title), style: const TextStyle(fontSize: 88)),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          widget.reward.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w900,
            fontSize: 26,
            color: t.ink,
            letterSpacing: -0.5,
          ),
        ),
        if (widget.reward.description != null && widget.reward.description!.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            widget.reward.description!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 14,
              color: t.ink2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              _LedgerRow(label: 'Cost', child: TokenPill(value: widget.reward.tokenCost, size: TokenPillSize.sm)),
              const SizedBox(height: 8),
              _LedgerRow(
                label: 'New balance',
                child: Text(
                  '$newBalance 🪙',
                  style: spaceGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: t.ink,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_error != null) ...[
          const SizedBox(height: 12),
          ErrorBox(_error!),
        ],
        const SizedBox(height: 16),
        CuteButton(
          full: true,
          onPressed: _busy ? null : _confirm,
          icon: SavannaIcons.sparkle(size: 18, color: Colors.white),
          child: _busy
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
              : const Text('Ask an adult'),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: _busy ? null : () => Navigator.of(context).maybePop(),
          child: const Text('Not yet'),
        ),
      ];

  List<Widget> _sentBody(SavannaTokens t) => [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: t.green.withValues(alpha: 0.18),
                ),
                alignment: Alignment.center,
                child: SavannaIcons.check(size: 48, color: t.green),
              ),
              const SizedBox(height: 16),
              Text(
                'Sent for approval!',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                  color: t.ink,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'An adult will say yes or no soon.',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 14,
                  color: t.ink2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        CuteButton(
          full: true,
          onPressed: () => Navigator.of(context).maybePop(),
          child: const Text('OK!'),
        ),
      ];
}

class _LedgerRow extends StatelessWidget {
  const _LedgerRow({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 13,
              color: tokens.ink2,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        child,
      ],
    );
  }
}

String _rewardCategory(String title) {
  final t = title.toLowerCase();
  if (t.contains('screen') || t.contains('tv') || t.contains('phone') || t.contains('game') || t.contains('stay up')) return 'Screen time';
  if (t.contains('ice cream') || t.contains('candy') || t.contains('treat') || t.contains('snack') || t.contains('gummy')) return 'Treats';
  if (t.contains('movie') || t.contains('zoo') || t.contains('park') || t.contains('trip') || t.contains('dinner')) return 'Outings';
  if (t.contains('allowance') || t.contains('\$') || t.contains('cash') || t.contains('money')) return 'Cash';
  return 'Treats';
}

String _rewardEmoji(String title) {
  final t = title.toLowerCase();
  if (t.contains('screen') || t.contains('tablet') || t.contains('phone')) return '📱';
  if (t.contains('tv') || t.contains('movie')) return '🎬';
  if (t.contains('stay up')) return '🌙';
  if (t.contains('ice cream')) return '🍦';
  if (t.contains('gummy') || t.contains('candy')) return '🍬';
  if (t.contains('pizza') || t.contains('dinner')) return '🍕';
  if (t.contains('zoo')) return '🦓';
  if (t.contains('park')) return '🌳';
  if (t.contains('allowance') || t.contains('\$') || t.contains('cash')) return '💵';
  if (t.contains('book')) return '📚';
  if (t.contains('toy')) return '🧸';
  if (t.contains('game')) return '🎮';
  return '🎁';
}

Color _rewardBg(String title) {
  final cat = _rewardCategory(title);
  return switch (cat) {
    'Screen time' => const Color(0xFFD6E8EF),
    'Treats' => const Color(0xFFFFE5DC),
    'Outings' => const Color(0xFFE6DCF0),
    'Cash' => const Color(0xFFE0F0D8),
    _ => const Color(0xFFF0E5D0),
  };
}
