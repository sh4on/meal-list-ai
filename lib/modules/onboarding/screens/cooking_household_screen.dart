import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mealist_ai/modules/onboarding/screens/widgets/cooking_time_grid.dart';
import 'package:mealist_ai/modules/onboarding/screens/widgets/counter_row.dart';
import 'package:mealist_ai/modules/onboarding/screens/widgets/top_nav.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';
import '../controllers/onboarding_controller.dart';
import 'widgets/onboarding_progress_widget.dart';

// Tell us about your kitchen — step 5 (final) of onboarding
// cooking time card grid, cooking skill pills, household type cards,
// adults/children steppers, Finish Setup CTA
class CookingHouseholdScreen extends GetView<OnboardingController> {
  const CookingHouseholdScreen({super.key});

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
                    'Tell us about your\nkitchen',
                    style: AppTextStyles.headlineLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'This helps Mealist optimize recipes for your lifestyle.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),

                  SizedBox(height: AppSpacing.lg.h),

                  // ── Weekday cooking time ─────────────────────────────────
                  Text(
                    'Weekday cooking time',
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  Obx(
                    () => CookingTimeGrid(
                      times: controller.cookingTimes,
                      selected: controller.selectedCookingTime.value,
                      onSelect: controller.selectCookingTime,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // ── Cooking skill ────────────────────────────────────────
                  Text(
                    'Cooking skill',
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  Obx(
                    () => Row(
                      children: controller.cookingSkills.map((String skill) {
                        final bool isSelected =
                            controller.cookingSkill.value == skill;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => controller.setCookingSkill(skill),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: EdgeInsets.only(
                                right: skill != controller.cookingSkills.last
                                    ? 8
                                    : 0,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.transparent
                                    : Colors.transparent,
                                borderRadius:
                                    BorderRadius.circular(AppRadius.pill),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.border,
                                  width: isSelected ? 1.5 : 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  skill,
                                  style: AppTextStyles.labelMedium.copyWith(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.textSecondary,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // ── Household ────────────────────────────────────────────
                  Text(
                    'Household',
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  Obx(
                    () => GridView.count(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2.0,
                      children:
                          controller.householdTypes.map((Map<String, dynamic> h) {
                        final String label = h['label'] as String;
                        final bool isSelected =
                            controller.householdType.value == label;
                        return GestureDetector(
                          onTap: () => controller.selectHouseholdType(label),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primarySurface
                                  : AppColors.white,
                              borderRadius:
                                  BorderRadius.circular(AppRadius.md),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.border,
                                width: isSelected ? 1.5 : 1,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        h['icon'] as IconData,
                                        size: 26,
                                        color: isSelected
                                            ? AppColors.primary
                                            : AppColors.textSecondary,
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        label,
                                        style:
                                            AppTextStyles.labelMedium.copyWith(
                                          color: isSelected
                                              ? AppColors.primary
                                              : AppColors.textSecondary,
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // green dot top-right when selected
                                if (isSelected)
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: AppColors.primary,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // adults & children steppers (shown when Custom or always)
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        Obx(
                          () => CounterRow(
                            label: 'Adults',
                            value: controller.adultsCount.value,
                            onDecrement: () {
                              if (controller.adultsCount.value > 1) {
                                controller.adultsCount.value--;
                              }
                            },
                            onIncrement: () => controller.adultsCount.value++,
                          ),
                        ),
                        const Divider(
                          height: 1,
                          color: AppColors.divider,
                          indent: 16,
                          endIndent: 16,
                        ),
                        Obx(
                          () => CounterRow(
                            label: 'Children',
                            value: controller.childrenCount.value,
                            onDecrement: () {
                              if (controller.childrenCount.value > 0) {
                                controller.childrenCount.value--;
                              }
                            },
                            onIncrement: () => controller.childrenCount.value++,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: AppSpacing.xxxl.h),
                ],
              ),
            ),
          ),

          // ─ bottom action bar (step 5 = Finish Setup) ─────────────────────
          _OnboardingBottomBar(
            currentStep: 5,
            totalSteps: 5,
            onContinue: controller.finishOnboarding,
            buttonLabel: 'Finish Setup',
          ),
        ],
      ),
    );
  }
}

class _OnboardingBottomBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback onContinue;
  final String buttonLabel;

  const _OnboardingBottomBar({
    required this.currentStep,
    required this.totalSteps,
    required this.onContinue,
    this.buttonLabel = 'Continue',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenH.w,
        AppSpacing.md.h,
        AppSpacing.screenH.w,
        AppSpacing.xl.h,
      ),
      decoration: const BoxDecoration(
        color: AppColors.bg,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OnboardingProgressWidget(
            currentStep: currentStep,
            totalSteps: totalSteps,
          ),
          SizedBox(height: AppSpacing.md.h),
          PrimaryButtonWidget(label: buttonLabel, onTap: onContinue),
        ],
      ),
    );
  }
}
