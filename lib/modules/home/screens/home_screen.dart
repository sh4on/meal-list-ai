import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../controllers/home_controller.dart';
import 'widgets/calorie_ring_widget.dart';
import 'widgets/meal_card_widget.dart';
import 'widgets/quick_actions_widget.dart';
import 'widgets/for_you_card_widget.dart';

// home screen — today's plan overview
// all complex sections extracted to dedicated widget files per rules
class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // app bar with logo + avatar
            SliverAppBar(
              backgroundColor: AppColors.bg,
              floating: true,
              snap: true,
              elevation: 0,
              scrolledUnderElevation: 0,
              title: Text(
                'Mealist.ai',
                style: AppTextStyles.logoMark.copyWith(fontSize: 24),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications,
                    color: AppColors.primary,
                  ),
                  onPressed: () {},
                ),
                Padding(
                  padding: EdgeInsets.only(right: AppSpacing.md.w),
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100&q=80',
                    ),
                  ),
                ),
              ],
            ),

            // scrollable content
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: AppSpacing.md.h),

                  // greeting section
                  Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${controller.greeting.value}, ${controller.userName.value}',
                          style: AppTextStyles.headlineLarge,
                        ),
                        Text(
                          controller.dateLabel.value,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: AppSpacing.xl.h),

                  // macro summary ring card
                  Obx(
                    () => CalorieRingWidget(
                      consumed: controller.consumedCalories.value,
                      total: controller.totalCalories.value,
                      proteinConsumed: controller.proteinConsumed.value,
                      proteinTotal: controller.proteinTotal.value,
                      carbsConsumed: controller.carbsConsumed.value,
                      carbsTotal: controller.carbsTotal.value,
                      fatConsumed: controller.fatConsumed.value,
                      fatTotal: controller.fatTotal.value,
                    ),
                  ),

                  SizedBox(height: AppSpacing.sectionGap.h),

                  // today's meals section header
                  const Text(
                    "Today's Meals",
                    style: AppTextStyles.headlineSmall,
                  ),
                  SizedBox(height: AppSpacing.md.h),

                  // meal cards list
                  Obx(
                    () => Column(
                      children: controller.todaysMeals
                          .map(
                            (Map<String, dynamic> meal) =>
                                MealCardWidget(meal: meal),
                          )
                          .toList(),
                    ),
                  ),

                  SizedBox(height: AppSpacing.sectionGap.h),

                  // quick actions grid
                  const Text(
                    'Quick Actions',
                    style: AppTextStyles.headlineSmall,
                  ),
                  SizedBox(height: AppSpacing.md.h),
                  const QuickActionsWidget(),

                  SizedBox(height: AppSpacing.sectionGap.h),

                  // ai for-you recommendation card
                  const ForYouCardWidget(),

                  SizedBox(height: AppSpacing.xxxl.h),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
