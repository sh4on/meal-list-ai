import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';

// outlined button — used for secondary actions like SSO login buttons
class OutlineButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Widget? leadingIcon;
  final Color? borderColor;
  final Color? textColor;

  const OutlineButtonWidget({
    super.key,
    required this.label,
    this.onTap,
    this.leadingIcon,
    this.borderColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.buttonHeight.h,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: textColor ?? AppColors.textPrimary,
          elevation: 0,
          side: BorderSide(color: borderColor ?? AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[
              leadingIcon!,
              SizedBox(width: AppSpacing.xs.w),
            ],
            Text(
              label,
              style: AppTextStyles.buttonSecondary.copyWith(
                color: textColor ?? AppColors.textPrimary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
