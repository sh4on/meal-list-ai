import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../routes/app_routes.dart';
import '../../../controllers/plan_controller.dart';
import 'meal_slot_actions_sheet.dart';

class DayMealSection extends StatelessWidget {
  final MealEntry meal;
  final bool isLast;
  const DayMealSection({super.key, required this.meal, required this.isLast});

  IconData get _mealIcon => switch (meal.mealType) {
        'BREAKFAST' => Icons.wb_sunny_outlined,
        'LUNCH' => Icons.wb_sunny,
        'DINNER' => Icons.nightlight_round,
        _ => Icons.restaurant,
      };

  String get _mealLabel =>
      meal.mealType[0] + meal.mealType.substring(1).toLowerCase();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
          child: Row(
            children: [
              Icon(_mealIcon, color: AppColors.primary, size: 18),
              const SizedBox(width: 6),
              Text(_mealLabel, style: AppTextStyles.titleMedium),
              const Spacer(),
              Text(
                meal.time,
                style: AppTextStyles.labelMedium
                    .copyWith(color: AppColors.textTertiary),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.xs.h),
        GestureDetector(
          onTap: () {
            Get.toNamed(
              AppRoutes.recipeDetails,
              arguments: {
                'name': meal.name,
                'time': meal.time,
                'kcal': '${meal.kcal} kcal',
                'kcalVal': '${meal.kcal}',
                'protein': '${meal.proteinG}g',
                'carbs': '65g',
                'fat': '18g',
                'servings': meal.servings,
                'image': meal.imageAsset,
                'plannedFor': 'Monday $_mealLabel',
                'whyPicked': meal.aiInsightText ??
                    'Matches your high-protein goal for ${_mealLabel.toLowerCase()} while keeping prep time under 30 minutes.',
              },
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: AppColors.border),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    meal.imageAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.shimmerBase,
                      child: const Center(
                        child: Icon(
                          Icons.restaurant,
                          color: AppColors.textTertiary,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.cardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              meal.name,
                              style: AppTextStyles.titleLarge,
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => showMealSlotActions(context, meal),
                            child: const Icon(
                              Icons.more_vert,
                              color: AppColors.textSecondary,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        meal.description,
                        style: AppTextStyles.bodyMedium
                            .copyWith(color: AppColors.textSecondary),
                      ),
                      SizedBox(height: AppSpacing.sm.h),
                      Row(
                        children: [
                          MetaChip(
                            icon: Icons.local_fire_department_outlined,
                            label: '${meal.kcal} kcal',
                          ),
                          const SizedBox(width: 12),
                          MetaChip(
                            icon: Icons.fitness_center,
                            label: '${meal.proteinG}g',
                            iconSize: 12,
                          ),
                          const SizedBox(width: 12),
                          MetaChip(
                            icon: Icons.restaurant_outlined,
                            label:
                                '${meal.servings} serving${meal.servings > 1 ? "s" : ""}',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (meal.hasAiInsight && meal.aiInsightText != null)
          Container(
            margin: EdgeInsets.fromLTRB(
              AppSpacing.screenH.w,
              AppSpacing.xs.h,
              AppSpacing.screenH.w,
              0,
            ),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.accentSurface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.accent.withOpacity(0.4)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.auto_awesome,
                  color: AppColors.accent,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    meal.aiInsightText!,
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.textPrimary, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: isLast ? 0 : AppSpacing.md.h),
      ],
    );
  }
}

class MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final double iconSize;
  const MetaChip({
    super.key,
    required this.icon,
    required this.label,
    this.iconSize = 13,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: iconSize, color: AppColors.textTertiary),
        const SizedBox(width: 3),
        Text(
          label,
          style: AppTextStyles.bodySmall
              .copyWith(color: AppColors.textSecondary, fontSize: 12),
        ),
      ],
    );
  }
}

// ---- Meal Slot Actions Sheet ------------------------------------------------
