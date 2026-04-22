import 'package:flutter/material.dart';

import '../../theme.dart';

enum SavannaBgVariant { day, dusk, plain }

class SavannaBg extends StatelessWidget {
  const SavannaBg({
    super.key,
    required this.child,
    this.variant = SavannaBgVariant.day,
  });

  final Widget child;
  final SavannaBgVariant variant;

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final gradient = switch (variant) {
      SavannaBgVariant.day => LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFFFDE4B2), tokens.bg],
          stops: const [0, 0.45],
        ),
      SavannaBgVariant.dusk => LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFFF9C3A0), const Color(0xFFFBD8AC), tokens.bg],
          stops: const [0, 0.4, 0.8],
        ),
      SavannaBgVariant.plain =>
        LinearGradient(colors: [tokens.bg, tokens.bg], begin: Alignment.topCenter, end: Alignment.bottomCenter),
    };

    return DecoratedBox(
      decoration: BoxDecoration(gradient: gradient),
      child: Stack(
        children: [
          Positioned(
            top: 180,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 0.18,
              child: CustomPaint(
                size: const Size.fromHeight(120),
                painter: _HillsPainter(color: tokens.brown),
              ),
            ),
          ),
          Positioned(
            top: 210,
            right: 20,
            child: Opacity(
              opacity: 0.25,
              child: CustomPaint(
                size: const Size(44, 44),
                painter: _AcaciaPainter(color: tokens.brown),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _HillsPainter extends CustomPainter {
  _HillsPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    double x(double v) => (v / 400) * w;
    double y(double v) => (v / 120) * h;
    final path = Path()
      ..moveTo(x(0), y(80))
      ..quadraticBezierTo(x(60), y(40), x(120), y(60))
      ..quadraticBezierTo(x(180), y(80), x(240), y(50))
      ..quadraticBezierTo(x(300), y(20), x(360), y(50))
      ..quadraticBezierTo(x(400), y(70), x(400), y(80))
      ..lineTo(x(400), y(120))
      ..lineTo(x(0), y(120))
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _HillsPainter oldDelegate) => oldDelegate.color != color;
}

class _AcaciaPainter extends CustomPainter {
  _AcaciaPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final w = size.width;
    final h = size.height;
    canvas.drawRect(Rect.fromLTWH(w * 20 / 44, h * 20 / 44, w * 4 / 44, h * 20 / 44), paint);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 22 / 44, h * 16 / 44),
        width: w * 40 / 44,
        height: h * 12 / 44,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _AcaciaPainter oldDelegate) => oldDelegate.color != color;
}
