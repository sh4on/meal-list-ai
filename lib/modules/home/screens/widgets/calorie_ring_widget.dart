import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';

// calorie ring summary card — matches figma: donut ring left, macro bars right
class CalorieRingWidget extends StatelessWidget {
  final int consumed;
  final int total;
  final double proteinConsumed;
  final double proteinTotal;
  final double carbsConsumed;
  final double carbsTotal;
  final double fatConsumed;
  final double fatTotal;

  const CalorieRingWidget({
    super.key,
    required this.consumed,
    required this.total,
    required this.proteinConsumed,
    required this.proteinTotal,
    required this.carbsConsumed,
    required this.carbsTotal,
    required this.fatConsumed,
    required this.fatTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // donut ring showing calorie progress
          SizedBox(
            width: AppSpacing.calorieRingSize.w,
            height: AppSpacing.calorieRingSize.w,
            child: CustomPaint(
              painter: _DonutPainter(
                progress: consumed / total,
                ringColor: AppColors.primary,
                trackColor: AppColors.progressTrack,
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$consumed',
                      style: AppTextStyles.calorieNumber,
                    ),
                    Text(
                      '/ $total',
                      style: AppTextStyles.calorieUnit,
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(width: AppSpacing.lg.w),

          // macro progress bars
          Expanded(
            child: Column(
              children: [
                _MacroBar(
                  label: 'Protein',
                  consumed: proteinConsumed,
                  total: proteinTotal,
                  color: AppColors.progressProtein,
                ),
                SizedBox(height: AppSpacing.sm.h),
                _MacroBar(
                  label: 'Carbs',
                  consumed: carbsConsumed,
                  total: carbsTotal,
                  color: AppColors.progressCarbs,
                ),
                SizedBox(height: AppSpacing.sm.h),
                _MacroBar(
                  label: 'Fat',
                  consumed: fatConsumed,
                  total: fatTotal,
                  color: AppColors.progressFat,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// individual macro label + progress bar row
class _MacroBar extends StatelessWidget {
  final String label;
  final double consumed;
  final double total;
  final Color color;

  const _MacroBar({
    required this.label,
    required this.consumed,
    required this.total,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (consumed / total).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTextStyles.labelMedium),
            Text(
              '${consumed.toInt()}/${total.toInt()}g',
              style: AppTextStyles.labelMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.progressTrack,
            color: color,
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}

// custom painter for the donut ring
class _DonutPainter extends CustomPainter {
  final double progress;
  final Color ringColor;
  final Color trackColor;

  const _DonutPainter({
    required this.progress,
    required this.ringColor,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 10;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = (size.width - strokeWidth) / 2;

    // track arc (background)
    final Paint trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    // progress arc
    final Paint progressPaint = Paint()
      ..color = ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_DonutPainter old) => old.progress != progress;
}
