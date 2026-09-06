// meal plan dna summary card
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../routes/app_routes.dart';
import '../../../../shared/common_widgets/primary_button_widget.dart';
import 'dna_row.dart';

class MealPlanDnaCard extends StatelessWidget {
  const MealPlanDnaCard({super.key});

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
          const DnaRow(label: 'Primary Goal', value: 'Lose weight'),
          const DnaRow(
            label: 'Nutrition Base',
            value: '1,850 kcal · 130g protein',
          ),
          const DnaRow(label: 'Dietary Style', value: 'High Protein'),
          DnaRow(
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
          PrimaryButtonWidget(
            label: 'View Progress',
            onTap: () => Get.toNamed(AppRoutes.progressInsights),
          ),
        ],
      ),
    );
  }
}