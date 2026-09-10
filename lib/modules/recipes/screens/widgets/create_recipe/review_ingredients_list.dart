import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../controllers/recipe_creator_controller.dart';

// review ingredients section
// presents extracted ingredients with qty warnings, unit dropdowns, and an add button
class ReviewIngredientsList extends StatelessWidget {
  final RecipeCreatorController ctrl;

  const ReviewIngredientsList({
    super.key,
    required this.ctrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // section title
        Text(
          'Ingredients',
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppSpacing.sm.h),

        // reactive list of ingredient cards
        Obx(
          () => ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ctrl.ingredients.length,
            separatorBuilder: (final context, final index) =>
                SizedBox(height: AppSpacing.xs.h),
            itemBuilder: (final context, final index) {
              final Map<String, String> item = ctrl.ingredients[index];
              final String? warning = item['warning'];
              final bool hasWarning = warning != null && warning.isNotEmpty;

              return _ReviewIngredientRow(
                name: item['name'] ?? '',
                qty: item['qty'] ?? '',
                unit: item['unit'] ?? '',
                warning: warning,
                hasWarning: hasWarning,
              );
            },
          ),
        ),

        SizedBox(height: AppSpacing.xs.h),

        // dashed add ingredient cta button
        _AddIngredientReviewButton(ctrl: ctrl),
      ],
    );
  }
}

// individual ingredient row with structured columns matching the design
class _ReviewIngredientRow extends StatelessWidget {
  final String name;
  final String qty;
  final String unit;
  final String? warning;
  final bool hasWarning;

  const _ReviewIngredientRow({
    required this.name,
    required this.qty,
    required this.unit,
    required this.warning,
    required this.hasWarning,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // ingredient name field container
            Expanded(
              child: Container(
                height: 44.h,
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm.w),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  name,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(width: AppSpacing.xs.w),

            // quantity container with error indicator if unclear
            Container(
              height: 44.h,
              width: 72.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                // soft red surface calls out missing or ambiguous quantities
                color: hasWarning ? AppColors.errorSurface : AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(
                  color: hasWarning ? AppColors.error : AppColors.border,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    qty,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight:
                          hasWarning ? FontWeight.w500 : FontWeight.w700,
                      color: hasWarning
                          ? AppColors.textSecondary
                          : AppColors.textPrimary,
                    ),
                  ),
                  if (hasWarning) ...[
                    SizedBox(width: AppSpacing.xxs.w),
                    const Icon(
                      Icons.error_outline_rounded,
                      color: AppColors.error,
                      size: 15,
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: AppSpacing.xs.w),

            // measurement unit dropdown selector preview
            Container(
              height: 44.h,
              width: 82.w,
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      unit,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontStyle:
                            hasWarning ? FontStyle.italic : FontStyle.normal,
                        color: hasWarning
                            ? AppColors.textSecondary
                            : AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ],
        ),

        // error caption placed directly beneath row when quantity needs user review
        if (hasWarning) ...[
          SizedBox(height: AppSpacing.xxs.h),
          Row(
            children: [
              Text(
                '!',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                warning!,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

// dashed button for adding additional ingredients to the review list
class _AddIngredientReviewButton extends StatelessWidget {
  final RecipeCreatorController ctrl;

  const _AddIngredientReviewButton({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // appends a new editable ingredient item
      onTap: () => ctrl.addIngredient('New Ingredient', '1', 'cup'),
      child: Container(
        width: double.infinity,
        height: 44.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          color: Colors.transparent,
        ),
        child: CustomPaint(
          painter: const _DashedBorderPainter(
            color: AppColors.border,
            radius: AppRadius.sm,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add,
                color: AppColors.textSecondary,
                size: 16,
              ),
              SizedBox(width: AppSpacing.xs.w),
              Text(
                'Add Ingredient',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// custom painter that draws a dashed rounded rectangle border
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;

  const _DashedBorderPainter({required this.color, required this.radius});

  @override
  void paint(final Canvas canvas, final Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    const double dashWidth = 5;
    const double dashSpace = 4;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final Path path = Path()..addRRect(rrect);
    final ui.PathMetrics metrics = path.computeMetrics();

    for (final ui.PathMetric metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(
            distance,
            distance + dashWidth,
          ),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
