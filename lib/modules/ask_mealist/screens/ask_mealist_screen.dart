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
// allows users to customize recipes using AI suggestions or natural language prompts
class AskMealistScreen extends GetView<AskMealistController> {
  const AskMealistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: Get.back,
        ),
        title: const Text('Ask Mealist', style: AppTextStyles.headlineSmall),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSpacing.sm.h),

              // top card with centered header and recipe context
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.cardPadding),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    // close button inside card on top right
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: Get.back,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF4F3EE),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),

                    // centered title
                    Text(
                      'Ask Mealist',
                      style: AppTextStyles.headlineMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.h),

                    // adapting recipe subtitle
                    Text(
                      'Adapting Mediterranean Chicken',
                      style: AppTextStyles.titleSmall.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),

                    // descriptive context
                    Text(
                      'A new version will be saved to your recipes.',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: AppSpacing.lg.h),

                    // quick suggestions header
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'QUICK SUGGESTIONS',
                        style: AppTextStyles.labelSmall.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    SizedBox(height: AppSpacing.sm.h),

                    // suggestions wrap chips
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
                              duration: const Duration(milliseconds: 180),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFFC3E8D8)
                                    : AppColors.white,
                                borderRadius:
                                    BorderRadius.circular(AppRadius.pill),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.border,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    icon,
                                    size: 15,
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
                                          ? FontWeight.w700
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
                    SizedBox(height: AppSpacing.lg.h),

                    // custom input prompt label
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'What would you like to change?',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    SizedBox(height: AppSpacing.xs.h),

                    // text input field container with microphone button
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Stack(
                        children: [
                          TextField(
                            controller: controller.promptController,
                            maxLines: 3,
                            style: AppTextStyles.inputText,
                            decoration: const InputDecoration(
                              hintText:
                                  'e.g. Can we make this spicy and add more vegetables?',
                              hintStyle: AppTextStyles.inputHint,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.fromLTRB(14, 14, 42, 14),
                            ),
                          ),
                          Positioned(
                            right: 6,
                            bottom: 6,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF4F3EE),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.mic_none_outlined,
                                color: AppColors.textSecondary,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppSpacing.lg.h),

                    // adapt recipe CTA button
                    Obx(
                      () => PrimaryButtonWidget(
                        label: '✨ Adapt Recipe →',
                        isLoading: controller.isLoading.value,
                        onTap: controller.adaptRecipe,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppSpacing.xl.h),
            ],
          ),
        ),
      ),
    );
  }
}
