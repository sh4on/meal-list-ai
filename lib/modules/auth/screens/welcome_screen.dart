import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mealist_ai/extension/build_context_extension.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../gen/assets.gen.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';
import 'widgets/mealist_logo_widget.dart';

// welcome screen — hero food image, tagline, get started + sign in
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const MealistLogoWidget(),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: AppSpacing.xs.h),

          // hero food photograph fills top half of screen
          Assets.images.getStartedImage.image(),

          // content below hero image
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.screenH.w,
              ),
              child: Column(
                children: [
                  SizedBox(height: AppSpacing.sm.h),

                  // main tagline
                  const Text(
                    'Your meals. Your goals.\nOne smart plan.',
                    style: AppTextStyles.headlineLarge,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: AppSpacing.md.h),

                  // supporting description
                  Text(
                    'Mealist creates personalized meal plans around your unique goals, '
                    'dietary preferences, pantry inventory, and household needs.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const Spacer(),

                  // get started primary cta
                  PrimaryButtonWidget(
                    label: 'Get Started',
                    onTap: () => Get.toNamed(AppRoutes.signIn),
                  ),

                  SizedBox(height: AppSpacing.md.h),

                  // already have account — sign in link
                  GestureDetector(
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

                  SizedBox(height: AppSpacing.xl.h),
                ],
              ),
            ),
          ),
        ],
      ).withHorizontalPadding(AppSpacing.md),
    );
  }
}