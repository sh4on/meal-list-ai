import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

// Animated rotating dashed / segmented ring matching Figma design
class RotatingDashedRing extends StatefulWidget {
  final double size;
  const RotatingDashedRing({super.key, this.size = 140});

  @override
  State<RotatingDashedRing> createState() => _RotatingDashedRingState();
}

class _RotatingDashedRingState extends State<RotatingDashedRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Animated rotating dashed ring
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 2 * math.pi,
                child: CustomPaint(
                  size: Size(widget.size, widget.size),
                  painter: _DashedRingPainter(),
                ),
              );
            },
          ),

          // Soft mint background glow circle
          Container(
            width: widget.size * 0.85,
            height: widget.size * 0.85,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFEAF4EF).withValues(alpha: 0.6),
            ),
          ),

          // Central solid dark green circle with sparkles
          Container(
            width: widget.size * 0.70,
            height: widget.size * 0.70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
            child: const Center(
              child: Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 38,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFB8D5C8)
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final radius = size.width / 2 - 2;
    final center = Offset(size.width / 2, size.height / 2);

    const int dashCount = 18;
    const double totalAngle = 2 * math.pi;
    const double dashAngle = (totalAngle / dashCount) * 0.55;
    const double gapAngle = (totalAngle / dashCount) * 0.45;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = i * (dashAngle + gapAngle);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        dashAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
