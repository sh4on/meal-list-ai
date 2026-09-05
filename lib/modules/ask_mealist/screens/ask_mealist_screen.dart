import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';
import '../controllers/ask_mealist_controller.dart';

// ask mealist adaptation screen
// empowers users to customize recipes using AI natural language instructions
class AskMealistScreen extends GetView<AskMealistController> {
  const AskMealistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: Get.back,
        ),
        title: const Text('Ask Mealist', style: AppTextStyles.headlineSmall),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSpacing.md.h),

            // header card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.cardPadding),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        color: AppColors.accent,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text('Ask Mealist', style: AppTextStyles.headlineSmall),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Adapting Mediterranean Chicken',
                    style: AppTextStyles.titleSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'A new version will be saved to your recipes.',
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.lg.h),

            // quick suggestions section
            const Text('QUICK SUGGESTIONS', style: AppTextStyles.sectionHeader),
            SizedBox(height: AppSpacing.sm.h),

            Obx(
              () => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: controller.quickSuggestions.map((final item) {
                  final String label = item['label'] as String;
                  final IconData icon = item['icon'] as IconData;
                  final bool isSelected =
                      controller.selectedSuggestion.value == label;

                  return GestureDetector(
                    onTap: () => controller.selectSuggestion(label),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primarySurface
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        border: Border.all(
                          color:
                              isSelected ? AppColors.primary : AppColors.border,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            icon,
                            size: 16,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            label,
                            style: AppTextStyles.labelMedium.copyWith(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textPrimary,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: AppSpacing.xl.h),

            // prompt input section
            const Text(
              'What would you like to change?',
              style: AppTextStyles.titleSmall,
            ),
            SizedBox(height: AppSpacing.xs.h),

            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: controller.promptController,
                    maxLines: 4,
                    style: AppTextStyles.inputText,
                    decoration: const InputDecoration(
                      hintText:
                          'e.g. Can we make this spicy and add more vegetables?',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(AppSpacing.cardPadding),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, bottom: 8),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: const Icon(
                          Icons.mic_outlined,
                          color: AppColors.textTertiary,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.xxl.h),

            // adapt recipe action button
            Obx(
              () => PrimaryButtonWidget(
                label: '✨ Adapt Recipe →',
                isLoading: controller.isLoading.value,
                onTap: controller.adaptRecipe,
              ),
            ),

            SizedBox(height: AppSpacing.xl.h),
          ],
        ),
      ),
    );
  }
}
