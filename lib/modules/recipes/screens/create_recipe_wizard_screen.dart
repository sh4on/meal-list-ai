import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/common_widgets/app_text_field_widget.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';
import '../../../shared/common_widgets/selection_chip_widget.dart';
import '../controllers/recipe_creator_controller.dart';

// multi-step recipe creator wizard
// guides the user through Basics, Ingredients, Instructions, Nutrition, and Final Review
class CreateRecipeWizardScreen extends GetView<RecipeCreatorController> {
  const CreateRecipeWizardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> stepNames = [
      'Basics',
      'Ingredients',
      'Instructions',
      'Nutrition',
      'Review',
    ];

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () {
            if (controller.wizardStep.value > 0) {
              controller.prevWizardStep();
            } else {
              Get.back();
            }
          },
        ),
        title: Obx(
          () => Text(
            stepNames[controller.wizardStep.value],
            style: AppTextStyles.headlineSmall,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Obx(
            () => LinearProgressIndicator(
              value: (controller.wizardStep.value + 1) / stepNames.length,
              backgroundColor: AppColors.divider,
              color: AppColors.primary,
              minHeight: 4,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
              child: Obx(() {
                switch (controller.wizardStep.value) {
                  case 0:
                    return _StepBasics(controller: controller);
                  case 1:
                    return _StepIngredients(controller: controller);
                  case 2:
                    return _StepInstructions(controller: controller);
                  case 3:
                    return _StepNutrition(controller: controller);
                  case 4:
                  default:
                    return _StepReview(controller: controller);
                }
              }),
            ),
          ),

          // bottom continue action bar
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
              () => PrimaryButtonWidget(
                label: controller.wizardStep.value == 4
                    ? 'Save Recipe'
                    : 'Continue →',
                onTap: controller.nextWizardStep,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// step 1: basic information
class _StepBasics extends StatelessWidget {
  final RecipeCreatorController controller;
  const _StepBasics({required this.controller});

  @override
  Widget build(BuildContext context) {
    const List<String> categories = [
      'Breakfast',
      'Lunch',
      'Dinner',
      'Snack',
      'Dessert',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSpacing.md.h),
        const Text('Recipe Basics', style: AppTextStyles.headlineSmall),
        SizedBox(height: AppSpacing.xs.h),
        const Text(
          'Provide core details about your meal.',
          style: AppTextStyles.bodySmall,
        ),
        SizedBox(height: AppSpacing.lg.h),
        AppTextFieldWidget(
          label: 'Recipe Name',
          hint: 'e.g. Lemon Herb Roasted Chicken',
          controller: controller.titleController,
        ),
        SizedBox(height: AppSpacing.md.h),
        AppTextFieldWidget(
          label: 'Description',
          hint: 'A quick summary of flavors and texture...',
          controller: controller.descController,
        ),
        SizedBox(height: AppSpacing.md.h),
        const Text('Meal Category', style: AppTextStyles.inputLabel),
        SizedBox(height: AppSpacing.xs.h),
        Obx(
          () => Wrap(
            spacing: 8,
            children: categories.map((final String cat) {
              return SelectionChipWidget(
                label: cat,
                isSelected: controller.selectedCategory.value == cat,
                onTap: () => controller.selectedCategory.value = cat,
              );
            }).toList(),
          ),
        ),
        SizedBox(height: AppSpacing.md.h),
        Row(
          children: [
            Expanded(
              child: AppTextFieldWidget(
                label: 'Prep (mins)',
                hint: '15',
                controller: controller.prepTimeController,
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(width: AppSpacing.md.w),
            Expanded(
              child: AppTextFieldWidget(
                label: 'Cook (mins)',
                hint: '25',
                controller: controller.cookTimeController,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.xl.h),
      ],
    );
  }
}

// step 2: ingredients list
class _StepIngredients extends StatelessWidget {
  final RecipeCreatorController controller;
  const _StepIngredients({required this.controller});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameCtrl = TextEditingController();
    final TextEditingController qtyCtrl = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSpacing.md.h),
        const Text('Ingredients', style: AppTextStyles.headlineSmall),
        SizedBox(height: AppSpacing.xs.h),
        const Text(
          'Add items needed to prepare this meal.',
          style: AppTextStyles.bodySmall,
        ),
        SizedBox(height: AppSpacing.md.h),
        Obx(
          () => Column(
            children: controller.ingredients.asMap().entries.map((final entry) {
              final Map<String, String> item = entry.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item['name'] ?? '',
                        style: AppTextStyles.titleSmall,
                      ),
                    ),
                    Text(
                      item['qty'] ?? '',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        color: AppColors.error,
                        size: 18,
                      ),
                      onPressed: () => controller.removeIngredient(entry.key),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: AppSpacing.md.h),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: AppTextFieldWidget(
                label: 'New Ingredient',
                hint: 'e.g. Garlic',
                controller: nameCtrl,
              ),
            ),
            SizedBox(width: AppSpacing.sm.w),
            Expanded(
              child: AppTextFieldWidget(
                label: 'Qty',
                hint: '2 cloves',
                controller: qtyCtrl,
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.sm.h),
        OutlinedButton.icon(
          onPressed: () {
            controller.addIngredient(nameCtrl.text.trim(), qtyCtrl.text.trim());
            nameCtrl.clear();
            qtyCtrl.clear();
          },
          icon: const Icon(Icons.add, size: 16),
          label: const Text('Add Ingredient Line'),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primary),
            foregroundColor: AppColors.primary,
          ),
        ),
        SizedBox(height: AppSpacing.xl.h),
      ],
    );
  }
}

// step 3: instructions list
class _StepInstructions extends StatelessWidget {
  final RecipeCreatorController controller;
  const _StepInstructions({required this.controller});

  @override
  Widget build(BuildContext context) {
    final TextEditingController stepCtrl = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSpacing.md.h),
        const Text('Instructions', style: AppTextStyles.headlineSmall),
        SizedBox(height: AppSpacing.xs.h),
        const Text(
          'Step-by-step cooking directions.',
          style: AppTextStyles.bodySmall,
        ),
        SizedBox(height: AppSpacing.md.h),
        Obx(
          () => Column(
            children:
                controller.instructions.asMap().entries.map((final entry) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(AppSpacing.cardPadding),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        '${entry.key + 1}',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(entry.value, style: AppTextStyles.bodyMedium),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.textTertiary,
                        size: 16,
                      ),
                      onPressed: () => controller.removeInstruction(entry.key),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: AppSpacing.md.h),
        AppTextFieldWidget(
          label: 'Add Step Instruction',
          hint: 'Describe next preparation or cooking action...',
          controller: stepCtrl,
        ),
        SizedBox(height: AppSpacing.sm.h),
        OutlinedButton.icon(
          onPressed: () {
            controller.addInstruction(stepCtrl.text.trim());
            stepCtrl.clear();
          },
          icon: const Icon(Icons.add, size: 16),
          label: const Text('Add Step'),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primary),
            foregroundColor: AppColors.primary,
          ),
        ),
        SizedBox(height: AppSpacing.xl.h),
      ],
    );
  }
}

// step 4: nutrition information
class _StepNutrition extends StatelessWidget {
  final RecipeCreatorController controller;
  const _StepNutrition({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSpacing.md.h),
        const Text('Nutrition Facts', style: AppTextStyles.headlineSmall),
        SizedBox(height: AppSpacing.xs.h),
        const Text(
          'Approximate macro values per serving.',
          style: AppTextStyles.bodySmall,
        ),
        SizedBox(height: AppSpacing.lg.h),
        AppTextFieldWidget(
          label: 'Calories (kcal)',
          hint: '450',
          controller: controller.caloriesController,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: AppSpacing.md.h),
        Row(
          children: [
            Expanded(
              child: AppTextFieldWidget(
                label: 'Protein (g)',
                hint: '45',
                controller: controller.proteinController,
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(width: AppSpacing.md.w),
            Expanded(
              child: AppTextFieldWidget(
                label: 'Carbs (g)',
                hint: '25',
                controller: controller.carbsController,
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(width: AppSpacing.md.w),
            Expanded(
              child: AppTextFieldWidget(
                label: 'Fat (g)',
                hint: '15',
                controller: controller.fatController,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.xl.h),
      ],
    );
  }
}

// step 5: review summary
class _StepReview extends StatelessWidget {
  final RecipeCreatorController controller;
  const _StepReview({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSpacing.md.h),
        const Text('Review Recipe', style: AppTextStyles.headlineSmall),
        SizedBox(height: AppSpacing.xs.h),
        const Text(
          'Confirm recipe details before saving to your collection.',
          style: AppTextStyles.bodySmall,
        ),
        SizedBox(height: AppSpacing.lg.h),
        Container(
          padding: const EdgeInsets.all(AppSpacing.cardPadding),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.titleController.text.isEmpty
                    ? 'Untitled Recipe'
                    : controller.titleController.text,
                style: AppTextStyles.titleLarge,
              ),
              const SizedBox(height: 4),
              Text(
                controller.descController.text.isEmpty
                    ? 'No description provided'
                    : controller.descController.text,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    '${controller.prepTimeController.text}m prep',
                    style: AppTextStyles.labelMedium,
                  ),
                  const SizedBox(width: 8),
                  const Text('•', style: AppTextStyles.labelMedium),
                  const SizedBox(width: 8),
                  Text(
                    '${controller.cookTimeController.text}m cook',
                    style: AppTextStyles.labelMedium,
                  ),
                  const SizedBox(width: 8),
                  const Text('•', style: AppTextStyles.labelMedium),
                  const SizedBox(width: 8),
                  Text(
                    '${controller.caloriesController.text} kcal',
                    style: AppTextStyles.labelMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.xl.h),
      ],
    );
  }
}
