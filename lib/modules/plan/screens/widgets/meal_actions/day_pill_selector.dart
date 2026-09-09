import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';

class DayOption {
  final String dayName;
  final int dayNumber;
  final bool isCurrent;

  const DayOption({
    required this.dayName,
    required this.dayNumber,
    this.isCurrent = false,
  });
}

class DayPillSelector extends StatelessWidget {
  final List<DayOption> days;
  final int selectedIndex;
  final ValueChanged<int> onDaySelected;
  final bool showBadgeOnSelected;

  const DayPillSelector({
    super.key,
    required this.days,
    required this.selectedIndex,
    required this.onDaySelected,
    this.showBadgeOnSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(days.length, (index) {
        final day = days[index];
        final isSelected = index == selectedIndex;

        return GestureDetector(
          onTap: () => onDaySelected(index),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 58.w,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFF2F8F5)
                      : (day.isCurrent
                          ? const Color(0xFFF9FAFB)
                          : AppColors.white),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : const Color(0xFFE5E7EB),
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      day.dayName,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? AppColors.primary
                            : const Color(0xFF6B7280),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${day.dayNumber}',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                        color: isSelected
                            ? AppColors.primary
                            : (day.isCurrent
                                ? const Color(0xFF9CA3AF)
                                : const Color(0xFF1F2937)),
                      ),
                    ),
                    if (day.isCurrent) ...[
                      SizedBox(height: 2.h),
                      Text(
                        'Current',
                        style: TextStyle(
                          fontSize: 9.sp,
                          color: const Color(0xFF9CA3AF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Top right checkmark badge when selected (as in Copy Meal screenshot)
              if (showBadgeOnSelected && isSelected)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    width: 16.w,
                    height: 16.w,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 11,
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
