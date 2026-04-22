import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../auth/auth_controller.dart';
import '../graphql/operations/auth.graphql.dart';
import '../theme.dart';
import '../widgets/error_box.dart';
import '../widgets/savanna/atoms.dart';
import '../widgets/savanna/savanna_bg.dart';

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
    try {
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
        if (mounted) {
          setState(() {
            _busy = false;
            _error = prettifyError(result.exception!);
          });
        }
        return;
      }
      final parsed = Mutation$SignUpHousehold.fromJson(result.data!);
      await ref
          .read(authControllerProvider.notifier)
          .setSession(parsed.signUpHousehold.token, parsed.signUpHousehold.user);
    } catch (e) {
      if (mounted) {
        setState(() {
          _busy = false;
          _error = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    return Scaffold(
      appBar: AppBar(title: const Text('New household')),
      body: SavannaBg(
        variant: SavannaBgVariant.day,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Set up your household',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: tokens.ink,
                      letterSpacing: -0.6,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'One adult kicks it off — you can invite more later.',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 14,
                      color: tokens.ink2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (_error != null) Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ErrorBox(_error!),
                  ),
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
                  CuteButton(
                    full: true,
                    onPressed: _busy ? null : _submit,
                    child: _busy
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Text('Create household'),
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
