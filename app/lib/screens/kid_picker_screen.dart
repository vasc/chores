import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../auth/auth_controller.dart';
import '../auth/household_storage.dart';
import '../graphql/operations/auth.graphql.dart';
import '../graphql/operations/fragments.graphql.dart';
import '../graphql/operations/queries.graphql.dart';
import '../theme.dart';
import '../widgets/error_box.dart';
import '../widgets/savanna/atoms.dart';
import '../widgets/savanna/mascots.dart';
import '../widgets/savanna/savanna_bg.dart';

class KidPickerScreen extends ConsumerStatefulWidget {
  const KidPickerScreen({super.key});

  @override
  ConsumerState<KidPickerScreen> createState() => _KidPickerScreenState();
}

class _KidPickerScreenState extends ConsumerState<KidPickerScreen> {
  bool _loading = true;
  String? _error;
  List<Fragment$UserFields> _kids = const [];
  Fragment$UserFields? _selected;

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
    if (!mounted) return;
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

  Future<bool> _submitPin(Fragment$UserFields kid, String pin) async {
    final result = await ref.read(graphqlClientProvider).mutate(MutationOptions(
          document: documentNodeMutationKidLogin,
          variables: Variables$Mutation$KidLogin(userId: kid.id, pin: pin).toJson(),
        ));
    if (result.hasException) return false;
    final parsed = Mutation$KidLogin.fromJson(result.data!);
    await ref
        .read(authControllerProvider.notifier)
        .setSession(parsed.kidLogin.token, parsed.kidLogin.user);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (_selected != null) {
      return _PinEntryView(
        kid: _selected!,
        onBack: () => setState(() => _selected = null),
        onSubmit: (pin) => _submitPin(_selected!, pin),
      );
    }
    final tokens = context.savanna;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Who's playing?"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/welcome'),
        ),
      ),
      body: SavannaBg(
        variant: SavannaBgVariant.day,
        child: SafeArea(
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
                  ? Padding(padding: const EdgeInsets.all(20), child: ErrorBox(_error!))
                  : _kids.isEmpty
                      ? Center(
                          child: Text(
                            'No kids in this household yet.',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                              color: tokens.ink2,
                            ),
                          ),
                        )
                      : GridView.count(
                          crossAxisCount: 2,
                          padding: const EdgeInsets.all(20),
                          childAspectRatio: 0.9,
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 14,
                          children: [
                            for (final kid in _kids)
                              _KidTile(kid: kid, onTap: () => setState(() => _selected = kid)),
                          ],
                        ),
        ),
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
    final tokens = context.savanna;
    final mascot = mascotFromEmoji(kid.avatarEmoji);
    return Material(
      color: tokens.card,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              mascot != null
                  ? Mascot(kind: mascot, size: 88)
                  : Text(kid.avatarEmoji, style: const TextStyle(fontSize: 72)),
              const SizedBox(height: 12),
              Text(
                kid.name,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: tokens.ink,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 4),
              TokenPill(value: kid.tokenBalance, size: TokenPillSize.sm),
            ],
          ),
        ),
      ),
    );
  }
}

class _PinEntryView extends StatefulWidget {
  const _PinEntryView({
    required this.kid,
    required this.onBack,
    required this.onSubmit,
  });
  final Fragment$UserFields kid;
  final VoidCallback onBack;
  final Future<bool> Function(String) onSubmit;

  @override
  State<_PinEntryView> createState() => _PinEntryViewState();
}

class _PinEntryViewState extends State<_PinEntryView> with SingleTickerProviderStateMixin {
  String _pin = '';
  bool _busy = false;
  bool _shake = false;
  late final AnimationController _shakeCtrl;
  late final AnimationController _bobCtrl;

  @override
  void initState() {
    super.initState();
    _shakeCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _bobCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _shakeCtrl.dispose();
    _bobCtrl.dispose();
    super.dispose();
  }

  Future<void> _tap(String d) async {
    if (_busy) return;
    if (_pin.length >= 4) return;
    HapticFeedback.lightImpact();
    final next = _pin + d;
    setState(() => _pin = next);
    if (next.length == 4) {
      setState(() => _busy = true);
      final ok = await widget.onSubmit(next);
      if (!mounted) return;
      if (!ok) {
        _shakeCtrl.forward(from: 0);
        setState(() {
          _shake = true;
          _pin = '';
          _busy = false;
        });
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted) setState(() => _shake = false);
        });
      }
    }
  }

  void _del() {
    if (_busy || _pin.isEmpty) return;
    HapticFeedback.selectionClick();
    setState(() => _pin = _pin.substring(0, _pin.length - 1));
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final mascot = mascotFromEmoji(widget.kid.avatarEmoji);
    return Scaffold(
      body: SavannaBg(
        variant: SavannaBgVariant.dusk,
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: widget.onBack,
                ),
              ),
              const SizedBox(height: 24),
              AnimatedBuilder(
                animation: _bobCtrl,
                builder: (_, child) {
                  final t = _bobCtrl.value;
                  final y = -6 * (1 - (2 * t - 1).abs());
                  return Transform.translate(offset: Offset(0, y), child: child);
                },
                child: mascot != null
                    ? Mascot(kind: mascot, size: 140)
                    : Text(widget.kid.avatarEmoji, style: const TextStyle(fontSize: 120)),
              ),
              const SizedBox(height: 12),
              Text(
                'Hi, ${widget.kid.name}!',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                  color: tokens.ink,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Enter your secret paw-code',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 15,
                  color: tokens.ink2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 36),
              AnimatedBuilder(
                animation: _shakeCtrl,
                builder: (_, child) {
                  final dx = _shake ? (1 - _shakeCtrl.value) * 8 * ((_shakeCtrl.value * 8).floor().isEven ? 1 : -1) : 0.0;
                  return Transform.translate(offset: Offset(dx, 0), child: child);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 4; i++) ...[
                      _PinDot(filled: _pin.length > i, active: _pin.length == i + 1, color: tokens.accent, ink: tokens.ink2),
                      if (i < 3) const SizedBox(width: 16),
                    ],
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                child: _Keypad(onTap: _tap, onDel: _del, inkColor: tokens.ink, inkSecondary: tokens.ink2),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextButton(
                  onPressed: widget.onBack,
                  child: Text(
                    'Switch profile',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 13,
                      color: tokens.ink2.withValues(alpha: 0.8),
                      fontWeight: FontWeight.w700,
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

class _PinDot extends StatelessWidget {
  const _PinDot({required this.filled, required this.active, required this.color, required this.ink});
  final bool filled;
  final bool active;
  final Color color;
  final Color ink;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 18,
      height: 18,
      transform: Matrix4.identity()..scaleByDouble(active ? 1.2 : 1.0, active ? 1.2 : 1.0, 1.0, 1.0),
      transformAlignment: Alignment.center,
      decoration: BoxDecoration(
        color: filled ? color : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: filled ? color : ink, width: 2.5),
      ),
    );
  }
}

class _Keypad extends StatelessWidget {
  const _Keypad({
    required this.onTap,
    required this.onDel,
    required this.inkColor,
    required this.inkSecondary,
  });

  final ValueChanged<String> onTap;
  final VoidCallback onDel;
  final Color inkColor;
  final Color inkSecondary;

  @override
  Widget build(BuildContext context) {
    final buttons = <Widget>[
      for (var n = 1; n <= 9; n++) _KeyButton(label: '$n', onTap: () => onTap('$n'), color: inkColor),
      const SizedBox(),
      _KeyButton(label: '0', onTap: () => onTap('0'), color: inkColor),
      _KeyButton(label: '⌫', onTap: onDel, color: inkSecondary, transparent: true, fontSize: 22),
    ];
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        children: buttons,
      ),
    );
  }
}

class _KeyButton extends StatelessWidget {
  const _KeyButton({
    required this.label,
    required this.onTap,
    required this.color,
    this.transparent = false,
    this.fontSize = 30,
  });
  final String label;
  final VoidCallback onTap;
  final Color color;
  final bool transparent;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: transparent ? Colors.transparent : Colors.white,
      shape: const CircleBorder(),
      elevation: transparent ? 0 : 3,
      shadowColor: const Color(0x263C2814),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Center(
          child: Text(
            label,
            style: spaceGrotesk(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
