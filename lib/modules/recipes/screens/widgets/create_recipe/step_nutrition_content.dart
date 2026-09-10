import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../controllers/recipe_creator_controller.dart';

// step 4 — nutrition: AI auto-estimate toggle and 2x2 macro cards
class StepNutritionContent extends StatelessWidget {
  final RecipeCreatorController ctrl;

  const StepNutritionContent({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSpacing.lg.h),

        const Text('Nutrition Facts', style: AppTextStyles.headlineLarge),
        SizedBox(height: AppSpacing.xs.h),
        Text(
          'Enter nutritional details per serving, or let Mealist AI estimate them for you based on ingredients.',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),

        SizedBox(height: AppSpacing.lg.h),

        // auto-estimate toggle card — accent-outlined when active
        Obx(
          () => GestureDetector(
            onTap: ctrl.toggleAutoEstimate,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(AppSpacing.cardPadding),
              decoration: BoxDecoration(
                color: ctrl.autoEstimateNutrition.value
                    ? AppColors.accentSurface
                    : AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: ctrl.autoEstimateNutrition.value
                      ? AppColors.accent
                      : AppColors.border,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // sparkle icon
                  const Icon(
                    Icons.auto_awesome,
                    color: AppColors.accent,
                    size: 20,
                  ),
                  SizedBox(width: AppSpacing.sm.w),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Auto-Estimate with AI',
                          style: AppTextStyles.titleSmall,
                        ),
                        Text(
                          "I don't know the exact values. Calculate based on my recipe.",
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  // checkbox reflecting toggle state
                  Container(
                    width: 22.w,
                    height: 22.w,
                    decoration: BoxDecoration(
                      color: ctrl.autoEstimateNutrition.value
                          ? AppColors.accent
                          : AppColors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: ctrl.autoEstimateNutrition.value
                            ? AppColors.accent
                            : AppColors.border,
                      ),
                    ),
                    child: ctrl.autoEstimateNutrition.value
                        ? const Icon(
                            Icons.check,
                            size: 14,
                            color: AppColors.white,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),

        SizedBox(height: AppSpacing.lg.h),

        // 2x2 macro grid
        Obx(
          () => GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: AppSpacing.sm.h,
            crossAxisSpacing: AppSpacing.sm.w,
            childAspectRatio: 1.5,
            children: [
              _MacroCard(
                label: 'Calories',
                value: ctrl.caloriesController.text,
                unit: 'kcal',
                showEstimatedBadge: ctrl.autoEstimateNutrition.value,
              ),
              _MacroCard(
                label: 'Protein',
                value: ctrl.proteinController.text,
                unit: 'g',
                showEstimatedBadge: ctrl.autoEstimateNutrition.value,
              ),
              _MacroCard(
                label: 'Carbs',
                value: ctrl.carbsController.text,
                unit: 'g',
                showEstimatedBadge: ctrl.autoEstimateNutrition.value,
              ),
              _MacroCard(
                label: 'Fat',
                value: ctrl.fatController.text,
                unit: 'g',
                showEstimatedBadge: ctrl.autoEstimateNutrition.value,
              ),
            ],
          ),
        ),

        SizedBox(height: AppSpacing.xxl.h),
      ],
    );
  }
}

// individual macro card showing label, value, and optional AI estimated badge
class _MacroCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final bool showEstimatedBadge;

  const _MacroCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.showEstimatedBadge,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // label + estimated badge row
          Row(
            children: [
              Text(label, style: AppTextStyles.labelMedium),
              if (showEstimatedBadge) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accentSurface,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.auto_awesome,
                        size: 10,
                        color: AppColors.accent,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        'ESTIMATED',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.accent,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),

          // big value number + unit
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: AppTextStyles.headlineMedium.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 2),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(unit, style: AppTextStyles.labelSmall),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
