import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';

// green allergen verification banner shown when no allergens match
// compact single-line layout matching the figma recipe details screenshot
class RecipeAllergenBanner extends StatelessWidget {
  const RecipeAllergenBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.cardPadding.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        // soft mint surface indicates successful verification
        color: const Color(0xFFEBF5F0),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          // shield checkmark icon
          const Icon(
            Icons.verified_user_rounded,
            color: AppColors.primary,
            size: 18,
          ),
          SizedBox(width: AppSpacing.xs.w),

          // single line status text
          Text(
            'Allergen check: Nothing flagged',
            style: AppTextStyles.titleSmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
