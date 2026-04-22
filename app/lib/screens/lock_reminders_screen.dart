import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../auth/auth_controller.dart';
import '../theme.dart';

/// iOS-style lock screen mock with stacked Savanna push notifications.
/// Ported from the design's `LockReminderScreen`.
class LockRemindersScreen extends ConsumerStatefulWidget {
  const LockRemindersScreen({super.key});

  @override
  ConsumerState<LockRemindersScreen> createState() => _LockRemindersScreenState();
}

class _LockRemindersScreenState extends ConsumerState<LockRemindersScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _slide;

  @override
  void initState() {
    super.initState();
    _slide = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _slide.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.savanna;
    final auth = ref.watch(authControllerProvider);
    final me = auth.me;
    final kidName = me?.name ?? 'your buddy';

    final now = DateTime.now();
    final timeLabel = DateFormat('h:mm').format(now);
    final dateLabel = DateFormat('EEEE, MMMM d').format(now);

    final notifs = <_Notif>[
      _Notif(
        title: '$kidName is waiting on you!',
        body: '3 chores left today. Finish them all for a 🎁 mystery box.',
        ago: 'now',
        accent: tokens.accent,
        emoji: '🦁',
      ),
      _Notif(
        title: 'Streak at risk! 🔥',
        body: "You're on a ${me?.streakDays ?? 0}-day fire streak. Don't let it fizzle out.",
        ago: '30m ago',
        accent: tokens.gold,
        emoji: '🔥',
      ),
      _Notif(
        title: 'New chore available',
        body: '“Read for 20 minutes” just unlocked.',
        ago: '4h ago',
        accent: tokens.green,
        emoji: '📚',
      ),
    ];

    return Scaffold(
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity != null && details.primaryVelocity! < -200) {
            context.pop();
          }
        },
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF5B3A2E),
                Color(0xFF8C5A2E),
                Color(0xFFE8A75A),
                Color(0xFFF4B942),
              ],
              stops: [0, 0.3, 0.7, 1],
            ),
          ),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              // Sun halo
              Positioned(
                top: 140,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [Color(0xFFFFD666), Color(0xFFF4B942)],
                      ),
                      boxShadow: [
                        BoxShadow(color: Color(0x99FFD666), blurRadius: 80),
                      ],
                    ),
                  ),
                ),
              ),
              // Hills silhouette
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Opacity(
                  opacity: 0.35,
                  child: CustomPaint(
                    size: const Size.fromHeight(200),
                    painter: _BigHillsPainter(),
                  ),
                ),
              ),
              // Acacia
              Positioned(
                bottom: 40,
                right: 30,
                child: Opacity(
                  opacity: 0.5,
                  child: CustomPaint(
                    size: const Size(54, 54),
                    painter: _AcaciaBigPainter(),
                  ),
                ),
              ),
              // Time + date
              Positioned(
                top: MediaQuery.of(context).padding.top + 40,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Text(
                      dateLabel,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xE6FFFFFF),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      timeLabel,
                      style: spaceGrotesk(
                        fontSize: 92,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: -3,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              // Notification stack
              Positioned(
                left: 12,
                right: 12,
                top: MediaQuery.of(context).padding.top + 200,
                child: Column(
                  children: [
                    for (var i = 0; i < notifs.length; i++)
                      _SlideInNotif(
                        controller: _slide,
                        delay: i * 0.13,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _NotifCard(n: notifs[i]),
                        ),
                      ),
                  ],
                ),
              ),
              // Swipe-up hint
              Positioned(
                left: 0,
                right: 0,
                bottom: 54,
                child: _SwipeUpHint(onTap: () => context.pop()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Notif {
  _Notif({
    required this.title,
    required this.body,
    required this.ago,
    required this.accent,
    required this.emoji,
  });
  final String title;
  final String body;
  final String ago;
  final Color accent;
  final String emoji;
}

class _SlideInNotif extends StatelessWidget {
  const _SlideInNotif({
    required this.controller,
    required this.delay,
    required this.child,
  });

  final AnimationController controller;
  final double delay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        final local = ((controller.value - delay) / (1 - delay)).clamp(0.0, 1.0);
        final eased = Curves.easeOutCubic.transform(local);
        return Opacity(
          opacity: eased,
          child: Transform.translate(
            offset: Offset(0, -10 * (1 - eased)),
            child: child,
          ),
        );
      },
    );
  }
}

class _NotifCard extends StatelessWidget {
  const _NotifCard({required this.n});
  final _Notif n;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 0.5),
        boxShadow: const [
          BoxShadow(color: Color(0x14000000), blurRadius: 14, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: n.accent,
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(n.emoji, style: const TextStyle(fontSize: 13)),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'SAVANNA CHORES',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xBF3C2A1C),
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              Text(
                n.ago,
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0x8C3C2A1C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            n.title,
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2A1C10),
              letterSpacing: -0.2,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            n.body,
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF3C2A1C),
              letterSpacing: -0.1,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _SwipeUpHint extends StatefulWidget {
  const _SwipeUpHint({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_SwipeUpHint> createState() => _SwipeUpHintState();
}

class _SwipeUpHintState extends State<_SwipeUpHint> with SingleTickerProviderStateMixin {
  late final AnimationController _bob;

  @override
  void initState() {
    super.initState();
    _bob = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bob.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _bob,
              builder: (_, __) {
                final t = Curves.easeInOut.transform(_bob.value);
                return Transform.translate(
                  offset: Offset(0, -6 * t),
                  child: const SizedBox(
                    width: 26,
                    height: 26,
                    child: CustomPaint(painter: _UpArrowPainter()),
                  ),
                );
              },
            ),
            const SizedBox(height: 6),
            Text(
              'Swipe up to open',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.white.withValues(alpha: 0.9),
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UpArrowPainter extends CustomPainter {
  const _UpArrowPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final w = size.width, h = size.height;
    final path = Path()
      ..moveTo(w / 2, h * 18 / 26)
      ..lineTo(w / 2, h * 8 / 26)
      ..moveTo(w * 7 / 26, h * 14 / 26)
      ..lineTo(w / 2, h * 8 / 26)
      ..lineTo(w * 19 / 26, h * 14 / 26);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BigHillsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    double x(double v) => (v / 400) * w;
    double y(double v) => (v / 200) * h;
    final path = Path()
      ..moveTo(x(0), y(120))
      ..quadraticBezierTo(x(80), y(80), x(160), y(100))
      ..quadraticBezierTo(x(240), y(120), x(320), y(90))
      ..quadraticBezierTo(x(380), y(75), x(400), y(85))
      ..lineTo(x(400), y(200))
      ..lineTo(x(0), y(200))
      ..close();
    canvas.drawPath(path, Paint()..color = const Color(0xFF2A1C10));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AcaciaBigPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF2A1C10);
    final w = size.width, h = size.height;
    canvas.drawRect(Rect.fromLTWH(w * 24 / 54, h * 20 / 54, w * 5 / 54, h * 34 / 54), paint);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 26.5 / 54, h * 16 / 54),
        width: w * 48 / 54,
        height: h * 16 / 54,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
