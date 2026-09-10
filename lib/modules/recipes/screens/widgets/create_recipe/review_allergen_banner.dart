import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';

// allergen safety verification notice banner
// warns users to double-check ai-extracted ingredients before saving to allergy profiles
class ReviewAllergenBanner extends StatelessWidget {
  const ReviewAllergenBanner({super.key});

  @override
  Widget build(BuildContext context) {
    // accent surface with border ensures strong visual prominence for safety notices
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.accentSurface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          // subtle border emphasizes safety warning without harsh contrast
          color: AppColors.accent.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // prominent amber warning icon matching health and safety conventions
          const Icon(
            Icons.warning_amber_rounded,
            color: AppColors.accent,
            size: AppSpacing.iconLg,
          ),
          SizedBox(width: AppSpacing.sm.w),

          // textual explanation instructing user verification
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Not yet verified for allergens',
                  style: AppTextStyles.titleSmall.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: AppSpacing.xxs.h),
                Text(
                  'Please confirm the extracted ingredient list is complete and accurate before saving to your profile.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
