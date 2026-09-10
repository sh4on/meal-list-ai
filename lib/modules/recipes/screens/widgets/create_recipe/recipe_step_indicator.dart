import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';

// 5-node step indicator matching the Figma wizard design
// completed steps show a checkmark; active step is filled green; future steps are outlined grey
class RecipeStepIndicator extends StatelessWidget {
  final int currentStep;

  const RecipeStepIndicator({super.key, required this.currentStep});

  static const List<String> _labels = [
    'BASIC',
    'INGREDIENTS',
    'STEPS',
    'NUTRITION',
    'REVIEW',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_labels.length * 2 - 1, (final int i) {
        // odd indices are the connecting lines between nodes
        if (i.isOdd) {
          final int stepIndex = i ~/ 2;
          final bool completed = stepIndex < currentStep;
          return Expanded(
            child: Container(
              height: 2.h,
              color: completed ? AppColors.primary : AppColors.border,
            ),
          );
        }

        final int stepIndex = i ~/ 2;
        final bool completed = stepIndex < currentStep;
        final bool active = stepIndex == currentStep;

        return Column(
          children: [
            // step node circle
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: completed || active ? AppColors.primary : AppColors.white,
                border: Border.all(
                  color: completed || active
                      ? AppColors.primary
                      : AppColors.border,
                  width: 1.5,
                ),
              ),
              child: Center(
                child: completed
                    ? const Icon(Icons.check, color: AppColors.white, size: 16)
                    : Text(
                        '${stepIndex + 1}',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: active
                              ? AppColors.white
                              : AppColors.textTertiary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 4.h),
            // label below the node
            Text(
              _labels[stepIndex],
              style: AppTextStyles.labelSmall.copyWith(
                color: active ? AppColors.primary : AppColors.textTertiary,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ],
        );
      }),
    );
  }
}
