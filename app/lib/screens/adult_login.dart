import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../auth/auth_controller.dart';
import '../graphql/operations/auth.graphql.dart';
import '../theme.dart';
import '../widgets/error_box.dart';
import '../widgets/savanna/atoms.dart';
import '../widgets/savanna/savanna_bg.dart';

class AdultLoginScreen extends ConsumerStatefulWidget {
  const AdultLoginScreen({super.key});

  @override
  ConsumerState<AdultLoginScreen> createState() => _AdultLoginScreenState();
}

class _AdultLoginScreenState extends ConsumerState<AdultLoginScreen> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
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
      document: documentNodeMutationLoginAdult,
      variables: Variables$Mutation$LoginAdult(
        email: _email.text.trim(),
        password: _password.text,
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
    final parsed = Mutation$LoginAdult.fromJson(result.data!);
    await ref
        .read(authControllerProvider.notifier)
        .setSession(parsed.loginAdult.token, parsed.loginAdult.user);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome back')),
      body: SavannaBg(
        variant: SavannaBgVariant.plain,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Log in',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: tokens.ink,
                      letterSpacing: -0.6,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_error != null) Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ErrorBox(_error!),
                  ),
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
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 24),
                  CuteButton(
                    full: true,
                    onPressed: _busy ? null : _submit,
                    child: _busy
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Text('Log in'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
