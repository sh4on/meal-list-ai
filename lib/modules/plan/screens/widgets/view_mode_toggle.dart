import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../controllers/plan_controller.dart';

class ViewModeToggle extends StatelessWidget {
  const ViewModeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PlanController>();
    return Obx(
      () => Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppSpacing.screenH.w,
          vertical: 4.h,
        ),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: c.viewModes.map((mode) {
            final isActive = c.viewMode.value == mode;
            return Expanded(
              child: GestureDetector(
                onTap: () => c.setViewMode(mode),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    mode,
                    style: AppTextStyles.labelLarge.copyWith(
                      color:
                          isActive ? AppColors.white : AppColors.textSecondary,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
