import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../gen/assets.gen.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/common_widgets/app_text_field_widget.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';
import '../../../shared/common_widgets/outline_button_widget.dart';
import '../controllers/auth_controller.dart';
import 'widgets/mealist_logo_widget.dart';
import 'widgets/sso_divider_widget.dart';

// register screen
class RegisterScreen extends GetView<AuthController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController firstNameCtrl = TextEditingController();
    final TextEditingController lastNameCtrl = TextEditingController();
    final TextEditingController emailCtrl = TextEditingController();
    final TextEditingController passwordCtrl = TextEditingController();
    final TextEditingController confirmPasswordCtrl = TextEditingController();

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

              const Text(
                'Create your account',
                style: AppTextStyles.displayMedium,
              ),
              SizedBox(height: AppSpacing.xs.h),
              Text(
                'Join the curated culinary experience.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),

              SizedBox(height: AppSpacing.xxl.h),

              // first name
              AppTextFieldWidget(
                label: 'First Name',
                hint: 'John',
                controller: firstNameCtrl,
                prefixIcon: const Icon(
                  Icons.person_outline,
                  color: AppColors.textTertiary,
                  size: AppSpacing.iconSm,
                ),
              ),

              SizedBox(height: AppSpacing.md.h),

              // last name
              AppTextFieldWidget(
                label: 'Last Name',
                hint: 'Doe',
                controller: lastNameCtrl,
                prefixIcon: const Icon(
                  Icons.person_outline,
                  color: AppColors.textTertiary,
                  size: AppSpacing.iconSm,
                ),
              ),

              SizedBox(height: AppSpacing.md.h),

              // email address
              AppTextFieldWidget(
                label: 'Email Address',
                hint: 'you@example.com',
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(
                  Icons.mail_outline,
                  color: AppColors.textTertiary,
                  size: AppSpacing.iconSm,
                ),
              ),

              SizedBox(height: AppSpacing.md.h),

              // password
              Obx(
                () => AppTextFieldWidget(
                  label: 'Password',
                  hint: 'Min. 8 characters',
                  controller: passwordCtrl,
                  obscureText: !controller.showRegisterPassword.value,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.textTertiary,
                    size: AppSpacing.iconSm,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.showRegisterPassword.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textTertiary,
                      size: AppSpacing.iconSm,
                    ),
                    onPressed: controller.toggleRegisterPasswordVisibility,
                  ),
                ),
              ),

              SizedBox(height: AppSpacing.md.h),

              // confirm password
              Obx(
                () => AppTextFieldWidget(
                  label: 'Confirm Password',
                  hint: 'Repeat password',
                  controller: confirmPasswordCtrl,
                  obscureText: !controller.showRegisterConfirmPassword.value,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.textTertiary,
                    size: AppSpacing.iconSm,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.showRegisterConfirmPassword.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textTertiary,
                      size: AppSpacing.iconSm,
                    ),
                    onPressed:
                        controller.toggleRegisterConfirmPasswordVisibility,
                  ),
                ),
              ),

              SizedBox(height: AppSpacing.xl.h),

              // create account cta
              Obx(
                () => PrimaryButtonWidget(
                  label: 'Create account',
                  isLoading: controller.isRegisterLoading.value,
                  onTap: () {
                    if (formKey.currentState?.validate() ?? false) {
                      controller.register(
                        firstName: firstNameCtrl.text,
                        lastName: lastNameCtrl.text,
                        email: emailCtrl.text,
                        password: passwordCtrl.text,
                      );
                    }
                  },
                ),
              ),

              SizedBox(height: AppSpacing.xl.h),

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

              // sign in link
              Center(
                child: GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.signIn),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already have an account? ',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        TextSpan(
                          text: 'Sign In',
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

              SizedBox(height: AppSpacing.md.h),

              // terms disclaimer
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'By creating an account, you agree to our ',
                        style: AppTextStyles.bodySmall,
                      ),
                      TextSpan(
                        text: 'Terms of Service',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primary,
                        ),
                      ),
                      const TextSpan(
                        text: ' and ',
                        style: AppTextStyles.bodySmall,
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primary,
                        ),
                      ),
                      const TextSpan(
                        text: '.',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: kBottomNavigationBarHeight),
            ],
          ),
        ),
      ),
    );
  }
}
