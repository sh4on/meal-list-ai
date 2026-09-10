import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';

// header widget for the Import from Link screen
// shows a centered orange link icon inside a cream circle, title, and description
class ImportLinkHeader extends StatelessWidget {
  const ImportLinkHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppSpacing.xxl.h),

        // orange link icon inside cream circle
        Center(
          child: Container(
            width: 72.w,
            height: 72.w,
            decoration: const BoxDecoration(
              color: AppColors.accentSurface,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.link_rounded,
              color: AppColors.accent,
              size: 32,
            ),
          ),
        ),

        SizedBox(height: AppSpacing.lg.h),

        const Text(
          'Extract Any Recipe',
          style: AppTextStyles.headlineMedium,
          textAlign: TextAlign.center,
        ),

        SizedBox(height: AppSpacing.xs.h),

        Text(
          'Paste a URL from your favorite food blog.\nMealist will extract the recipe, ingredients,\ninstructions and estimated nutrition.',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: AppSpacing.xxl.h),
      ],
    );
  }
}
