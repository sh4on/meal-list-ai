import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../controllers/recipe_creator_controller.dart';
import 'review_allergen_banner.dart';
import 'review_ingredients_list.dart';
import 'review_instructions_card.dart';
import 'review_nutrition_grid.dart';
import 'review_recipe_hero_image.dart';

// step 5 — review: complete preview of imported / authored recipe before saving
// coordinates the hero image, title, allergen notice, ingredients, instructions, and nutrition
class StepReviewContent extends StatelessWidget {
  final RecipeCreatorController ctrl;

  const StepReviewContent({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSpacing.sm.h),

        // recipe hero image
        Obx(
          () => ReviewRecipeHeroImage(
            imageUrl: ctrl.recipeImageUrl.value,
          ),
        ),
        SizedBox(height: AppSpacing.md.h),

        // recipe title matching the design
        // non-observable text controllers are evaluated directly without Obx to avoid GetX improper use exception
        Text(
          ctrl.titleController.text.isEmpty
              ? 'Mediterranean Lentil & Chicken Bowl'
              : ctrl.titleController.text,
          style: AppTextStyles.headlineMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppSpacing.xxs.h),

        // recipe short description
        Text(
          ctrl.descController.text.isEmpty
              ? 'A hearty, protein-packed bowl perfect for meal prep.'
              : ctrl.descController.text,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            height: 1.4,
          ),
        ),
        SizedBox(height: AppSpacing.md.h),

        // allergen verification notice
        Obx(
          () => ctrl.hasAllergenWarning.value
              ? Column(
                  children: [
                    const ReviewAllergenBanner(),
                    SizedBox(height: AppSpacing.md.h),
                  ],
                )
              : const SizedBox.shrink(),
        ),

        // structured ingredients list with warnings and add action
        ReviewIngredientsList(ctrl: ctrl),
        SizedBox(height: AppSpacing.md.h),

        // instructions numbered card
        ReviewInstructionsCard(ctrl: ctrl),
        SizedBox(height: AppSpacing.md.h),

        // 2x2 macro grid with ai estimated badge
        ReviewNutritionGrid(ctrl: ctrl),
        SizedBox(height: AppSpacing.xxl.h),
      ],
    );
  }
}
