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
import 'generate_plan_sheet.dart';
import 'week_day_accordion.dart';
import 'weekly_stat_card.dart';

// ---- WEEK VIEW --------------------------------------------------------------

class WeekView extends GetView<PlanController> {
  const WeekView({super.key});

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
          title: Text(
            'PLAN',
            style: AppTextStyles.headlineSmall
                .copyWith(color: AppColors.primary, letterSpacing: 1.5),
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
            preferredSize: Size.fromHeight(52),
            child: ViewModeToggle(),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xs.h)),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Obx(
              () => WeekDayAccordion(
                day: controller.weekPlan[index],
                dayIndex: index,
                isExpanded: controller.expandedDays.contains(index),
                onToggle: () => controller.toggleExpanded(index),
              ),
            ),
            childCount: controller.weekPlan.length,
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg.h)),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Weekly Overview', style: AppTextStyles.titleLarge),
                SizedBox(height: AppSpacing.sm.h),
                Row(
                  children: [
                    const Expanded(
                      child: WeeklyStatCard(
                        icon: Icons.bar_chart,
                        label: 'AVERAGE',
                        value: '1,840',
                        unit: 'kcal/day',
                      ),
                    ),
                    SizedBox(width: AppSpacing.sm.w),
                    const Expanded(
                      child: WeeklyStatCard(
                        icon: Icons.fitness_center,
                        label: 'PROTEIN',
                        value: '126g',
                        unit: '/day',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.sm.h),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.cardPadding),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.flag_outlined,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Goal Fit', style: AppTextStyles.titleSmall),
                            Text(
                              'On track for Weight Maintenance',
                              style: AppTextStyles.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.check_circle_outline,
                        color: AppColors.primary,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg.h)),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: AppSpacing.buttonHeight,
                  child: ElevatedButton.icon(
                    onPressed: () => showGeneratePlanSheet(context),
                    icon: const Icon(
                      Icons.auto_awesome,
                      size: 18,
                      color: AppColors.white,
                    ),
                    label: const Text(
                      'Generate / Adjust Plan',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppSpacing.sm.h),
                SizedBox(
                  width: double.infinity,
                  height: AppSpacing.buttonHeight,
                  child: OutlinedButton.icon(
                    onPressed: () => Get.toNamed(AppRoutes.shoppingList),
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    label: const Text(
                      'Create Grocery List',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 80.h)),
      ],
    );
  }
}
