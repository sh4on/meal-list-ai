import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mealist_ai/modules/onboarding/screens/widgets/onboarding_bottom_bar.dart';
import 'package:mealist_ai/modules/onboarding/screens/widgets/top_nav.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';
import '../../../shared/common_widgets/selection_chip_widget.dart';
import '../controllers/onboarding_controller.dart';
import 'widgets/onboarding_progress_widget.dart';
import 'widgets/onboarding_option_card_widget.dart';

// dietary preferences — step 2 of onboarding (figma: "Dietary preferences")
// 2-column grid of diet cards + nutrition focus chips
class DietaryPreferencesScreen extends GetView<OnboardingController> {
  const DietaryPreferencesScreen({super.key});

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

                  Text(
                    'Dietary preferences',
                    style: AppTextStyles.headlineLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Tell us how you prefer to eat.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),

                  SizedBox(height: AppSpacing.lg.h),

                  // 2-column diet option grid
                  GridView.builder(
                    padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.6,
                      ),
                      itemCount: controller.dietOptions.length,
                      itemBuilder: (_, int index) {
                        final String diet = controller.dietOptions[index];
                        final bool isSelected =
                            controller.selectedDiet.value == diet;
                        return OnboardingOptionCardWidget(
                          title: diet,
                          subtitle: _dietSubtitle(diet),
                          isSelected: isSelected,
                          onTap: () => controller.selectDiet(diet),
                        );
                      },
                    ),


                  SizedBox(height: AppSpacing.sectionGap.h),

                  // nutrition focuses section
                  const Text(
                    'Nutrition focuses',
                    style: AppTextStyles.headlineSmall,
                  ),
                  SizedBox(height: AppSpacing.xs.h),
                  const Text(
                    'Optional • Select all that apply',
                    style: AppTextStyles.bodySmall,
                  ),

                  SizedBox(height: AppSpacing.md.h),

                  // horizontal wrap of nutrition chips
                  Obx(
                    () => Wrap(
                      spacing: AppSpacing.xs,
                      runSpacing: AppSpacing.xs,
                      children: controller.nutritionFocuses.map((String f) {
                        return SelectionChipWidget(
                          label: f,
                          isSelected:
                              controller.selectedNutritionFocuses.contains(f),
                          onTap: () => controller.toggleNutritionFocus(f),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: AppSpacing.xxxl.h),
                ],
              ),
            ),
          ),

          // ─ bottom progress + continue button ─────────────────────────────
          OnboardingBottomBar(
            currentStep: 2,
            totalSteps: 5,
            onContinue: controller.goToFavouriteCuisines,
          ),
        ],
      ),
    );
  }

  // helper to provide subtitle text for each diet option
  String _dietSubtitle(String diet) {
    const Map<String, String> subtitles = {
      'No preference': 'I eat a bit of everything',
      'Vegetarian': 'Plant-based & dairy',
      'Vegan': 'Strictly plant-based',
      'Pescatarian': 'Vegetarian + seafood',
      'Keto': 'High fat, low carb',
      'Paleo': 'Whole foods focused',
    };
    return subtitles[diet] ?? '';
  }
}
