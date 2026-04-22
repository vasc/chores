import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../auth/auth_controller.dart';
import '../theme.dart';
import '../widgets/savanna/atoms.dart';
import '../widgets/savanna/icons.dart';
import '../widgets/savanna/mascots.dart';
import '../widgets/savanna/savanna_bg.dart';

/// "Buddy" / Pet screen — client-side only (no backend support for
/// pet stats yet). Feeding costs 2 tokens in-app state only.
class BuddyScreen extends ConsumerStatefulWidget {
  const BuddyScreen({super.key});

  @override
  ConsumerState<BuddyScreen> createState() => _BuddyScreenState();
}

class _BuddyScreenState extends ConsumerState<BuddyScreen>
    with SingleTickerProviderStateMixin {
  int _feeds = 0;
  final _particles = <_Particle>[];
  late final AnimationController _tick;

  @override
  void initState() {
    super.initState();
    _tick = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _tick.addListener(() {
      setState(() {
        final now = DateTime.now();
        _particles.removeWhere((p) => now.difference(p.born).inMilliseconds > 1400);
      });
    });
  }

  @override
  void dispose() {
    _tick.dispose();
    super.dispose();
  }

  void _feed() {
    setState(() {
      _feeds++;
      final rnd = math.Random();
      for (var i = 0; i < 6; i++) {
        _particles.add(_Particle(
          dx: (rnd.nextDouble() - 0.5) * 120,
          dy: -60 - rnd.nextDouble() * 40,
          emoji: ['🌿', '🌱', '🍎', '💧'][rnd.nextInt(4)],
          born: DateTime.now(),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);
    final me = auth.me;
    final tokens = context.savanna;
    final mascotKind = me == null ? MascotKind.lion : (mascotFromEmoji(me.avatarEmoji) ?? MascotKind.lion);
    final mascotMeta = mascotInfo[mascotKind]!;
    final happiness = (60 + _feeds * 8).clamp(0, 100);
    final hunger = (100 - _feeds * 10).clamp(0, 100);
    final energy = (75 + (_feeds % 3) * 5).clamp(0, 100);

    return Scaffold(
      appBar: AppBar(
        title: Text('${mascotMeta.name} the ${mascotMeta.species}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SavannaBg(
        variant: SavannaBgVariant.day,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 260,
                      height: 260,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            mascotMeta.color.withValues(alpha: 0.35),
                            mascotMeta.color.withValues(alpha: 0),
                          ],
                          stops: const [0.2, 0.8],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _feed,
                      child: Mascot(kind: mascotKind, size: 220),
                    ),
                    ..._particles.map((p) => _ParticleFly(p: p)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _StatBar(label: 'Happy', value: happiness, color: tokens.accent),
                    _StatBar(label: 'Fed', value: hunger, color: tokens.green),
                    _StatBar(label: 'Energy', value: energy, color: tokens.gold),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: CuteButton(
                  full: true,
                  icon: SavannaIcons.sparkle(size: 18, color: Colors.white),
                  onPressed: _feed,
                  child: const Text('Feed buddy  ·  2 🪙'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Particle {
  _Particle({required this.dx, required this.dy, required this.emoji, required this.born});
  final double dx;
  final double dy;
  final String emoji;
  final DateTime born;
}

class _ParticleFly extends StatelessWidget {
  const _ParticleFly({required this.p});
  final _Particle p;

  @override
  Widget build(BuildContext context) {
    final age = DateTime.now().difference(p.born).inMilliseconds / 1400;
    final t = age.clamp(0.0, 1.0);
    final opacity = 1.0 - t;
    return Positioned(
      child: Transform.translate(
        offset: Offset(p.dx * t, p.dy * t),
        child: Opacity(
          opacity: opacity,
          child: Text(p.emoji, style: const TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}

class _StatBar extends StatelessWidget {
  const _StatBar({required this.label, required this.value, required this.color});
  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    return SizedBox(
      width: 90,
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: tokens.ink2,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Container(
              height: 8,
              color: const Color(0x14000000),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: value / 100,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(999)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$value%',
            style: spaceGrotesk(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: tokens.ink,
            ),
          ),
        ],
      ),
    );
  }
}
