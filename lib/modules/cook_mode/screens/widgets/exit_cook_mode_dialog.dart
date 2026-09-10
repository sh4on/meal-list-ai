import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/common_widgets/outline_button_widget.dart';
import '../../../../shared/common_widgets/primary_button_widget.dart';

// leave cook mode confirmation modal dialog
// presents soft red exit icon with save progress reassurance matching the figma modal container
class ExitCookModeDialog extends StatelessWidget {
  const ExitCookModeDialog({super.key});

  static Future<bool?> show(final BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (final BuildContext ctx) => const ExitCookModeDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // top circular icon with soft red background
            Container(
              width: 52,
              height: 52,
              decoration: const BoxDecoration(
                color: Color(0xFFFDECEC),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.logout_rounded,
                color: AppColors.error,
                size: 24,
              ),
            ),
            SizedBox(height: AppSpacing.md.h),

            // dialog headline
            Text(
              'Leave Cook Mode?',
              style: AppTextStyles.headlineSmall.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.xs.h),

            // progress reassurance text
            Text(
              'Your cooking progress will be saved. You can continue later.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.xl.h),

            // primary continue action button
            PrimaryButtonWidget(
              label: 'Continue Cooking',
              onTap: () => Get.back(result: false),
            ),
            SizedBox(height: AppSpacing.xs.h),

            // secondary exit action button
            OutlineButtonWidget(
              label: 'Exit',
              textColor: AppColors.primary,
              onTap: () => Get.back(result: true),
            ),
          ],
        ),
      ),
    );
  }
}
