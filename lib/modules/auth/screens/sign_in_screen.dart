import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../gen/assets.gen.dart';
import '../../../shared/common_widgets/app_text_field_widget.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';
import '../../../shared/common_widgets/outline_button_widget.dart';
import '../controllers/auth_controller.dart';
import 'widgets/mealist_logo_widget.dart';
import 'widgets/sso_divider_widget.dart';

// sign in screen
class SignInScreen extends GetView<AuthController> {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController emailCtrl = TextEditingController();
    final TextEditingController passwordCtrl = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: Get.back,
        ),
        title: const MealistLogoWidget(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppSpacing.xxl.h),

              // screen headline
              const Text('Welcome back', style: AppTextStyles.displayMedium),
              SizedBox(height: AppSpacing.xs.h),
              Text(
                'Sign in to your Mealist account to continue your meal planning journey.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: AppSpacing.xxl.h),

              // email field
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

              SizedBox(height: AppSpacing.md.h),

              // password field with toggle visibility
              Obx(
                () => AppTextFieldWidget(
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: passwordCtrl,
                  obscureText: !controller.showSignInPassword.value,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.textTertiary,
                    size: AppSpacing.iconSm,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.showSignInPassword.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textTertiary,
                      size: AppSpacing.iconSm,
                    ),
                    onPressed: controller.toggleSignInPasswordVisibility,
                  ),
                ),
              ),

              // forgot password link aligned right
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: controller.goToForgotPassword,
                  child: Text(
                    'Forgot password?',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),

              SizedBox(height: AppSpacing.md.h),

              // primary sign in button
              Obx(
                () => PrimaryButtonWidget(
                  label: 'Sign In',
                  isLoading: controller.isSignInLoading.value,
                  onTap: () {
                    if (formKey.currentState?.validate() ?? false) {
                      controller.signIn(
                        email: emailCtrl.text,
                        password: passwordCtrl.text,
                      );
                    }
                  },
                ),
              ),

              SizedBox(height: AppSpacing.xl.h),

              // divider with OR label
              const SsoDividerWidget(),

              SizedBox(height: AppSpacing.xl.h),

              // apple sso
              OutlineButtonWidget(
                label: 'Continue with Apple',
                leadingIcon: SvgPicture.asset(Assets.images.appleLogo),
                onTap: () {},
              ),

              SizedBox(height: AppSpacing.xs.h),

              // google sso
              OutlineButtonWidget(
                label: 'Continue with Google',
                leadingIcon: SvgPicture.asset(Assets.images.gmailLogo),
                onTap: () {},
              ),

              SizedBox(height: AppSpacing.xl.h),

              // create account link
              Center(
                child: GestureDetector(
                  onTap: controller.goToRegister,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account? ",
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        TextSpan(
                          text: 'Create an account',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: AppSpacing.xl.h),
            ],
          ),
        ),
      ),
    );
  }
}