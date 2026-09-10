import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../controllers/recipe_creator_controller.dart';

// step 3 — preparation steps with drag handles, editable text areas, and an AI draft button
class StepInstructionsContent extends StatelessWidget {
  final RecipeCreatorController ctrl;

  const StepInstructionsContent({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSpacing.lg.h),

        const Text('Preparation Steps', style: AppTextStyles.headlineSmall),

        SizedBox(height: AppSpacing.md.h),

        // step cards list
        Obx(
          () => Column(
            children: ctrl.instructions.asMap().entries.map((final entry) {
              return _StepCard(
                index: entry.key,
                text: entry.value,
                onChanged: (final String val) =>
                    ctrl.updateInstruction(entry.key, val),
                onRemove: () => ctrl.removeInstruction(entry.key),
              );
            }).toList(),
          ),
        ),

        SizedBox(height: AppSpacing.sm.h),

        // dashed add step button
        GestureDetector(
          onTap: ctrl.addInstruction,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: AppSpacing.md.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: AppColors.border,
                style: BorderStyle.solid,
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: AppColors.textSecondary, size: 18),
                SizedBox(width: 6),
                Text('Add Step', style: AppTextStyles.labelMedium),
              ],
            ),
          ),
        ),

        SizedBox(height: AppSpacing.lg.h),

        // AI draft instructions card
        Container(
          padding: const EdgeInsets.all(AppSpacing.cardPadding),
          decoration: BoxDecoration(
            color: AppColors.accentSurface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: AppColors.accent.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.auto_awesome,
                    color: AppColors.accent,
                    size: 20,
                  ),
                  SizedBox(width: AppSpacing.xs.w),
                  const Expanded(
                    child: Text(
                      'Generate steps from ingredients?',
                      style: AppTextStyles.titleSmall,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.xs.h),
              const Text(
                'Mealist can analyze your ingredient list and suggest a logical preparation sequence to save you time.',
                style: AppTextStyles.bodySmall,
              ),
              SizedBox(height: AppSpacing.sm.h),
              // orange "Draft Instructions" button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.md.w,
                    vertical: AppSpacing.xs.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                ),
                child: Text(
                  'Draft Instructions',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: AppSpacing.xxl.h),
      ],
    );
  }
}

// single draggable step card with a numbered label and editable text area
class _StepCard extends StatelessWidget {
  final int index;
  final String text;
  final ValueChanged<String> onChanged;
  final VoidCallback onRemove;

  const _StepCard({
    required this.index,
    required this.text,
    required this.onChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.sm.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // step header: drag handle + step label
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.sm.w,
              AppSpacing.xs.h,
              AppSpacing.sm.w,
              0,
            ),
            child: Row(
              children: [
                // drag handle dots — decorative, matching Figma
                Column(
                  children: [
                    Row(
                      children: List.generate(
                        2,
                        (_) => Padding(
                          padding: const EdgeInsets.only(right: 2),
                          child: Column(
                            children: List.generate(
                              3,
                              (__) => Container(
                                width: 3.w,
                                height: 3.h,
                                margin: const EdgeInsets.only(bottom: 2),
                                decoration: const BoxDecoration(
                                  color: AppColors.border,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: AppSpacing.xs.w),
                Text(
                  'STEP ${index + 1}',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // editable instruction text
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.cardPadding.w,
              AppSpacing.xs.h,
              AppSpacing.cardPadding.w,
              AppSpacing.sm.h,
            ),
            child: TextFormField(
              initialValue: text,
              onChanged: onChanged,
              maxLines: null,
              style: AppTextStyles.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Describe the next step in the recipe...',
                hintStyle: AppTextStyles.inputHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
                contentPadding: EdgeInsets.all(AppSpacing.sm.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
