import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../controllers/plan_controller.dart';
import '../view_mode_toggle.dart';
import 'daily_nutrition_card.dart';
import 'day_meal_section.dart';

class DayView extends GetView<PlanController> {
  const DayView({super.key});

  @override
  Widget build(BuildContext context) {
    final today = controller.weekPlan[0];
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: AppColors.bg,
          elevation: 0,
          pinned: true,
          leadingWidth: 56.w,
          leading: Padding(
            padding: EdgeInsets.only(left: AppSpacing.md.w),
            child: const Icon(Icons.arrow_back, color: AppColors.primary),
          ),
          title: const Text(
            'Today',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
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
            preferredSize: Size.fromHeight(56),
            child: ViewModeToggle(),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.screenH.w,
              vertical: AppSpacing.sm.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.chevron_left,
                    color: AppColors.textSecondary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  children: [
                    Text('Monday, August 24', style: AppTextStyles.titleLarge),
                    SizedBox(height: 2),
                    Text('Today', style: AppTextStyles.bodySmall),
                  ],
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.chevron_right,
                    color: AppColors.textSecondary,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
            child: DailyNutritionCard(plan: today),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md.h)),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => DayMealSection(
              meal: today.meals[index],
              isLast: index == today.meals.length - 1,
            ),
            childCount: today.meals.length,
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 80.h)),
      ],
    );
  }
}
