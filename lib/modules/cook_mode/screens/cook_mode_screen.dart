import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../controllers/cook_mode_controller.dart';
import 'widgets/exit_cook_mode_dialog.dart';

// guided cook mode screen matching figma sequence
// includes progress bar, timer capsule, step ingredient badges, and exit modal confirmation
class CookModeScreen extends GetView<CookModeController> {
  const CookModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.primary),
          onPressed: () async {
            final bool? exit = await ExitCookModeDialog.show(context);
            if (exit == true) {
              Get.back();
            }
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
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Obx(
            () => LinearProgressIndicator(
              value: (controller.currentStep.value + 1) / controller.totalSteps,
              backgroundColor: AppColors.divider,
              color: AppColors.primary,
              minHeight: 3,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // scrollable content for current step
          Expanded(
            child: Obx(() {
              final int stepIndex = controller.currentStep.value;
              final Map<String, dynamic> step = controller.steps[stepIndex];
              final bool isFinalStep = stepIndex == controller.totalSteps - 1;

              if (isFinalStep) {
                return _buildFinalStepContent(step);
              }

              return _buildStandardStepContent(step);
            }),
          ),

          // bottom action bar
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
            child: Obx(() {
              final bool isFinalStep =
                  controller.currentStep.value == controller.totalSteps - 1;

              if (isFinalStep) {
                // finish cooking full-width cta button
                return SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton.icon(
                    onPressed: controller.nextStep,
                    icon: const Icon(
                      Icons.check_circle,
                      color: AppColors.white,
                      size: 20,
                    ),
                    label: Text(
                      'Finish Cooking',
                      style: AppTextStyles.button.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
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
                );
              }

              final bool hasPrevious = controller.currentStep.value > 0;

              return Row(
                children: [
                  // previous button
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: ElevatedButton.icon(
                        onPressed:
                            hasPrevious ? controller.previousStep : null,
                        icon: Icon(
                          Icons.arrow_back,
                          size: 18,
                          color: hasPrevious
                              ? AppColors.primary
                              : const Color(0xFFB0B0B0),
                        ),
                        label: Text(
                          'Previous',
                          style: TextStyle(
                            color: hasPrevious
                                ? AppColors.primary
                                : const Color(0xFFB0B0B0),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: hasPrevious
                              ? const Color(0xFFC3E8D8)
                              : const Color(0xFFEBEBEB),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.sm.w),

                  // next button
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: ElevatedButton.icon(
                        onPressed: controller.nextStep,
                        label: const Text(
                          'Next',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        icon: const Icon(
                          Icons.arrow_forward,
                          size: 18,
                          color: AppColors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  // builds step 1 through 5 with ingredients, instruction card, and countdown timer
  Widget _buildStandardStepContent(final Map<String, dynamic> step) {
    final List<dynamic> ingredients =
        step['ingredients'] as List<dynamic>? ?? [];
    final String? category = step['category'] as String?;
    final String? hint = step['hint'] as String?;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSpacing.md.h),

          // optional category header (e.g., 'Prepare the sauce')
          if (category != null) ...[
            Text(
              category,
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4.h),
          ],

          // main step headline
          Text(
            step['title'] as String,
            style: AppTextStyles.headlineMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 1.3,
            ),
          ),
          SizedBox(height: 6.h),

          // screen awake reminder
          Row(
            children: [
              const Icon(
                Icons.stay_current_portrait_outlined,
                size: 14,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                'Screen will stay awake while cooking',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md.h),

          // step photograph
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: CachedNetworkImage(
              imageUrl: step['image'] as String,
              height: 200.h,
              width: double.infinity,
              fit: BoxFit.cover,
              memCacheWidth: 800,
              memCacheHeight: 600,
              placeholder: (final context, final url) =>
                  Container(color: AppColors.cardBgSecondary),
              errorWidget: (final context, final url, final error) =>
                  Container(color: AppColors.cardBgSecondary),
            ),
          ),
          SizedBox(height: AppSpacing.md.h),

          // ingredients for this step card
          if (ingredients.isNotEmpty) ...[
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
                  Text(
                    'INGREDIENTS FOR THIS STEP',
                    style: AppTextStyles.labelSmall.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: AppSpacing.sm.h),
                  ...ingredients.asMap().entries.map((final entry) {
                    final Map<String, dynamic> ing =
                        entry.value as Map<String, dynamic>;
                    final bool isLast = entry.key == ingredients.length - 1;

                    return Column(
                      children: [
                        Row(
                          children: [
                            // circular icon for ingredient type
                            Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF2F4F2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _iconForIngredient(ing['icon'] as String?),
                                size: 16,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(width: AppSpacing.sm.w),

                            // ingredient name
                            Expanded(
                              child: Text(
                                ing['name'] as String,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),

                            // amount tag
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEAF5F0),
                                borderRadius:
                                    BorderRadius.circular(AppRadius.pill),
                              ),
                              child: Text(
                                ing['amount'] as String,
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (!isLast) const Divider(height: 16, color: AppColors.divider),
                      ],
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: AppSpacing.md.h),
          ],

          // detailed instruction card
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
              style: AppTextStyles.bodyMedium.copyWith(
                height: 1.5,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          SizedBox(height: AppSpacing.md.h),

          // step countdown timer capsule
          Center(
            child: GestureDetector(
              onTap: controller.toggleTimer,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  border: Border.all(color: AppColors.border),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      controller.isTimerRunning.value
                          ? Icons.pause_circle_outline
                          : Icons.timer_outlined,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      controller.timerString,
                      style: AppTextStyles.titleMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      controller.isTimerRunning.value ? 'PAUSE' : 'START',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // optional hint note
          if (hint != null) ...[
            SizedBox(height: 8.h),
            Center(
              child: Text(
                hint,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],

          SizedBox(height: AppSpacing.xl.h),
        ],
      ),
    );
  }

  // builds final step 6 layout with finished badge and completion guidance
  Widget _buildFinalStepContent(final Map<String, dynamic> step) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSpacing.md.h),

          // finished dish photograph with FINISHED badge overlay
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.md),
                child: CachedNetworkImage(
                  imageUrl: step['image'] as String,
                  height: 240.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  memCacheWidth: 800,
                  memCacheHeight: 600,
                  placeholder: (final context, final url) =>
                      Container(color: AppColors.cardBgSecondary),
                  errorWidget: (final context, final url, final error) =>
                      Container(color: AppColors.cardBgSecondary),
                ),
              ),
              Positioned(
                bottom: 16.h,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.92),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.stars_rounded,
                        color: AppColors.primary,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'FINISHED',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.stars_rounded,
                        color: AppColors.primary,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.lg.h),

          // headline
          Text(
            step['title'] as String,
            style: AppTextStyles.headlineMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 1.3,
            ),
          ),
          SizedBox(height: AppSpacing.sm.h),

          // celebratory conclusion guidance
          Text(
            step['instruction'] as String,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),

          SizedBox(height: AppSpacing.xxl.h),
        ],
      ),
    );
  }

  IconData _iconForIngredient(final String? type) {
    switch (type) {
      case 'meat':
        return Icons.set_meal_outlined;
      case 'oil':
        return Icons.water_drop_outlined;
      case 'garlic':
        return Icons.eco_outlined;
      case 'drop':
        return Icons.opacity_outlined;
      case 'honey':
        return Icons.hive_outlined;
      case 'pepper':
        return Icons.grain_outlined;
      default:
        return Icons.restaurant_outlined;
    }
  }
}
