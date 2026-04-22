import 'package:flutter/material.dart';

import '../../theme.dart';
import 'mascots.dart';

/// A visual mascot picker — big preview + 4x2 grid of selectable mascots.
/// Mirrors the design's onboarding "Pick your savanna buddy" screen and is
/// reusable from the add-child form.
class MascotPicker extends StatefulWidget {
  const MascotPicker({
    super.key,
    required this.initial,
    required this.onChanged,
    this.heroSize = 180,
  });

  final MascotKind initial;
  final ValueChanged<MascotKind> onChanged;
  final double heroSize;

  @override
  State<MascotPicker> createState() => _MascotPickerState();
}

class _MascotPickerState extends State<MascotPicker> with SingleTickerProviderStateMixin {
  late MascotKind _selected = widget.initial;
  late final AnimationController _bob;

  @override
  void initState() {
    super.initState();
    _bob = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bob.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final meta = mascotInfo[_selected]!;

    return Column(
      children: [
        AnimatedBuilder(
          animation: _bob,
          builder: (_, child) {
            final t = Curves.easeInOut.transform(_bob.value);
            return Transform.translate(
              offset: Offset(0, -6 * t),
              child: child,
            );
          },
          child: Container(
            width: widget.heroSize + 40,
            height: widget.heroSize + 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  meta.color.withValues(alpha: 0.4),
                  tokens.bg.withValues(alpha: 0),
                ],
                stops: const [0, 0.7],
              ),
            ),
            child: Mascot(kind: _selected, size: widget.heroSize),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${meta.name} the ${meta.species}',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w800,
            fontSize: 22,
            color: tokens.ink,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 20),
        GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            for (final kind in MascotKind.values)
              _Tile(
                kind: kind,
                selected: kind == _selected,
                onTap: () {
                  setState(() => _selected = kind);
                  widget.onChanged(kind);
                },
                accent: tokens.accent,
              ),
          ],
        ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.kind,
    required this.selected,
    required this.onTap,
    required this.accent,
  });

  final MascotKind kind;
  final bool selected;
  final VoidCallback onTap;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? Colors.white : Colors.white.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(20),
      // Design uses `box-shadow: 0 0 0 3px accent, 0 4px 12px rgba(0,0,0,0.1)`
      // for selection. Flutter's equivalent is a colored outer ring via
      // BoxDecoration shadow; we use a thick border + drop shadow below.
      shape: RoundedRectangleBorder(
        side: BorderSide(color: selected ? accent : Colors.transparent, width: 3),
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: selected ? 4 : 0,
      shadowColor: const Color(0x1A000000),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Mascot(kind: kind, size: 56),
        ),
      ),
    );
  }
}
