import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';

// info card explaining the AI smart parsing feature
// uses the accent surface background to visually differentiate it
class AiSmartParsingCard extends StatelessWidget {
  const AiSmartParsingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.accentSurface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // sparkle icon representing AI capability
          const Icon(
            Icons.auto_awesome,
            color: AppColors.accent,
            size: 20,
          ),
          SizedBox(width: AppSpacing.sm.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AI Smart Parsing',
                  style: AppTextStyles.titleSmall,
                ),
                SizedBox(height: 4.h),
                const Text(
                  "We'll automatically clean up ads, skip the lengthy blog story, and extract exactly what you need to cook.",
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
