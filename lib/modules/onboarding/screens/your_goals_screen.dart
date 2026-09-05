import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mealist_ai/modules/onboarding/screens/widgets/goal_grid.dart';
import 'package:mealist_ai/modules/onboarding/screens/widgets/onboarding_bottom_bar.dart';
import 'package:mealist_ai/modules/onboarding/screens/widgets/top_nav.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../controllers/onboarding_controller.dart';

// your goals — step 1 of onboarding (figma: "Your goals")
// large grid of goal cards with icon + title + subtitle, single-select
class YourGoalsScreen extends GetView<OnboardingController> {
  const YourGoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(
        children: [
          // ─ top nav ───────────────────────────────────────────────────────
          const TopNav(),

          // ─ scrollable content ────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSpacing.md.h),

                  // headline
                  Text(
                    'Your goals',
                    style: AppTextStyles.headlineLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'What would you like Mealist to help you with?',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: AppSpacing.md.h),

                  // goal cards grid — figma uses 2-col grid
                  Obx(
                    () => GoalGrid(
                      goals: controller.goalOptions,
                      selectedGoal: controller.selectedGoal.value,
                      onSelect: controller.selectGoal,
                    ),
                  ),

                  SizedBox(height: AppSpacing.xxxl.h),
                ],
              ),
            ),
          ),

          // ─ bottom action bar ─────────────────────────────────────────────
          OnboardingBottomBar(
            currentStep: 1,
            totalSteps: 5,
            onContinue: controller.goToDietaryPreferences,
          ),
        ],
      ),
    );
  }
}
