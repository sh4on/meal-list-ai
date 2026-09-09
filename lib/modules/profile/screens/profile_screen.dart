import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mealist_ai/modules/profile/screens/widgets/mealPlan_dna_card.dart';
import 'package:mealist_ai/modules/profile/screens/widgets/settings_section.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../controllers/profile_controller.dart';

// profile screen — matches figma: avatar, completion bar, meal plan DNA card,
// settings groups, account group
class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.bg,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Icon(
            Icons.restaurant_menu_outlined,
            color: AppColors.textPrimary,
          ),
        ),
        title: Text(
          'Mealist.ai',
          style: AppTextStyles.logoMark.copyWith(
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: AppColors.textPrimary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppSpacing.lg.h),

            // avatar with edit button
            Stack(
              children: [
                const CircleAvatar(
                  radius: AppSpacing.avatarXl / 2,
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&q=80',
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: AppColors.white,
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSpacing.md.h),

            // user name and email
            Obx(
              () => Column(
                children: [
                  Text(
                    controller.userName.value,
                    style: AppTextStyles.headlineSmall,
                  ),
                  Text(
                    controller.userEmail.value,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.lg.h),

            // profile completion progress bar
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile ${(controller.profileCompletion.value * 100).toInt()}% complete',
                    style: AppTextStyles.labelMedium,
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    child: LinearProgressIndicator(
                      value: controller.profileCompletion.value,
                      backgroundColor: AppColors.progressTrack,
                      color: AppColors.primary,
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.xl.h),

            // meal plan DNA card
            const MealPlanDnaCard(),

            SizedBox(height: AppSpacing.sectionGap.h),

            // settings section
            SettingsSection(
              sectionLabel: 'SETTINGS',
              items: controller.settingsItems,
            ),

            SizedBox(height: AppSpacing.xl.h),

            // account section
            SettingsSection(
              sectionLabel: 'ACCOUNT',
              items: controller.accountItems,
            ),

            SizedBox(height: AppSpacing.xxxl.h),
          ],
        ),
      ),
    );
  }
}
