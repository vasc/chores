import 'package:flutter/material.dart';

import '../../theme.dart';
import 'icons.dart';

/// Darken/lighten a color by a percentage (positive brightens).
Color shade(Color c, int pct) {
  final r = (c.r * 255).round();
  final g = (c.g * 255).round();
  final b = (c.b * 255).round();
  int f(int v) {
    final shifted = (v + v * pct / 100).round();
    if (shifted < 0) return 0;
    if (shifted > 255) return 255;
    return shifted;
  }

  return Color.fromARGB((c.a * 255).round(), f(r), f(g), f(b));
}

// ── TokenPill ───────────────────────────────────────────
enum TokenPillSize { sm, md, lg }

class TokenPill extends StatelessWidget {
  const TokenPill({
    super.key,
    required this.value,
    this.size = TokenPillSize.md,
    this.dark = false,
  });

  final Object value;
  final TokenPillSize size;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final (h, fs, padL, padR, ic) = switch (size) {
      TokenPillSize.sm => (24.0, 13.0, 4.0, 8.0, 16.0),
      TokenPillSize.md => (32.0, 16.0, 6.0, 12.0, 20.0),
      TokenPillSize.lg => (44.0, 22.0, 8.0, 16.0, 28.0),
    };
    return Container(
      height: h,
      padding: EdgeInsets.only(left: padL, right: padR),
      decoration: BoxDecoration(
        color: dark ? const Color(0x1F000000) : const Color(0xFFFFF5D8),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: tokens.gold, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SavannaIcons.coin(size: ic, fill: tokens.gold),
          const SizedBox(width: 6),
          Text(
            '$value',
            style: spaceGrotesk(
              fontSize: fs,
              fontWeight: FontWeight.w700,
              color: tokens.ink,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }
}

// ── SavannaChip ──────────────────────────────────────────
class SavannaChip extends StatelessWidget {
  const SavannaChip({
    super.key,
    required this.label,
    this.color,
    this.background,
    this.icon,
  });

  final String label;
  final Color? color;
  final Color? background;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: background ?? tokens.gold.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[icon!, const SizedBox(width: 5)],
          Text(
            label,
            style: TextStyle(
              color: color ?? tokens.ink,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              fontSize: 12,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ── CuteButton ───────────────────────────────────────────
enum CuteButtonSize { md, lg }

class CuteButton extends StatefulWidget {
  const CuteButton({
    super.key,
    required this.child,
    this.onPressed,
    this.color,
    this.full = false,
    this.icon,
    this.size = CuteButtonSize.lg,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final Color? color;
  final bool full;
  final Widget? icon;
  final CuteButtonSize size;

  @override
  State<CuteButton> createState() => _CuteButtonState();
}

class _CuteButtonState extends State<CuteButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final c = widget.onPressed == null ? const Color(0xFFD8CFBF) : (widget.color ?? tokens.accent);
    final (h, fs, padH) = switch (widget.size) {
      CuteButtonSize.md => (44.0, 15.0, 20.0),
      CuteButtonSize.lg => (56.0, 17.0, 28.0),
    };
    final depth = shade(c, -15);
    final pressed = _pressed && widget.onPressed != null;

    final button = AnimatedContainer(
      duration: const Duration(milliseconds: 80),
      curve: Curves.easeOut,
      transform: Matrix4.translationValues(0, pressed ? 2 : 0, 0),
      height: h,
      padding: EdgeInsets.symmetric(horizontal: padH),
      decoration: BoxDecoration(
        color: c,
        borderRadius: BorderRadius.circular(999),
        boxShadow: widget.onPressed == null
            ? null
            : [
                BoxShadow(
                  color: depth,
                  offset: Offset(0, pressed ? 2 : 4),
                  blurRadius: 0,
                ),
                BoxShadow(
                  color: c.withValues(alpha: 0.25),
                  offset: const Offset(0, 8),
                  blurRadius: 20,
                ),
              ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: widget.full ? MainAxisSize.max : MainAxisSize.min,
        children: [
          if (widget.icon != null) ...[widget.icon!, const SizedBox(width: 8)],
          DefaultTextStyle.merge(
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w800,
              fontSize: fs,
              letterSpacing: -0.2,
            ),
            child: widget.child,
          ),
        ],
      ),
    );

    return GestureDetector(
      onTapDown: widget.onPressed == null ? null : (_) => setState(() => _pressed = true),
      onTapUp: widget.onPressed == null ? null : (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onPressed,
      behavior: HitTestBehavior.opaque,
      child: widget.full ? SizedBox(width: double.infinity, child: button) : button,
    );
  }
}

// ── XPBar ───────────────────────────────────────────────
class XpBar extends StatelessWidget {
  const XpBar({
    super.key,
    required this.xp,
    required this.max,
    required this.level,
    this.compact = false,
  });

  final int xp;
  final int max;
  final int level;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final pct = (xp / (max == 0 ? 1 : max)).clamp(0.0, 1.0);
    final knob = compact ? 28.0 : 34.0;
    return Row(
      children: [
        Container(
          width: knob,
          height: knob,
          decoration: BoxDecoration(
            color: tokens.accent,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(color: shade(tokens.accent, -20), offset: const Offset(0, 2), blurRadius: 0),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            '$level',
            style: spaceGrotesk(
              fontSize: compact ? 13 : 14,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'LVL $level',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: tokens.ink2,
                      letterSpacing: -0.1,
                    ),
                  ),
                  Text(
                    '$xp/$max XP',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: tokens.ink2,
                      letterSpacing: -0.1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  height: 10,
                  color: const Color(0x14000000),
                  child: Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: pct,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [tokens.gold, tokens.accent]),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 2,
                        right: 2,
                        top: 1,
                        child: Container(
                          height: 3,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── StreakPill ──────────────────────────────────────────
class StreakPill extends StatelessWidget {
  const StreakPill({super.key, required this.days});
  final int days;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 5, 10, 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [tokens.accent, tokens.gold],
        ),
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(color: tokens.accent.withValues(alpha: 0.3), offset: const Offset(0, 3), blurRadius: 10),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SavannaIcons.flame(size: 18),
          const SizedBox(width: 4),
          Text(
            '$days',
            style: spaceGrotesk(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}
