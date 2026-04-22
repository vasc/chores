import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../graphql/operations/fragments.graphql.dart';
import '../../graphql/schema.graphql.dart';
import '../../theme.dart';
import 'atoms.dart';

class LootBoxOverlay extends StatefulWidget {
  const LootBoxOverlay({
    super.key,
    required this.tokens,
    required this.xp,
    required this.drop,
    this.onDone,
  });

  final int tokens;
  final int xp;
  final Fragment$LootDropFields drop;
  final VoidCallback? onDone;

  @override
  State<LootBoxOverlay> createState() => _LootBoxOverlayState();
}

enum _Stage { intro, shaking, opening, reveal }

class _LootBoxOverlayState extends State<LootBoxOverlay> with TickerProviderStateMixin {
  _Stage _stage = _Stage.intro;
  late final AnimationController _spin;
  late final AnimationController _shake;
  late final AnimationController _lid;
  late final AnimationController _confetti;

  @override
  void initState() {
    super.initState();
    _spin = AnimationController(vsync: this, duration: const Duration(seconds: 8))..repeat();
    _shake = AnimationController(vsync: this, duration: const Duration(milliseconds: 250))..repeat();
    _lid = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _confetti = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) setState(() => _stage = _Stage.shaking);
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (!mounted) return;
      setState(() => _stage = _Stage.opening);
      _lid.forward();
    });
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (!mounted) return;
      setState(() => _stage = _Stage.reveal);
      _confetti.forward();
    });
  }

  @override
  void dispose() {
    _spin.dispose();
    _shake.dispose();
    _lid.dispose();
    _confetti.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final presentation = _rarityPresentation(widget.drop.rarity);
    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        onTap: _stage == _Stage.reveal ? widget.onDone : null,
        child: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [Color(0xFF3A2815), Color(0xFF1A0F08)],
              stops: [0, 1],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (_stage == _Stage.reveal)
                AnimatedBuilder(
                  animation: _spin,
                  builder: (_, __) {
                    return Transform.rotate(
                      angle: _spin.value * 2 * math.pi,
                      child: CustomPaint(
                        size: const Size.square(800),
                        painter: _RaysPainter(color: presentation.glow),
                      ),
                    );
                  },
                ),
              if (_stage == _Stage.reveal)
                AnimatedBuilder(
                  animation: _confetti,
                  builder: (_, __) => CustomPaint(
                    size: const Size.square(400),
                    painter: _ConfettiPainter(_confetti.value),
                  ),
                ),
              if (_stage == _Stage.intro)
                Positioned(
                  top: 80,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Text(
                        widget.drop.isQuestBonus ? 'DAILY QUEST BONUS' : 'CHORE COMPLETE',
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xB3FFFFFF),
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'You earned a loot box!',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          color: Colors.white,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ],
                  ),
                ),
              if (_stage != _Stage.reveal) _buildBox(),
              if (_stage == _Stage.reveal) _buildReveal(presentation),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBox() {
    final shaking = _stage == _Stage.shaking;
    final opening = _stage == _Stage.opening || _stage == _Stage.reveal;

    return AnimatedBuilder(
      animation: _shake,
      builder: (_, child) {
        double dx = 0, dy = 0, angle = 0;
        if (shaking) {
          final t = _shake.value;
          dx = math.sin(t * math.pi * 4) * 4;
          dy = math.cos(t * math.pi * 3) * 2;
          angle = math.sin(t * math.pi * 4) * 0.035;
        }
        return Transform.translate(
          offset: Offset(dx, dy),
          child: Transform.rotate(angle: angle, child: child),
        );
      },
      child: SizedBox(
        width: 180,
        height: 160,
        child: Stack(
          children: [
            // base
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 110,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFC8843A), Color(0xFF8B5A24)],
                  ),
                  border: Border.all(color: const Color(0xFF5C3A14), width: 3),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(14),
                    bottomRight: Radius.circular(14),
                  ),
                  boxShadow: const [
                    BoxShadow(color: Color(0x66F4A73E), blurRadius: 40, offset: Offset(0, 10)),
                  ],
                ),
              ),
            ),
            // metal band
            Positioned(
              left: 0,
              right: 0,
              bottom: 50,
              height: 14,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFF4C770), Color(0xFFC8843A)],
                  ),
                  border: Border(
                    top: BorderSide(color: Color(0xFF5C3A14), width: 2),
                    bottom: BorderSide(color: Color(0xFF5C3A14), width: 2),
                  ),
                ),
              ),
            ),
            // lock
            Positioned(
              top: 78,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    gradient: const RadialGradient(
                      center: Alignment(-0.2, -0.4),
                      colors: [Color(0xFFFFE49B), Color(0xFFC8843A)],
                    ),
                    border: Border.all(color: const Color(0xFF5C3A14), width: 2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '★',
                    style: TextStyle(color: Color(0xFF5C3A14), fontWeight: FontWeight.w900, fontSize: 14),
                  ),
                ),
              ),
            ),
            // lid
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: 70,
              child: AnimatedBuilder(
                animation: _lid,
                builder: (_, __) {
                  final t = _lid.value;
                  final rotation = opening ? -t * (55 * math.pi / 180) : 0.0;
                  final dy = opening ? -t * 8 : 0.0;
                  return Transform(
                    alignment: Alignment.bottomLeft,
                    transform: Matrix4.identity()
                      ..translateByDouble(0, dy, 0, 1)
                      ..rotateZ(rotation),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFFE0A04A), Color(0xFFB57A2E)],
                        ),
                        border: Border.all(color: const Color(0xFF5C3A14), width: 3),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14),
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (opening)
              Positioned(
                top: 10,
                left: 30,
                right: 30,
                child: AnimatedBuilder(
                  animation: _lid,
                  builder: (_, __) {
                    return Opacity(
                      opacity: _lid.value,
                      child: Container(
                        height: 160,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [Color(0xFFFFE49B), Color(0x00FFE49B)],
                            stops: [0, 0.7],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildReveal(_Presentation p) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.drop.rarity.name.toUpperCase(),
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w900,
            fontSize: 11,
            color: p.color,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [p.color, p.color.withValues(alpha: 0.8)],
            ),
            border: Border.all(color: p.color, width: 3),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(color: p.glow, blurRadius: 60),
            ],
          ),
          alignment: Alignment.center,
          child: Text(widget.drop.itemEmoji, style: const TextStyle(fontSize: 72)),
        ),
        const SizedBox(height: 14),
        Text(
          widget.drop.itemLabel,
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w900,
            fontSize: 22,
            color: Colors.white,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.drop.itemDescription,
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 13,
            color: Color(0xB3FFFFFF),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TokenPill(value: '+${widget.tokens}'),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0x33F46A4E),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                '✨ +${widget.xp} XP',
                style: spaceGrotesk(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFF46A4E),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Tap to continue',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.5),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _Presentation {
  const _Presentation({required this.color, required this.glow});
  final Color color;
  final Color glow;
}

_Presentation _rarityPresentation(Enum$LootRarity rarity) {
  switch (rarity) {
    case Enum$LootRarity.common:
      return const _Presentation(color: Color(0xFF9BB3A0), glow: Color(0x999BB3A0));
    case Enum$LootRarity.rare:
      return const _Presentation(color: Color(0xFF3B7EA1), glow: Color(0xB33B7EA1));
    case Enum$LootRarity.epic:
      return const _Presentation(color: Color(0xFFA45BD6), glow: Color(0xCCA45BD6));
    case Enum$LootRarity.legendary:
      return const _Presentation(color: Color(0xFFF4A73E), glow: Color(0xE6F4A73E));
    case Enum$LootRarity.$unknown:
      return const _Presentation(color: Color(0xFF9BB3A0), glow: Color(0x999BB3A0));
  }
}

class _RaysPainter extends CustomPainter {
  _RaysPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.withValues(alpha: 0.25);
    final radius = size.width * 0.5;
    const segments = 18;
    final center = Offset(size.width / 2, size.height / 2);
    for (int i = 0; i < segments; i++) {
      if (i.isOdd) continue;
      final start = (i / segments) * 2 * math.pi;
      final end = ((i + 1) / segments) * 2 * math.pi;
      final path = Path()
        ..moveTo(center.dx, center.dy)
        ..lineTo(center.dx + radius * math.cos(start), center.dy + radius * math.sin(start))
        ..arcTo(
          Rect.fromCircle(center: center, radius: radius),
          start,
          end - start,
          false,
        )
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _RaysPainter oldDelegate) => oldDelegate.color != color;
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter(this.t);
  final double t;

  static const _colors = [
    Color(0xFFF4A73E),
    Color(0xFFF46A4E),
    Color(0xFF2F6F4E),
    Color(0xFF3B7EA1),
    Color(0xFFFFD166),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.45);
    final rnd = math.Random(42);
    for (int i = 0; i < 14; i++) {
      final dx = (rnd.nextDouble() - 0.5) * 360;
      final dy = -80 - rnd.nextDouble() * 180;
      final rotation = rnd.nextDouble() * 2 * math.pi;
      final color = _colors[i % _colors.length];
      final paint = Paint()..color = color.withValues(alpha: 1 - t);
      canvas.save();
      canvas.translate(center.dx + dx * t, center.dy + dy * t);
      canvas.rotate(rotation * t);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(-4, -4, 8, 8),
          const Radius.circular(2),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) => oldDelegate.t != t;
}
