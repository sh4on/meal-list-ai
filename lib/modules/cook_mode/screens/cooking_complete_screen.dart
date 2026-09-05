import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/common_widgets/outline_button_widget.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';

// cooking complete celebration screen
// acknowledges meal preparation success with summary metrics and rating
class CookingCompleteScreen extends StatelessWidget {
  const CookingCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // celebratory animated check badge
              Container(
                width: 96.w,
                height: 96.w,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: AppColors.white,
                  size: 54,
                ),
              ),

              SizedBox(height: AppSpacing.xl.h),

              // celebration title & subtitle
              const Text('Delicious!', style: AppTextStyles.displayLarge),
              SizedBox(height: AppSpacing.xs.h),
              Text(
                'You just cooked Chicken Rice Bowl.',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: AppSpacing.xl.h),

              // recipe summary metric card
              Container(
                padding: const EdgeInsets.all(AppSpacing.cardPadding),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const _MetricColumn(label: 'Cook Time', value: '25 min'),
                    Container(width: 1, height: 32, color: AppColors.divider),
                    const _MetricColumn(label: 'Calories', value: '520 kcal'),
                    Container(width: 1, height: 32, color: AppColors.divider),
                    const _MetricColumn(label: 'Protein', value: '42g'),
                  ],
                ),
              ),

              SizedBox(height: AppSpacing.xl.h),

              // star rating section
              const Text(
                'How was the recipe?',
                style: AppTextStyles.titleMedium,
              ),
              SizedBox(height: AppSpacing.xs.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (final int index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      Icons.star_rounded,
                      color: AppColors.accent,
                      size: 32,
                    ),
                  );
                }),
              ),

              const Spacer(),

              // primary navigation CTA
              PrimaryButtonWidget(
                label: 'Back to Home',
                onTap: () => Get.offAllNamed(AppRoutes.main),
              ),

              SizedBox(height: AppSpacing.sm.h),

              // secondary action
              OutlineButtonWidget(
                label: 'View in Meal Plan',
                onTap: () => Get.offAllNamed(AppRoutes.main),
              ),

              SizedBox(height: AppSpacing.xl.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricColumn extends StatelessWidget {
  final String label;
  final String value;

  const _MetricColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 2),
        Text(label, style: AppTextStyles.labelSmall),
      ],
    );
  }
}
