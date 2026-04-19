import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../auth/auth_controller.dart';
import '../graphql/operations/fragments.graphql.dart';
import '../graphql/operations/queries.graphql.dart';
import '../graphql/operations/rewards.graphql.dart';
import '../widgets/error_box.dart';

class RewardsScreen extends ConsumerWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Rewards')),
      body: Query(
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
          if (parsed.rewards.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async => refetch?.call(),
              child: ListView(
                children: const [
                  SizedBox(height: 120),
                  Center(child: Text('No rewards yet.')),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async => refetch?.call(),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: parsed.rewards.length,
              itemBuilder: (_, i) => _RewardTile(
                reward: parsed.rewards[i],
                isAdult: auth.isAdult,
                myBalance: auth.me?.tokenBalance ?? 0,
                onAfter: () => refetch?.call(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RewardTile extends ConsumerStatefulWidget {
  const _RewardTile({
    required this.reward,
    required this.isAdult,
    required this.myBalance,
    required this.onAfter,
  });
  final Fragment$RewardFields reward;
  final bool isAdult;
  final int myBalance;
  final VoidCallback onAfter;

  @override
  ConsumerState<_RewardTile> createState() => _RewardTileState();
}

class _RewardTileState extends ConsumerState<_RewardTile> {
  bool _busy = false;
  String? _error;

  Future<void> _redeem() async {
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
    setState(() => _busy = false);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sent for approval ✨')),
    );
    widget.onAfter();
  }

  @override
  Widget build(BuildContext context) {
    final canAfford = widget.myBalance >= widget.reward.tokenCost;
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(widget.reward.title),
            subtitle: widget.reward.description == null
                ? null
                : Text(widget.reward.description!),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${widget.reward.tokenCost} 🪙',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (_error != null) ErrorBox(_error!),
          if (!widget.isAdult)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _busy || !canAfford ? null : _redeem,
                  child: Text(canAfford ? 'Request' : 'Need more 🪙'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
