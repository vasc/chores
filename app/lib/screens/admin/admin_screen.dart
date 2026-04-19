import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../auth/auth_controller.dart';
import '../../graphql/operations/auth.graphql.dart';
import '../../graphql/operations/chores.graphql.dart';
import '../../graphql/operations/fragments.graphql.dart';
import '../../graphql/operations/queries.graphql.dart';
import '../../graphql/operations/rewards.graphql.dart';
import '../../graphql/schema.graphql.dart';
import '../../widgets/error_box.dart';

class AdminScreen extends ConsumerWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin'),
          bottom: const TabBar(tabs: [
            Tab(text: 'Chores', icon: Icon(Icons.checklist)),
            Tab(text: 'Rewards', icon: Icon(Icons.card_giftcard)),
            Tab(text: 'Members', icon: Icon(Icons.group)),
          ]),
        ),
        body: const TabBarView(children: [
          _ChoresTab(),
          _RewardsTab(),
          _MembersTab(),
        ]),
      ),
    );
  }
}

// ─────────── Chores ───────────

class _ChoresTab extends ConsumerWidget {
  const _ChoresTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Query(
      options: QueryOptions(
        document: documentNodeQueryChores,
        fetchPolicy: FetchPolicy.cacheAndNetwork,
      ),
      builder: (result, {refetch, fetchMore}) {
        if (result.isLoading && result.data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final chores = result.data == null
            ? <Fragment$ChoreFields>[]
            : Query$Chores.fromJson(result.data!).chores;
        return Scaffold(
          body: chores.isEmpty
              ? const Center(child: Text('No chores. Tap + to add one.'))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: chores.length,
                  itemBuilder: (_, i) => _ChoreAdminTile(
                    chore: chores[i],
                    onChange: () => refetch?.call(),
                  ),
                ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              final created = await showModalBottomSheet<bool>(
                context: context,
                isScrollControlled: true,
                builder: (_) => const _ChoreForm(),
              );
              if (created == true) refetch?.call();
            },
            icon: const Icon(Icons.add),
            label: const Text('New chore'),
          ),
        );
      },
    );
  }
}

class _ChoreAdminTile extends ConsumerWidget {
  const _ChoreAdminTile({required this.chore, required this.onChange});
  final Fragment$ChoreFields chore;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(chore.title),
            subtitle: Text('${chore.tokenValue} 🪙 · ${chore.recurrence.name}'),
            trailing: IconButton(
              icon: const Icon(Icons.archive_outlined),
              tooltip: 'Archive',
              onPressed: () async {
                await ref.read(graphqlClientProvider).mutate(MutationOptions(
                      document: documentNodeMutationArchiveChore,
                      variables: Variables$Mutation$ArchiveChore(id: chore.id).toJson(),
                    ));
                onChange();
              },
            ),
          ),
          OverflowBar(
            alignment: MainAxisAlignment.end,
            children: [
              FilledButton.tonal(
                onPressed: () async {
                  final assigned = await showModalBottomSheet<bool>(
                    context: context,
                    builder: (_) => _AssignSheet(choreId: chore.id),
                  );
                  if (assigned == true) onChange();
                },
                child: const Text('Assign…'),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChoreForm extends ConsumerStatefulWidget {
  const _ChoreForm();

  @override
  ConsumerState<_ChoreForm> createState() => _ChoreFormState();
}

class _ChoreFormState extends ConsumerState<_ChoreForm> {
  final _form = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _desc = TextEditingController();
  final _tokens = TextEditingController(text: '5');
  Enum$Recurrence _recurrence = Enum$Recurrence.one_off;
  bool _busy = false;
  String? _error;

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    final result = await ref.read(graphqlClientProvider).mutate(MutationOptions(
          document: documentNodeMutationCreateChore,
          variables: Variables$Mutation$CreateChore(
            title: _title.text.trim(),
            description: _desc.text.trim().isEmpty ? null : _desc.text.trim(),
            tokenValue: int.parse(_tokens.text),
            recurrence: _recurrence,
          ).toJson(),
        ));
    if (!mounted) return;
    if (result.hasException) {
      setState(() {
        _busy = false;
        _error = prettifyError(result.exception!);
      });
      return;
    }
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('New chore', style: TextStyle(fontSize: 20)),
            if (_error != null) ErrorBox(_error!),
            TextFormField(
              controller: _title,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            TextFormField(
              controller: _desc,
              decoration: const InputDecoration(labelText: 'Description (optional)'),
            ),
            TextFormField(
              controller: _tokens,
              decoration: const InputDecoration(labelText: 'Token reward'),
              keyboardType: TextInputType.number,
              validator: (v) => int.tryParse(v ?? '') == null ? 'Number' : null,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<Enum$Recurrence>(
              value: _recurrence,
              decoration: const InputDecoration(labelText: 'Recurrence'),
              items: const [
                DropdownMenuItem(value: Enum$Recurrence.one_off, child: Text('One-off')),
                DropdownMenuItem(value: Enum$Recurrence.daily, child: Text('Daily')),
                DropdownMenuItem(value: Enum$Recurrence.weekly, child: Text('Weekly')),
              ],
              onChanged: (v) => setState(() => _recurrence = v!),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _busy ? null : _save,
                child: const Text('Create'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _AssignSheet extends ConsumerWidget {
  const _AssignSheet({required this.choreId});
  final String choreId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Query(
      options: QueryOptions(document: documentNodeQueryHousehold),
      builder: (result, {refetch, fetchMore}) {
        if (result.isLoading && result.data == null) {
          return const SizedBox(
            height: 160,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final members = Query$Household.fromJson(result.data!).members;
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            for (final m in members)
              ListTile(
                leading: CircleAvatar(child: Text(m.avatarEmoji)),
                title: Text(m.name),
                subtitle: Text(m.role.name),
                onTap: () async {
                  final res = await ref.read(graphqlClientProvider).mutate(MutationOptions(
                        document: documentNodeMutationAssignChore,
                        variables: Variables$Mutation$AssignChore(
                          choreId: choreId,
                          assignedToUserId: m.id,
                        ).toJson(),
                      ));
                  if (!context.mounted) return;
                  if (res.hasException) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(prettifyError(res.exception!))),
                    );
                    return;
                  }
                  Navigator.pop(context, true);
                },
              ),
          ],
        );
      },
    );
  }
}

// ─────────── Rewards ───────────

class _RewardsTab extends ConsumerWidget {
  const _RewardsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Query(
      options: QueryOptions(
        document: documentNodeQueryRewards,
        fetchPolicy: FetchPolicy.cacheAndNetwork,
      ),
      builder: (result, {refetch, fetchMore}) {
        if (result.isLoading && result.data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final rewards = result.data == null
            ? <Fragment$RewardFields>[]
            : Query$Rewards.fromJson(result.data!).rewards;
        return Scaffold(
          body: rewards.isEmpty
              ? const Center(child: Text('No rewards yet.'))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: rewards.length,
                  itemBuilder: (_, i) {
                    final r = rewards[i];
                    return Card(
                      child: ListTile(
                        title: Text(r.title),
                        subtitle: Text('${r.tokenCost} 🪙'),
                        trailing: IconButton(
                          icon: const Icon(Icons.archive_outlined),
                          onPressed: () async {
                            await ref.read(graphqlClientProvider).mutate(MutationOptions(
                                  document: documentNodeMutationArchiveReward,
                                  variables: Variables$Mutation$ArchiveReward(id: r.id).toJson(),
                                ));
                            refetch?.call();
                          },
                        ),
                      ),
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              final created = await showModalBottomSheet<bool>(
                context: context,
                isScrollControlled: true,
                builder: (_) => const _RewardForm(),
              );
              if (created == true) refetch?.call();
            },
            icon: const Icon(Icons.add),
            label: const Text('New reward'),
          ),
        );
      },
    );
  }
}

class _RewardForm extends ConsumerStatefulWidget {
  const _RewardForm();

  @override
  ConsumerState<_RewardForm> createState() => _RewardFormState();
}

class _RewardFormState extends ConsumerState<_RewardForm> {
  final _form = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _desc = TextEditingController();
  final _cost = TextEditingController(text: '10');
  bool _busy = false;
  String? _error;

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    final result = await ref.read(graphqlClientProvider).mutate(MutationOptions(
          document: documentNodeMutationCreateReward,
          variables: Variables$Mutation$CreateReward(
            title: _title.text.trim(),
            description: _desc.text.trim().isEmpty ? null : _desc.text.trim(),
            tokenCost: int.parse(_cost.text),
          ).toJson(),
        ));
    if (!mounted) return;
    if (result.hasException) {
      setState(() {
        _busy = false;
        _error = prettifyError(result.exception!);
      });
      return;
    }
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('New reward', style: TextStyle(fontSize: 20)),
            if (_error != null) ErrorBox(_error!),
            TextFormField(
              controller: _title,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            TextFormField(
              controller: _desc,
              decoration: const InputDecoration(labelText: 'Description (optional)'),
            ),
            TextFormField(
              controller: _cost,
              decoration: const InputDecoration(labelText: 'Token cost'),
              keyboardType: TextInputType.number,
              validator: (v) => int.tryParse(v ?? '') == null ? 'Number' : null,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _busy ? null : _save,
                child: const Text('Create'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ─────────── Members ───────────

class _MembersTab extends ConsumerWidget {
  const _MembersTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Query(
      options: QueryOptions(
        document: documentNodeQueryHousehold,
        fetchPolicy: FetchPolicy.cacheAndNetwork,
      ),
      builder: (result, {refetch, fetchMore}) {
        if (result.isLoading && result.data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final parsed = Query$Household.fromJson(result.data!);
        final members = parsed.members;
        final leaderboard = [
          ...members.where((m) => m.role == Enum$Role.child),
        ]..sort((a, b) => b.tokenBalance.compareTo(a.tokenBalance));
        return Scaffold(
          body: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              ListTile(
                title: Text(parsed.household.name),
                subtitle: const Text('Household'),
              ),
              if (leaderboard.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text('🏆 Leaderboard',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
                Card(
                  child: Column(
                    children: [
                      for (var i = 0; i < leaderboard.length; i++)
                        ListTile(
                          leading: SizedBox(
                            width: 36,
                            child: Text(
                              i == 0
                                  ? '🥇'
                                  : i == 1
                                      ? '🥈'
                                      : i == 2
                                          ? '🥉'
                                          : '#${i + 1}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 22),
                            ),
                          ),
                          title: Row(
                            children: [
                              Text(leaderboard[i].avatarEmoji),
                              const SizedBox(width: 8),
                              Text(leaderboard[i].name),
                            ],
                          ),
                          trailing: Text('${leaderboard[i].tokenBalance} 🪙',
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                    ],
                  ),
                ),
              ],
              const Divider(),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
                child: Text('All members',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
              for (final m in members)
                ListTile(
                  leading: CircleAvatar(child: Text(m.avatarEmoji)),
                  title: Text(m.name),
                  subtitle: Text('${m.role.name} · ${m.tokenBalance} 🪙'),
                ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              final created = await showModalBottomSheet<bool>(
                context: context,
                isScrollControlled: true,
                builder: (_) => const _AddChildForm(),
              );
              if (created == true) refetch?.call();
            },
            icon: const Icon(Icons.add),
            label: const Text('Add child'),
          ),
        );
      },
    );
  }
}

class _AddChildForm extends ConsumerStatefulWidget {
  const _AddChildForm();

  @override
  ConsumerState<_AddChildForm> createState() => _AddChildFormState();
}

class _AddChildFormState extends ConsumerState<_AddChildForm> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _pin = TextEditingController();
  final _emoji = TextEditingController(text: '🧒');
  bool _busy = false;
  String? _error;

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    final result = await ref.read(graphqlClientProvider).mutate(MutationOptions(
          document: documentNodeMutationAddChild,
          variables: Variables$Mutation$AddChild(
            name: _name.text.trim(),
            pin: _pin.text,
            avatarEmoji: _emoji.text.trim().isEmpty ? null : _emoji.text.trim(),
          ).toJson(),
        ));
    if (!mounted) return;
    if (result.hasException) {
      setState(() {
        _busy = false;
        _error = prettifyError(result.exception!);
      });
      return;
    }
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Add child', style: TextStyle(fontSize: 20)),
            if (_error != null) ErrorBox(_error!),
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            TextFormField(
              controller: _pin,
              decoration: const InputDecoration(labelText: '4-digit PIN'),
              keyboardType: TextInputType.number,
              maxLength: 4,
              validator: (v) =>
                  (v == null || v.length != 4 || int.tryParse(v) == null) ? '4 digits' : null,
            ),
            TextFormField(
              controller: _emoji,
              decoration: const InputDecoration(labelText: 'Avatar emoji'),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _busy ? null : _save,
                child: const Text('Add'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
