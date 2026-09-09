import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../routes/app_routes.dart';
import '../../../controllers/plan_controller.dart';
import '../day_view/meal_slot_actions_sheet.dart';

class WeekDayAccordion extends StatelessWidget {
  final DayPlan day;
  final int dayIndex;
  final bool isExpanded;
  final VoidCallback onToggle;
  const WeekDayAccordion({
    super.key,
    required this.day,
    required this.dayIndex,
    required this.isExpanded,
    required this.onToggle,
  });

  String get _subtitle {
    if (day.dayLabel == 'Today') return 'Today - ${day.meals.length} meals';
    if (day.dayLabel == 'Tomorrow') {
      return 'Tomorrow - ${day.meals.length} meals planned';
    }
    return '${day.meals.length} meals planned';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.cardPadding,
                vertical: 14,
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: dayIndex == 0
                          ? AppColors.primary
                          : AppColors.cardBgSecondary,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${day.dayNumber}',
                      style: TextStyle(
                        color: dayIndex == 0
                            ? AppColors.white
                            : AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(day.dayName, style: AppTextStyles.titleMedium),
                        Text(_subtitle, style: AppTextStyles.bodySmall),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.textSecondary,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: isExpanded
                ? Column(
                    children: day.meals
                        .map((meal) => WeekMealRow(meal: meal))
                        .toList(),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class WeekMealRow extends StatelessWidget {
  final MealEntry meal;
  const WeekMealRow({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final label =
            meal.mealType[0] + meal.mealType.substring(1).toLowerCase();
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
            'plannedFor': label,
            'whyPicked': meal.aiInsightText ??
                'Matches your high-protein goal for ${label.toLowerCase()} while keeping prep time under 30 minutes.',
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.cardPadding,
          vertical: 4,
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.bg,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  child: Image.network(
                    meal.imageAsset,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 64,
                      height: 64,
                      color: AppColors.shimmerBase,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(AppRadius.xs),
                  ),
                  child: Text(
                    meal.time,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.mealType,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: meal.mealTypeColor,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    meal.name,
                    style: AppTextStyles.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.local_fire_department_outlined,
                        size: 11,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${meal.kcal} kcal',
                        style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        ' - ',
                        style: TextStyle(
                          color: AppColors.textTertiary,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.restaurant_outlined,
                        size: 11,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${meal.servings} serving${meal.servings > 1 ? "s" : ""}',
                        style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => showMealSlotActions(context, meal),
              child: const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Icon(
                  Icons.more_vert,
                  color: AppColors.textTertiary,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
