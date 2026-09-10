import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/common_widgets/outline_button_widget.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';
import '../controllers/recipe_creator_controller.dart';
import 'widgets/create_recipe/recipe_step_indicator.dart';
import 'widgets/create_recipe/step_basics_content.dart';
import 'widgets/create_recipe/step_ingredients_content.dart';
import 'widgets/create_recipe/step_instructions_content.dart';
import 'widgets/create_recipe/step_nutrition_content.dart';
import 'widgets/create_recipe/step_review_content.dart';

// multi-step recipe creator wizard
// dynamically adapts between authoring wizard steps and the final review recipe screen
class CreateRecipeWizardScreen extends GetView<RecipeCreatorController> {
  const CreateRecipeWizardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () {
            // go to previous step or exit wizard if on first step
            if (controller.wizardStep.value > 0) {
              controller.prevWizardStep();
            } else {
              Get.back();
            }
          },
        ),
        // title switches to 'Review Recipe' when in step 4 matching figma
        title: Obx(
          () => Text(
            controller.wizardStep.value == 4
                ? 'Review Recipe'
                : 'Create Recipe',
            style: AppTextStyles.headlineSmall.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        centerTitle: false,
        actions: [
          Obx(
            () => controller.wizardStep.value == 4
                // displays imported tag pill when reviewing an imported recipe
                ? Padding(
                    padding: EdgeInsets.only(right: AppSpacing.screenH.w),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBEAE6),
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Text(
                          'Imported',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                // save draft text action in app bar during creation
                : TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'Save Draft',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
          ),
        ],
      ),
      body: Column(
        children: [
          // 5-node circular step indicator shown on creation steps (hidden in review mode)
          Obx(
            () => controller.wizardStep.value < 4
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenH.w,
                      vertical: AppSpacing.md.h,
                    ),
                    child: RecipeStepIndicator(
                      currentStep: controller.wizardStep.value,
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          // scrollable per-step content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
              child: Obx(() {
                switch (controller.wizardStep.value) {
                  case 0:
                    return StepBasicsContent(ctrl: controller);
                  case 1:
                    return StepIngredientsContent(ctrl: controller);
                  case 2:
                    return StepInstructionsContent(ctrl: controller);
                  case 3:
                    return StepNutritionContent(ctrl: controller);
                  case 4:
                  default:
                    return StepReviewContent(ctrl: controller);
                }
              }),
            ),
          ),

          // fixed bottom action bar: dual Discard/Save buttons on review, Continue on wizard
          Container(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.screenH.w,
              AppSpacing.sm.h,
              AppSpacing.screenH.w,
              AppSpacing.xl.h,
            ),
            decoration: const BoxDecoration(
              color: AppColors.bg,
              border: Border(top: BorderSide(color: AppColors.divider)),
            ),
            child: Obx(
              () => controller.wizardStep.value == 4
                  ? Row(
                      children: [
                        // discard action button
                        Expanded(
                          child: OutlineButtonWidget(
                            label: 'Discard',
                            textColor: AppColors.primary,
                            onTap: () => Get.back(),
                          ),
                        ),
                        SizedBox(width: AppSpacing.sm.w),

                        // save recipe action button with leading icon
                        Expanded(
                          child: PrimaryButtonWidget(
                            label: 'Save Recipe',
                            leadingIcon: const Icon(
                              Icons.save_outlined,
                              color: AppColors.white,
                              size: 20,
                            ),
                            onTap: controller.saveRecipe,
                          ),
                        ),
                      ],
                    )
                  : PrimaryButtonWidget(
                      label: 'Continue  →',
                      onTap: controller.nextWizardStep,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
