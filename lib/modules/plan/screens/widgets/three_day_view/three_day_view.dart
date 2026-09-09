import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../routes/app_routes.dart';
import '../../../controllers/plan_controller.dart';
import '../view_mode_toggle.dart';
import '../day_view/meal_slot_actions_sheet.dart';

class ThreeDayView extends GetView<PlanController> {
  const ThreeDayView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: AppColors.bg,
          elevation: 0,
          pinned: true,
          leadingWidth: 48.w,
          leading: Padding(
            padding: EdgeInsets.only(left: AppSpacing.md.w),
            child: const Icon(Icons.restaurant_menu, color: AppColors.primary),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Plan',
                style: AppTextStyles.headlineSmall
                    .copyWith(color: AppColors.primary),
              ),
              const Text('Mon Aug 24 - Wed Aug 26',
                  style: AppTextStyles.bodySmall,),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: AppSpacing.md.w),
              child: CircleAvatar(
                radius: 18.r,
                backgroundImage: const NetworkImage(
                  'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100&q=80',
                ),
              ),
            ),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(52),
            child: ViewModeToggle(),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md.h)),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) =>
                ThreeDaySection(day: controller.weekPlan[index]),
            childCount: controller.weekPlan.take(3).length,
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 80.h)),
      ],
    );
  }
}

class ThreeDaySection extends StatelessWidget {
  final DayPlan day;
  const ThreeDaySection({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${day.dayName}, Aug ${day.dayNumber}',
                style: AppTextStyles.titleLarge,
              ),
              const Spacer(),
              Text(
                '${day.totalKcal} kcal',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.xs.h),
          ...day.meals.map((meal) => ThreeDayMealRow(meal: meal)),
          SizedBox(height: AppSpacing.md.h),
        ],
      ),
    );
  }
}

class ThreeDayMealRow extends StatelessWidget {
  final MealEntry meal;
  const ThreeDayMealRow({super.key, required this.meal});

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
            'plannedFor': 'Monday $label',
            'whyPicked': meal.aiInsightText ??
                'Matches your high-protein goal for ${label.toLowerCase()} while keeping prep time under 30 minutes.',
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  child: Image.network(
                    meal.imageAsset,
                    width: 68,
                    height: 68,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 68,
                      height: 68,
                      color: AppColors.shimmerBase,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  left: 4,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: meal.mealTypeColor,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      meal.mealType[0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        Icons.access_time_outlined,
                        size: 12,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        meal.time,
                        style: AppTextStyles.bodySmall.copyWith(fontSize: 12),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.local_fire_department_outlined,
                        size: 12,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${meal.kcal} kcal',
                        style: AppTextStyles.bodySmall.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => showMealSlotActions(context, meal),
              child: const Icon(
                Icons.more_vert,
                color: AppColors.textTertiary,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
