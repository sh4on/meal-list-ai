// settings group with label and list of tappable rows
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../routes/app_routes.dart';

class SettingsSection extends StatelessWidget {
  final String sectionLabel;
  final List<Map<String, String>> items;

  const SettingsSection({
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
                        case 'HOUSEHOLD':
                          Get.toNamed(AppRoutes.manageHousehold);
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
                        case 'APP SETTINGS':
                          Get.toNamed(AppRoutes.appSettings);
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
      'restaurant' => Icons.restaurant,
      'block' => Icons.remove_circle_outline,
      'people' => Icons.people_outline,
      'person' => Icons.person_outline,
      'star' => Icons.stars_outlined,
      'insights' => Icons.insights_outlined,
      'settings' => Icons.settings_outlined,
      _ => Icons.chevron_right,
    };
  }
}