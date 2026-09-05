import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mealist_ai/core/constants/app_radius.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../gen/assets.gen.dart';
import '../../../shared/common_widgets/app_text_field_widget.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';
import '../controllers/auth_controller.dart';
import 'widgets/mealist_logo_widget.dart';

// forgot password screen — email input to trigger reset link
class ForgotPasswordScreen extends GetView<AuthController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailCtrl = TextEditingController();

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
                SvgPicture.asset(Assets.images.retry),
                SizedBox(height: AppSpacing.sm.h),
                const Text('Reset your password',
                    style: AppTextStyles.displayMedium),
                SizedBox(height: AppSpacing.xs.h),
                Text(
                  "Enter the email address associated with your account and we'll send you a link to reset yourpassword.",
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSpacing.xxl.h),
                AppTextFieldWidget(
                  label: 'Email address',
                  hint: 'name@example.com',
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(
                    Icons.mail_outline,
                    color: AppColors.textTertiary,
                    size: AppSpacing.iconSm,
                  ),
                ),
                SizedBox(height: AppSpacing.xl.h),
                Obx(
                  () => PrimaryButtonWidget(
                    label: 'Send Reset Link',
                    isLoading: controller.isForgotLoading.value,
                    onTap: () => controller.sendResetEmail(emailCtrl.text),
                  ),
                ),
                SizedBox(height: AppSpacing.xl.h),
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Return to Sign In',
                      style: TextStyle(
                        color: AppColors.primary,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
