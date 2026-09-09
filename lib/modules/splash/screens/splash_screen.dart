import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../controllers/splash_controller.dart';

// splash screen — logo centered on warm background
class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // centered logo and loading indicator
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // mealist logo — fork/knife icon + wordmark
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Mealist',
                          style: AppTextStyles.logoMark,
                        ),
                        TextSpan(
                          text: '.ai',
                          style: AppTextStyles.logoMark.copyWith(
                            color: AppColors.accent,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  Text(
                    'Your meals. Your goals. One smart plan.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: AppSpacing.xxl),

                  // spinner indicates background initialization
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),

            // bottom retry hint — shown after a perceived delay in real app
            Positioned(
              bottom: AppSpacing.xl,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Taking a bit longer? ',
                    style: AppTextStyles.bodySmall,
                  ),
                  GestureDetector(
                    onTap: controller.onRetry,
                    child: Text(
                      'Retry',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textLink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
