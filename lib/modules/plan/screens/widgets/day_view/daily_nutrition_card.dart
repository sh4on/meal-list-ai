import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../controllers/plan_controller.dart';

class DailyNutritionCard extends StatelessWidget {
  final DayPlan plan;
  const DailyNutritionCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PlanController>();
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Daily Nutrition', style: AppTextStyles.titleLarge),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.successSurface,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      color: AppColors.primary,
                      size: 13,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Within today's target",
                      style: AppTextStyles.labelSmall
                          .copyWith(color: AppColors.primary, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md.h),
          Row(
            children: [
              Expanded(
                child: NutrientColumn(
                  label: 'Calories',
                  value: '${c.todayCalories}',
                  progress: c.todayCalories / c.todayCaloriesTarget,
                  barColor: AppColors.primary,
                ),
              ),
              Expanded(
                child: NutrientColumn(
                  label: 'Protein',
                  value: '${c.todayProtein}g',
                  progress: c.todayProtein / c.todayProteinTarget,
                  barColor: AppColors.progressProtein,
                ),
              ),
              Expanded(
                child: NutrientColumn(
                  label: 'Carbs',
                  value: '${c.todayCarbs}g',
                  progress: c.todayCarbs / c.todayCarbsTarget,
                  barColor: AppColors.progressCarbs,
                ),
              ),
              Expanded(
                child: NutrientColumn(
                  label: 'Fat',
                  value: '${c.todayFat}g',
                  progress: c.todayFat / c.todayFatTarget,
                  barColor: AppColors.progressFat,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NutrientColumn extends StatelessWidget {
  final String label;
  final String value;
  final double progress;
  final Color barColor;
  const NutrientColumn({
    super.key,
    required this.label,
    required this.value,
    required this.progress,
    required this.barColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyles.labelSmall
              .copyWith(color: AppColors.textTertiary, letterSpacing: 0.3),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.headlineSmall
              .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: 4,
            backgroundColor: AppColors.progressTrack,
            valueColor: AlwaysStoppedAnimation<Color>(barColor),
          ),
        ),
      ],
    );
  }
}

// ---- Day Meal Section -------------------------------------------------------
