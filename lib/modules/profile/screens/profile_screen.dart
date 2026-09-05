import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';
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
        backgroundColor: AppColors.bg,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Icon(Icons.restaurant, color: AppColors.textPrimary),
        ),
        title: const Text('Mealist.ai', style: AppTextStyles.logoMark),
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
            _MealPlanDnaCard(),

            SizedBox(height: AppSpacing.sectionGap.h),

            // settings section
            _SettingsSection(
              sectionLabel: 'SETTINGS',
              items: controller.settingsItems,
            ),

            SizedBox(height: AppSpacing.xl.h),

            // account section
            _SettingsSection(
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

// meal plan dna summary card
class _MealPlanDnaCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPaddingLg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header with sparkle icon
          const Row(
            children: [
              Icon(
                Icons.auto_awesome,
                color: AppColors.accent,
                size: AppSpacing.iconSm,
              ),
              SizedBox(width: AppSpacing.xs),
              Text('Your Meal Plan DNA', style: AppTextStyles.titleLarge),
            ],
          ),
          SizedBox(height: AppSpacing.md.h),

          // dna rows
          const _DnaRow(label: 'Primary Goal', value: 'Lose weight'),
          const _DnaRow(
            label: 'Nutrition Base',
            value: '1,850 kcal · 130g protein',
          ),
          const _DnaRow(label: 'Dietary Style', value: 'High Protein'),
          _DnaRow(
            label: 'Cuisine Preferences',
            customWidget: Wrap(
              spacing: AppSpacing.xs,
              children: ['Mediterranean', 'Turkish', 'Italian'].map((String c) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(c, style: AppTextStyles.labelMedium),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: AppSpacing.md.h),

          // view progress cta
          PrimaryButtonWidget(label: 'View Progress', onTap: () {}),
        ],
      ),
    );
  }
}

// individual DNA info row
class _DnaRow extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? customWidget;

  const _DnaRow({required this.label, this.value, this.customWidget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.inputLabel),
          const SizedBox(height: 2),
          if (value != null)
            Text(value!, style: AppTextStyles.bodyMedium)
          else
            customWidget ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}

// settings group with label and list of tappable rows
class _SettingsSection extends StatelessWidget {
  final String sectionLabel;
  final List<Map<String, String>> items;

  const _SettingsSection({
    required this.sectionLabel,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(sectionLabel, style: AppTextStyles.sectionHeader),
        SizedBox(height: AppSpacing.sm.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final Map<String, String> item = entry.value;
              final bool isLast = entry.key == items.length - 1;
              return Column(
                children: [
                  ListTile(
                    leading: Icon(
                      _iconForKey(item['icon'] ?? ''),
                      color: AppColors.textSecondary,
                      size: AppSpacing.iconMd,
                    ),
                    title: Text(
                      item['label'] ?? '',
                      style: AppTextStyles.titleSmall,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: AppColors.textTertiary,
                    ),
                    onTap: () {
                      switch (item['label']) {
                        case 'MY GOALS':
                          Get.toNamed(AppRoutes.myGoals);
                          break;
                        case 'NUTRITION TARGETS':
                          Get.toNamed(AppRoutes.nutritionTargets);
                          break;
                        case 'FOOD PREFERENCES':
                          Get.toNamed(AppRoutes.foodPreferences);
                          break;
                        case 'ALLERGIES & RESTRICTIONS':
                          Get.toNamed(AppRoutes.manageAllergies);
                          break;
                        case 'PERSONAL INFO':
                          Get.toNamed(AppRoutes.personalInfo);
                          break;
                        case 'PROGRESS & INSIGHTS':
                          Get.toNamed(AppRoutes.progressInsights);
                          break;
                        case 'SUBSCRIPTION':
                          Get.toNamed(AppRoutes.manageSubscription);
                          break;
                      }
                    },
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: 2,
                    ),
                  ),
                  if (!isLast)
                    const Divider(
                      height: 1,
                      indent: AppSpacing.md,
                      endIndent: AppSpacing.md,
                      color: AppColors.divider,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // map string keys to material icons for settings items
  IconData _iconForKey(final String key) {
    return switch (key) {
      'flag' => Icons.flag_outlined,
      'nutrition' => Icons.monitor_weight_outlined,
      'restaurant' => Icons.restaurant_menu_outlined,
      'block' => Icons.block_outlined,
      'person' => Icons.person_outline,
      'star' => Icons.star_outline,
      'insights' => Icons.insights_outlined,
      'settings' => Icons.settings_outlined,
      _ => Icons.chevron_right,
    };
  }
}
