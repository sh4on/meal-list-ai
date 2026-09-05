import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mealist_ai/modules/onboarding/screens/widgets/cuisine_group.dart';
import 'package:mealist_ai/modules/onboarding/screens/widgets/onboarding_bottom_bar.dart';
import 'package:mealist_ai/modules/onboarding/screens/widgets/top_nav.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../controllers/onboarding_controller.dart';

// What cuisines do you love? — step 3 of onboarding
// grouped by region with SELECT ALL per group, counter badge, real food photos
class FavouriteCuisinesScreen extends GetView<OnboardingController> {
  const FavouriteCuisinesScreen({super.key});

  // food photo map — using reliable unsplash images per cuisine
  static const Map<String, String> _cuisineImages = {
    'Italian':
        'https://images.unsplash.com/photo-1555949258-eb67b1ef0ceb?w=400&q=80',
    'Greek':
        'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?w=400&q=80',
    'Spanish':
        'https://images.unsplash.com/photo-1515443961218-a51367888e4b?w=400&q=80',
    'Moroccan':
        'https://images.unsplash.com/photo-1547592180-85f173990554?w=400&q=80',
    'Japanese':
        'https://images.unsplash.com/photo-1553621042-f6e147245754?w=400&q=80',
    'Thai':
        'https://images.unsplash.com/photo-1562565652-a0d8f0c59eb4?w=400&q=80',
    'Indian':
        'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=400&q=80',
    'Chinese':
        'https://images.unsplash.com/photo-1563245372-f21724e3856d?w=400&q=80',
    'Mexican':
        'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=400&q=80',
    'American':
        'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&q=80',
    'Brazilian':
        'https://images.unsplash.com/photo-1594212699903-ec8a3eca50f5?w=400&q=80',
    'Peruvian':
        'https://images.unsplash.com/photo-1630233553100-75dc5dbb1d2c?w=400&q=80',
  };

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
                    'What cuisines do you\nlove?',
                    style: AppTextStyles.headlineLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Choose at least 3 so Mealist can personalize your recommendations.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // selection counter badge
                  Obx(
                    () => controller.selectedCuisines.isNotEmpty
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primarySurface,
                              borderRadius:
                                  BorderRadius.circular(AppRadius.pill),
                              border: Border.all(color: AppColors.primary),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: AppColors.primary,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${controller.selectedCuisines.length} selected',
                                  style: AppTextStyles.labelMedium.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),

                  SizedBox(height: 16.h),

                  // cuisine groups
                  ...controller.cuisineGroups.map(
                    (Map<String, dynamic> group) {
                      final List<Map<String, dynamic>> cuisines =
                          (group['cuisines'] as List)
                              .cast<Map<String, dynamic>>();
                      return CuisineGroup(
                        groupName: group['group'] as String,
                        cuisines: cuisines,
                        cuisineImages: _cuisineImages,
                        controller: controller,
                      );
                    },
                  ),

                  SizedBox(height: AppSpacing.xxxl.h),
                ],
              ),
            ),
          ),

          // ─ bottom action bar ─────────────────────────────────────────────
          OnboardingBottomBar(
            currentStep: 3,
            totalSteps: 5,
            onContinue: controller.goToAllergies,
          ),
        ],
      ),
    );
  }
}
