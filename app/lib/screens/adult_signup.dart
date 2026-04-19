import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../auth/auth_controller.dart';
import '../graphql/operations/auth.graphql.dart';
import '../widgets/error_box.dart';

class AdultSignupScreen extends ConsumerStatefulWidget {
  const AdultSignupScreen({super.key});

  @override
  ConsumerState<AdultSignupScreen> createState() => _AdultSignupScreenState();
}

class _AdultSignupScreenState extends ConsumerState<AdultSignupScreen> {
  final _form = GlobalKey<FormState>();
  final _household = TextEditingController();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _household.dispose();
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    final client = ref.read(graphqlClientProvider);
    final result = await client.mutate(MutationOptions(
      document: documentNodeMutationSignUpHousehold,
      variables: Variables$Mutation$SignUpHousehold(
        householdName: _household.text.trim(),
        adultName: _name.text.trim(),
        email: _email.text.trim(),
        password: _password.text,
      ).toJson(),
    ));
    if (result.hasException) {
      setState(() {
        _busy = false;
        _error = prettifyError(result.exception!);
      });
      return;
    }
    final parsed = Mutation$SignUpHousehold.fromJson(result.data!);
    await ref
        .read(authControllerProvider.notifier)
        .setSession(parsed.signUpHousehold.token, parsed.signUpHousehold.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set up household')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_error != null) ErrorBox(_error!),
                TextFormField(
                  controller: _household,
                  decoration: const InputDecoration(labelText: 'Household name'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(labelText: 'Your name'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (v) => (v == null || !v.contains('@')) ? 'Invalid email' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password (min 8 chars)'),
                  validator: (v) => (v == null || v.length < 8) ? 'Min 8 chars' : null,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _busy ? null : _submit,
                  child: _busy
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Create household'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
