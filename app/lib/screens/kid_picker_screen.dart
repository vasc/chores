import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../auth/auth_controller.dart';
import '../auth/household_storage.dart';
import '../graphql/operations/auth.graphql.dart';
import '../graphql/operations/fragments.graphql.dart';
import '../graphql/operations/queries.graphql.dart';
import '../widgets/error_box.dart';

class KidPickerScreen extends ConsumerStatefulWidget {
  const KidPickerScreen({super.key});

  @override
  ConsumerState<KidPickerScreen> createState() => _KidPickerScreenState();
}

class _KidPickerScreenState extends ConsumerState<KidPickerScreen> {
  bool _loading = true;
  String? _error;
  List<Fragment$UserFields> _kids = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final id = await HouseholdStorage.instance.read();
    if (id == null) {
      setState(() {
        _loading = false;
        _error = 'No household on this device yet — ask an adult to log in once.';
      });
      return;
    }
    final result = await ref.read(graphqlClientProvider).query(QueryOptions(
          document: documentNodeQueryKidsForLogin,
          variables: Variables$Query$KidsForLogin(householdId: id).toJson(),
          fetchPolicy: FetchPolicy.networkOnly,
        ));
    if (result.hasException) {
      setState(() {
        _loading = false;
        _error = prettifyError(result.exception!);
      });
      return;
    }
    final parsed = Query$KidsForLogin.fromJson(result.data!);
    setState(() {
      _loading = false;
      _kids = parsed.kidsForLogin;
    });
  }

  Future<void> _login(Fragment$UserFields kid) async {
    final pin = await showDialog<String>(
      context: context,
      builder: (_) => _PinDialog(name: kid.name),
    );
    if (pin == null) return;
    if (!mounted) return;
    final result = await ref.read(graphqlClientProvider).mutate(MutationOptions(
          document: documentNodeMutationKidLogin,
          variables: Variables$Mutation$KidLogin(userId: kid.id, pin: pin).toJson(),
        ));
    if (result.hasException) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(prettifyError(result.exception!))),
      );
      return;
    }
    final parsed = Mutation$KidLogin.fromJson(result.data!);
    await ref
        .read(authControllerProvider.notifier)
        .setSession(parsed.kidLogin.token, parsed.kidLogin.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Who are you?'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/welcome'),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? ErrorBox(_error!)
              : _kids.isEmpty
                  ? const Center(child: Text('No kids in this household yet.'))
                  : GridView.count(
                      crossAxisCount: 2,
                      padding: const EdgeInsets.all(16),
                      childAspectRatio: 0.95,
                      children: [
                        for (final kid in _kids)
                          _KidTile(kid: kid, onTap: () => _login(kid)),
                      ],
                    ),
    );
  }
}

class _KidTile extends StatelessWidget {
  const _KidTile({required this.kid, required this.onTap});
  final Fragment$UserFields kid;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(kid.avatarEmoji, style: const TextStyle(fontSize: 56)),
              const SizedBox(height: 12),
              Text(kid.name, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              Text('${kid.tokenBalance} 🪙'),
            ],
          ),
        ),
      ),
    );
  }
}

class _PinDialog extends StatefulWidget {
  const _PinDialog({required this.name});
  final String name;

  @override
  State<_PinDialog> createState() => _PinDialogState();
}

class _PinDialogState extends State<_PinDialog> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Hi ${widget.name} — enter your PIN"),
      content: TextField(
        controller: _ctrl,
        keyboardType: TextInputType.number,
        obscureText: true,
        maxLength: 4,
        autofocus: true,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 32, letterSpacing: 12),
        decoration: const InputDecoration(counterText: ''),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (_ctrl.text.length == 4) Navigator.pop(context, _ctrl.text);
          },
          child: const Text('Go'),
        ),
      ],
    );
  }
}
