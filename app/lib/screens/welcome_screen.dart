import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme.dart';
import '../widgets/savanna/atoms.dart';
import '../widgets/savanna/icons.dart';
import '../widgets/savanna/mascots.dart';
import '../widgets/savanna/savanna_bg.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    return Scaffold(
      body: SavannaBg(
        variant: SavannaBgVariant.day,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [const Color(0xFFFFE0A8), tokens.bg.withValues(alpha: 0)],
                        stops: const [0, 0.7],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Mascot(kind: MascotKind.lion, size: 160),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Savanna Chores',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w900,
                    fontSize: 34,
                    color: tokens.ink,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Earn tokens for chores. Spend them on treats.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 15,
                    color: tokens.ink2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(flex: 2),
                CuteButton(
                  full: true,
                  icon: SavannaIcons.sparkle(size: 18, color: Colors.white),
                  onPressed: () => context.push('/signup'),
                  child: const Text('Set up a household'),
                ),
                const SizedBox(height: 12),
                CuteButton(
                  full: true,
                  color: tokens.green,
                  onPressed: () => context.push('/login'),
                  child: const Text("I'm an adult, log me in"),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => context.push('/kid-login'),
                  child: Text(
                    "I'm a kid",
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: tokens.ink,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
