import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';

// numbered preparation instruction list matching the recipe details figma design
// each step shows a mint circular number badge on the left and step guidance on the right
class RecipeInstructionList extends StatelessWidget {
  const RecipeInstructionList({super.key});

  static const List<String> _steps = [
    'Pat the chicken breasts dry with a paper towel. Season generously with salt, pepper, and oregano on both sides.',
    'Heat olive oil in a large skillet over medium-high heat. Add the minced garlic and cook for 30 seconds until fragrant.',
    'Add the chicken to the skillet. Cook for 6–7 minutes per side, or until golden brown and cooked through.',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // section title
        Text(
          'Instructions',
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppSpacing.sm.h),

        // instruction step items
        ..._steps.asMap().entries.map((final entry) {
          return Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.md.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // mint circle with primary colored number
                Container(
                  width: 28.w,
                  height: 28.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE2EFEA),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${entry.key + 1}',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: AppSpacing.sm.w),

                // step guidance text
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Text(
                      entry.value,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        height: 1.45,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
