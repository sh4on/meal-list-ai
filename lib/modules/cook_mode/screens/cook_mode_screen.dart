import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../controllers/cook_mode_controller.dart';

// guided cook mode screen
// provides hands-free focused step-by-step assistance with timers
class CookModeScreen extends GetView<CookModeController> {
  const CookModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimary),
          onPressed: () {
            Get.defaultDialog(
              title: 'Exit Cook Mode?',
              middleText:
                  'Your cooking progress will be discarded. Are you sure you want to exit?',
              textConfirm: 'Exit',
              textCancel: 'Keep Cooking',
              confirmTextColor: AppColors.white,
              buttonColor: AppColors.primary,
              cancelTextColor: AppColors.textSecondary,
              onConfirm: () {
                Get.back(); // close dialog
                Get.back(); // exit cook mode
              },
            );
          },
        ),
        title: Obx(
          () => Column(
            children: [
              Text(
                controller.recipeName.value,
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              Text(
                'Step ${controller.currentStep.value + 1} of ${controller.totalSteps}',
                style: AppTextStyles.labelSmall,
              ),
            ],
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Obx(
            () => LinearProgressIndicator(
              value: (controller.currentStep.value + 1) / controller.totalSteps,
              backgroundColor: AppColors.divider,
              color: AppColors.primary,
              minHeight: 4,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // scrollable step instructions
          Expanded(
            child: Obx(() {
              final Map<String, dynamic> step =
                  controller.steps[controller.currentStep.value];
              final List<dynamic> ingredients =
                  step['ingredients'] as List<dynamic>;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSpacing.md.h),

                    // step headline
                    Text(
                      step['title'] as String,
                      style: AppTextStyles.displayMedium.copyWith(
                        fontSize: 26,
                      ),
                    ),
                    SizedBox(height: AppSpacing.xs.h),

                    // screen awake indicator
                    const Row(
                      children: [
                        Icon(
                          Icons.stay_current_portrait,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Screen will stay awake while cooking',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),

                    SizedBox(height: AppSpacing.md.h),

                    // hero step photograph
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      child: CachedNetworkImage(
                        imageUrl: step['image'] as String,
                        height: 220.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (_, __) =>
                            Container(color: AppColors.shimmerBase),
                        errorWidget: (_, __, ___) =>
                            Container(color: AppColors.shimmerBase),
                      ),
                    ),

                    SizedBox(height: AppSpacing.md.h),

                    // ingredients required for this step
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
                          const Text(
                            'Ingredients for this step',
                            style: AppTextStyles.titleSmall,
                          ),
                          const SizedBox(height: 8),
                          ...ingredients.map((final item) {
                            final Map<String, dynamic> ing =
                                item as Map<String, dynamic>;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      color: AppColors.primarySurface,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      size: 12,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      ing['name'] as String,
                                      style: AppTextStyles.bodyMedium,
                                    ),
                                  ),
                                  Text(
                                    ing['amount'] as String,
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),

                    SizedBox(height: AppSpacing.md.h),

                    // detailed instruction text card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.cardPadding),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        step['instruction'] as String,
                        style: AppTextStyles.bodyLarge.copyWith(height: 1.6),
                      ),
                    ),

                    SizedBox(height: AppSpacing.md.h),

                    // step timer pill
                    Center(
                      child: GestureDetector(
                        onTap: controller.toggleTimer,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                controller.isTimerRunning.value
                                    ? Icons.pause_circle_outline
                                    : Icons.timer_outlined,
                                color: controller.isTimerRunning.value
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                                size: 22,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                controller.timerString,
                                style: AppTextStyles.headlineSmall.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                controller.isTimerRunning.value
                                    ? 'PAUSE'
                                    : 'START',
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: AppSpacing.xl.h),
                  ],
                ),
              );
            }),
          ),

          // bottom action navigation buttons
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
              () => Row(
                children: [
                  // previous button
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: controller.currentStep.value > 0
                          ? controller.previousStep
                          : null,
                      icon: const Icon(Icons.arrow_back, size: 18),
                      label: const Text('Previous'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        side: const BorderSide(color: AppColors.border),
                      ),
                    ),
                  ),

                  SizedBox(width: AppSpacing.md.w),

                  // next / complete button
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: controller.nextStep,
                      icon: Icon(
                        controller.currentStep.value ==
                                controller.totalSteps - 1
                            ? Icons.check
                            : Icons.arrow_forward,
                        size: 18,
                      ),
                      label: Text(
                        controller.currentStep.value ==
                                controller.totalSteps - 1
                            ? 'Finish'
                            : 'Next',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
