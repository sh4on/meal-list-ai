import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../controllers/recipe_creator_controller.dart';

// instructions review card widget
// displays numbered preparation steps inside a clean structured card container
class ReviewInstructionsCard extends StatelessWidget {
  final RecipeCreatorController ctrl;

  const ReviewInstructionsCard({
    super.key,
    required this.ctrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // section title
        Text(
          'Instructions',
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppSpacing.sm.h),

        // card containing the numbered preparation sequence
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.cardPadding),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.border),
          ),
          child: Obx(
            () => ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ctrl.instructions.length,
              separatorBuilder: (final context, final index) =>
                  SizedBox(height: 10.h),
              itemBuilder: (final context, final index) {
                final String stepText = ctrl.instructions[index];

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // step index number prefix
                    Text(
                      '${index + 1}. ',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                        height: 1.45,
                      ),
                    ),

                    // step description text
                    Expanded(
                      child: Text(
                        stepText,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
