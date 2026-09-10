import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../controllers/recipe_creator_controller.dart';

// nutrition 2x2 grid section for recipe review
// highlights key macros with ai-estimated badge matching the figma design
class ReviewNutritionGrid extends StatelessWidget {
  final RecipeCreatorController ctrl;

  const ReviewNutritionGrid({
    super.key,
    required this.ctrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // header row with section title and ai estimated badge
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nutrition',
              style: AppTextStyles.headlineSmall.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),

            // ai estimated badge indicating automated calculation
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.accentSurface,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.auto_awesome,
                    size: 13,
                    color: AppColors.accent,
                  ),
                  SizedBox(width: AppSpacing.xxs.w),
                  Text(
                    'AI Estimated',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.sm.h),

        // 2x2 grid: calories & protein in row 1, carbs & fat in row 2
        Row(
          children: [
            Expanded(
              child: _MacroCard(
                label: 'Calories',
                value: ctrl.caloriesController.text.isNotEmpty
                    ? ctrl.caloriesController.text
                    : '420',
              ),
            ),
            SizedBox(width: AppSpacing.sm.w),
            Expanded(
              child: _MacroCard(
                label: 'Protein',
                value:
                    '${ctrl.proteinController.text.isNotEmpty ? ctrl.proteinController.text : '32'}g',
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.sm.h),
        Row(
          children: [
            Expanded(
              child: _MacroCard(
                label: 'Carbs',
                value:
                    '${ctrl.carbsController.text.isNotEmpty ? ctrl.carbsController.text : '45'}g',
              ),
            ),
            SizedBox(width: AppSpacing.sm.w),
            Expanded(
              child: _MacroCard(
                label: 'Fat',
                value:
                    '${ctrl.fatController.text.isNotEmpty ? ctrl.fatController.text : '12'}g',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// individual macro value card with centered typography
class _MacroCard extends StatelessWidget {
  final String label;
  final String value;

  const _MacroCard({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // macro category label
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppSpacing.xxs.h),

          // bold primary colored numeric macro value
          Text(
            value,
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
