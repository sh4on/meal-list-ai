// remove confirmation bottom sheet
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';

class RemoveConfirmationSheet extends StatelessWidget {
  final String itemName;
  final VoidCallback onConfirm;

  const RemoveConfirmationSheet({super.key,
    required this.itemName,
    required this.onConfirm,
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.xl),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenH.w,
        AppSpacing.lg.h,
        AppSpacing.screenH.w,
        AppSpacing.xxxl.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // drag handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
          ),

          // trash icon
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: AppColors.errorSurface,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.delete_outline_rounded,
              color: AppColors.error,
              size: 26,
            ),
          ),

          SizedBox(height: AppSpacing.md.h),

          const Text(
            'Remove this item?',
            style: AppTextStyles.headlineSmall,
          ),

          SizedBox(height: AppSpacing.xs.h),

          Text(
            'Are you sure you want to remove $itemName\nfrom your pantry?',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),

          SizedBox(height: AppSpacing.xl.h),

          // remove button
          SizedBox(
            width: double.infinity,
            height: AppSpacing.buttonHeight,
            child: ElevatedButton(
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
              child: const Text(
                'Remove Item',
                style: AppTextStyles.button,
              ),
            ),
          ),

          SizedBox(height: AppSpacing.md.h),

          // cancel button
          SizedBox(
            width: double.infinity,
            height: AppSpacing.buttonHeight,
            child: TextButton(
              onPressed: Get.back,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
              ),
              child: const Text(
                'Cancel',
                style: AppTextStyles.buttonSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}