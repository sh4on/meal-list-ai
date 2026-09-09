import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';

enum BuildingPlanStepStatus {
  completed,
  active,
  pending,
}

class BuildingPlanChecklistCard extends StatelessWidget {
  final List<String> steps;
  final int currentStep;

  const BuildingPlanChecklistCard({
    super.key,
    required this.steps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 18.w,
        vertical: 22.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.7),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          for (int i = 0; i < steps.length; i++) ...[
            BuildingPlanStepRow(
              title: steps[i],
              status: i < currentStep
                  ? BuildingPlanStepStatus.completed
                  : (i == currentStep
                      ? BuildingPlanStepStatus.active
                      : BuildingPlanStepStatus.pending),
            ),
            if (i < steps.length - 1) SizedBox(height: 18.h),
          ],
        ],
      ),
    );
  }
}

class BuildingPlanStepRow extends StatelessWidget {
  final String title;
  final BuildingPlanStepStatus status;

  const BuildingPlanStepRow({
    super.key,
    required this.title,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Status indicator icon / circle
        switch (status) {
          BuildingPlanStepStatus.completed => Container(
              width: 24.w,
              height: 24.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFB5DFCC),
              ),
              child: const Icon(
                Icons.check,
                color: AppColors.primary,
                size: 15,
              ),
            ),
          BuildingPlanStepStatus.active => Container(
              width: 24.w,
              height: 24.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFB5DFCC),
              ),
              child: Center(
                child: Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          BuildingPlanStepStatus.pending => Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFD0D5DD),
                  width: 1.5,
                ),
              ),
            ),
        },

        SizedBox(width: 14.w),

        // Step Label
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: status == BuildingPlanStepStatus.active
                  ? FontWeight.w700
                  : FontWeight.w500,
              color: status == BuildingPlanStepStatus.active
                  ? AppColors.primary
                  : (status == BuildingPlanStepStatus.completed
                      ? AppColors.textPrimary
                      : const Color(0xFF667085)),
            ),
          ),
        ),
      ],
    );
  }
}
