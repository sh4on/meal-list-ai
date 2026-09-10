import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../routes/app_routes.dart';
import 'add_to_meal_plan_sheet.dart';

// fixed 3-button bottom bar matching the recipe details figma design:
// full-width "+ Add to Meal Plan" on top, followed by "Ask Mealist" and "Start Cooking" side by side
class RecipeDetailsBottomBar extends StatelessWidget {
  final String recipeName;
  final String recipeTime;
  final String recipeImage;

  const RecipeDetailsBottomBar({
    super.key,
    required this.recipeName,
    required this.recipeTime,
    required this.recipeImage,
  });

  @override
  Widget build(BuildContext context) {
    final double bottomPadding =
        MediaQuery.of(context).padding.bottom > 0
            ? MediaQuery.of(context).padding.bottom
            : AppSpacing.md.h;

    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenH.w,
        AppSpacing.sm.h,
        AppSpacing.screenH.w,
        bottomPadding,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // full-width "+ Add to Meal Plan" button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton.icon(
              onPressed: () => AddToMealPlanSheet.show(
                context,
                recipeName: recipeName,
              ),
              icon: const Icon(
                Icons.add,
                color: AppColors.white,
                size: 20,
              ),
              label: const Text(
                'Add to Meal Plan',
                style: AppTextStyles.button,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
            ),
          ),

          SizedBox(height: AppSpacing.sm.h),

          // row: outlined Ask Mealist | mint-tinted Start Cooking
          Row(
            children: [
              // ask mealist outlined button
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: OutlinedButton.icon(
                    onPressed: () => Get.toNamed(
                      AppRoutes.askMealist,
                      arguments: {
                        'recipe': recipeName,
                        'context': 'recipe_details',
                      },
                    ),
                    icon: const Icon(
                      Icons.auto_awesome,
                      color: AppColors.primary,
                      size: 18,
                    ),
                    label: Text(
                      'Ask Mealist',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      backgroundColor: AppColors.white,
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: AppSpacing.sm.w),

              // start cooking button with light mint surface
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: ElevatedButton.icon(
                    onPressed: () => Get.toNamed(
                      AppRoutes.cookMode,
                      arguments: {
                        'recipe': recipeName,
                        'time': recipeTime,
                        'image': recipeImage,
                      },
                    ),
                    icon: const Icon(
                      Icons.play_arrow_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    label: Text(
                      'Start Cooking',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC3E8D8),
                      foregroundColor: AppColors.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
