import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mealist_ai/modules/onboarding/screens/widgets/allergy_chip.dart';
import 'package:mealist_ai/modules/onboarding/screens/widgets/ingredient_input_row.dart';
import 'package:mealist_ai/modules/onboarding/screens/widgets/onboarding_bottom_bar.dart';
import 'package:mealist_ai/modules/onboarding/screens/widgets/search_field.dart';
import 'package:mealist_ai/modules/onboarding/screens/widgets/section_header.dart';
import 'package:mealist_ai/modules/onboarding/screens/widgets/top_nav.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../controllers/onboarding_controller.dart';

// Anything we should avoid? — step 4 of onboarding
// "I have no restrictions" toggle, allergies search + chips,
// dietary & religious section, specific ingredients freetext
class AllergiesScreen extends GetView<OnboardingController> {
  const AllergiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(
        children: [
          // ─ top nav ───────────────────────────────────────────────────────
          const TopNav(),

          // ─ scrollable content ────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSpacing.md.h),

                  // headline
                  Text(
                    'Anything we should\navoid?',
                    style: AppTextStyles.headlineLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'We use allergies and restrictions as hard exclusions when planning meals.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),

                  SizedBox(height: AppSpacing.lg.h),

                  // "I have no restrictions" toggle card
                  Obx(
                    () => GestureDetector(
                      onTap: () => controller.toggleNoRestrictions(
                        !controller.hasNoRestrictions.value,
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          border: Border.all(
                            color: controller.hasNoRestrictions.value
                                ? AppColors.primary
                                : AppColors.border,
                            width: controller.hasNoRestrictions.value ? 1.5 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            // green circle check icon
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: controller.hasNoRestrictions.value
                                    ? AppColors.primarySurface
                                    : AppColors.bg,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: controller.hasNoRestrictions.value
                                      ? AppColors.primary
                                      : AppColors.border,
                                ),
                              ),
                              child: Icon(
                                Icons.check,
                                color: controller.hasNoRestrictions.value
                                    ? AppColors.primary
                                    : AppColors.textTertiary,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'I have no restrictions',
                                    style: AppTextStyles.titleSmall.copyWith(
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    'Skip this step and eat everything',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // radio indicator
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: controller.hasNoRestrictions.value
                                      ? AppColors.primary
                                      : AppColors.border,
                                  width: 1.5,
                                ),
                                color: Colors.transparent,
                              ),
                              child: controller.hasNoRestrictions.value
                                  ? const Center(
                                      child: CircleAvatar(
                                        radius: 5,
                                        backgroundColor: AppColors.primary,
                                      ),
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // ── ALLERGIES section ────────────────────────────────────
                  const SectionHeader(
                    label: 'ALLERGIES',
                    iconColor: AppColors.error,
                    icon: Icons.medical_services_outlined,
                  ),
                  SizedBox(height: 10.h),

                  // search field for allergies
                  SearchField(
                    hint: 'Search allergies...',
                    onChanged: (String v) =>
                        controller.allergySearchQuery.value = v,
                  ),
                  SizedBox(height: 12.h),

                  // allergy chips
                  Obx(
                    () {
                      final String q =
                          controller.allergySearchQuery.value.toLowerCase();
                      final List<String> filtered = controller.allergyOptions
                          .where(
                            (String a) =>
                                q.isEmpty || a.toLowerCase().contains(q),
                          )
                          .toList();
                      return Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: filtered.map((String allergy) {
                          final bool isSelected =
                              controller.selectedAllergies.contains(allergy);
                          return AllergyChip(
                            label: allergy,
                            isSelected: isSelected,
                            onTap: () => controller.toggleAllergy(allergy),
                            onRemove: isSelected
                                ? () => controller.toggleAllergy(allergy)
                                : null,
                          );
                        }).toList(),
                      );
                    },
                  ),

                  SizedBox(height: 24.h),

                  // ── DIETARY & RELIGIOUS section ──────────────────────────
                  const SectionHeader(
                    label: 'DIETARY & RELIGIOUS',
                    iconColor: AppColors.primary,
                    icon: Icons.menu_book_outlined,
                  ),
                  SizedBox(height: 10.h),

                  SearchField(
                    hint: 'Search restrictions...',
                    onChanged: (String v) =>
                        controller.restrictionSearchQuery.value = v,
                  ),
                  SizedBox(height: 12.h),

                  Obx(
                    () {
                      final String q =
                          controller.restrictionSearchQuery.value.toLowerCase();
                      final List<String> filtered =
                          controller.dietaryRestrictionOptions
                              .where(
                                (String r) =>
                                    q.isEmpty || r.toLowerCase().contains(q),
                              )
                              .toList();
                      return Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: filtered.map((String r) {
                          final bool isSelected = controller
                              .selectedDietaryRestrictions
                              .contains(r);
                          return AllergyChip(
                            label: r,
                            isSelected: isSelected,
                            onTap: () => controller.toggleDietaryRestriction(r),
                            onRemove: isSelected
                                ? () => controller.toggleDietaryRestriction(r)
                                : null,
                          );
                        }).toList(),
                      );
                    },
                  ),

                  SizedBox(height: 24.h),

                  // ── SPECIFIC INGREDIENTS section ─────────────────────────
                  const SectionHeader(
                    label: 'SPECIFIC INGREDIENTS',
                    iconColor: AppColors.accent,
                    icon: Icons.eco_outlined,
                  ),
                  SizedBox(height: 10.h),

                  // text input + add button
                  Obx(
                    () => IngredientInputRow(
                      value: controller.specificIngredientInput.value,
                      onChanged: (String v) =>
                          controller.specificIngredientInput.value = v,
                      onAdd: () => controller.addSpecificIngredient(
                        controller.specificIngredientInput.value,
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // added specific ingredients
                  Obx(
                    () => controller.specificIngredients.isEmpty
                        ? const SizedBox.shrink()
                        : Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: controller.specificIngredients
                                .map((String ing) {
                              return AllergyChip(
                                label: ing,
                                isSelected: true,
                                onTap: () {},
                                onRemove: () =>
                                    controller.removeSpecificIngredient(ing),
                              );
                            }).toList(),
                          ),
                  ),

                  SizedBox(height: AppSpacing.xxxl.h),
                ],
              ),
            ),
          ),

          // ─ bottom action bar ─────────────────────────────────────────────
          OnboardingBottomBar(
            currentStep: 4,
            totalSteps: 5,
            onContinue: controller.goToCookingHousehold,
          ),
        ],
      ),
    );
  }
}
