import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../shared/common_widgets/app_text_field_widget.dart';
import '../../../controllers/recipe_creator_controller.dart';

// step 1 — basics: photo upload, recipe name, description, and cuisine dropdown
class StepBasicsContent extends StatelessWidget {
  final RecipeCreatorController ctrl;

  const StepBasicsContent({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSpacing.lg.h),

        // recipe photo section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Recipe Photo', style: AppTextStyles.titleMedium),
            Text(
              'Optional',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.xs.h),

        // dashed photo upload box
        Container(
          width: double.infinity,
          height: 140.h,
          decoration: BoxDecoration(
            color: AppColors.cardBgSecondary,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: AppColors.border,
              style: BorderStyle.solid,
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_a_photo_outlined,
                color: AppColors.textTertiary,
                size: 32,
              ),
              SizedBox(height: AppSpacing.xs.h),
              Text(
                'Tap to add a high-quality photo',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: AppSpacing.lg.h),

        // recipe name — required field
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text('Recipe Name', style: AppTextStyles.titleMedium),
                Text(
                  ' *',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: AppSpacing.xs.h),
        AppTextFieldWidget(
          label: '',
          hint: 'e.g. Sourdough Olive Bread',
          controller: ctrl.titleController,
        ),

        SizedBox(height: AppSpacing.md.h),

        // description — optional
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Description', style: AppTextStyles.titleMedium),
            Text(
              'Optional',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.xs.h),
        AppTextFieldWidget(
          label: '',
          hint: 'Share the story behind this recipe, flavor profile, or quick tips...',
          controller: ctrl.descController,
        ),

        SizedBox(height: AppSpacing.md.h),

        // cuisine dropdown — optional
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Cuisine', style: AppTextStyles.titleMedium),
            Text(
              'Optional',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.xs.h),

        Obx(
          () => Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md.w,
              vertical: 4.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.border),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: ctrl.selectedCuisine.value.isEmpty
                    ? null
                    : ctrl.selectedCuisine.value,
                hint: const Text(
                  'Select cuisine type',
                  style: AppTextStyles.inputHint,
                ),
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.textSecondary,
                ),
                items: RecipeCreatorController.cuisineTypes
                    .map(
                      (final String c) => DropdownMenuItem<String>(
                        value: c,
                        child: Text(c, style: AppTextStyles.inputText),
                      ),
                    )
                    .toList(),
                onChanged: (final String? val) {
                  if (val != null) ctrl.selectedCuisine.value = val;
                },
              ),
            ),
          ),
        ),

        SizedBox(height: AppSpacing.xxl.h),
      ],
    );
  }
}
