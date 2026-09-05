import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/common_widgets/app_text_field_widget.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';
import '../controllers/auth_controller.dart';
import 'widgets/mealist_logo_widget.dart';

// reset password screen — new password entry after clicking email link
class ResetPasswordScreen extends GetView<AuthController> {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController newPasswordCtrl = TextEditingController();
    final TextEditingController confirmPasswordCtrl = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.bg,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: Get.back,
        ),
        title: const MealistLogoWidget(),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
        child: Container(
          padding: EdgeInsets.all(AppSpacing.screenH.w),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(AppRadius.md),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: AppSpacing.xxl.h),
                const Text('Create new password', style: AppTextStyles.displayMedium),
                SizedBox(height: AppSpacing.xs.h),
                Text(
                  'Your new password must be different from previous passwords.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSpacing.xxl.h),
                AppTextFieldWidget(
                  label: 'New Password',
                  hint: 'Min. 8 characters',
                  controller: newPasswordCtrl,
                  obscureText: true,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.textTertiary,
                    size: AppSpacing.iconSm,
                  ),
                ),
                SizedBox(height: AppSpacing.md.h),
                AppTextFieldWidget(
                  label: 'Confirm New Password',
                  hint: 'Repeat new password',
                  controller: confirmPasswordCtrl,
                  obscureText: true,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.textTertiary,
                    size: AppSpacing.iconSm,
                  ),
                ),
                SizedBox(height: AppSpacing.xl.h),
                PrimaryButtonWidget(
                  label: 'Reset Password',
                  onTap: () => Get.offAllNamed(AppRoutes.signIn),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
