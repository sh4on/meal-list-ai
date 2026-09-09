import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class FigmaBasketBadge extends StatelessWidget {
  const FigmaBasketBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 104,
        height: 104,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Light grey circular background
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0xFFE8E5DF),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: CustomPaint(
                  size: Size(40, 36),
                  painter: FigmaBasketPainter(
                    color: AppColors.primary,
                    holeColor: Color(0xFFE8E5DF),
                  ),
                ),
              ),
            ),

            // Green checkmark badge at bottom-right
            Positioned(
              bottom: 2,
              right: 2,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.bg,
                    width: 3,
                  ),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: AppColors.white,
                  size: 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FigmaBasketPainter extends CustomPainter {
  final Color color;
  final Color holeColor;

  const FigmaBasketPainter({
    required this.color,
    required this.holeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.8
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    // Handle
    final handleRect = Rect.fromCenter(
      center: Offset(w / 2, h * 0.44),
      width: w * 0.52,
      height: h * 0.65,
    );
    canvas.drawArc(handleRect, 3.14159, 3.14159, false, strokePaint);

    // Basket body trapezoid
    final topY = h * 0.45;
    final botY = h * 0.95;
    final topInset = w * 0.08;
    final botInset = w * 0.18;

    final bodyPath = Path()
      ..moveTo(topInset, topY)
      ..lineTo(w - topInset, topY)
      ..lineTo(w - botInset, botY)
      ..lineTo(botInset, botY)
      ..close();

    canvas.drawPath(bodyPath, paint);

    // Center cutout hole
    final holePaint = Paint()
      ..color = holeColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(w / 2, topY + (botY - topY) * 0.48),
      3.0,
      holePaint,
    );
  }

  @override
  bool shouldRepaint(covariant FigmaBasketPainter oldDelegate) =>
      color != oldDelegate.color || holeColor != oldDelegate.holeColor;
}
