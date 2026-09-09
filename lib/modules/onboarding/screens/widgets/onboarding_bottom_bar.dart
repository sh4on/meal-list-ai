import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/common_widgets/primary_button_widget.dart';
import 'onboarding_progress_widget.dart';

class OnboardingBottomBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback onContinue;

  const OnboardingBottomBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenH.w,
        AppSpacing.md.h,
        AppSpacing.screenH.w,
        AppSpacing.xl.h,
      ),
      decoration: const BoxDecoration(
        color: AppColors.bg,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OnboardingProgressWidget(
            currentStep: currentStep,
            totalSteps: totalSteps,
          ),
          SizedBox(height: AppSpacing.md.h),
          PrimaryButtonWidget(label: 'Continue', onTap: onContinue),
        ],
      ),
    );
  }
}
