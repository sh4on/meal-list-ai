import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';

enum MealTimeOption {
  breakfast,
  lunch,
  dinner,
}

class MealTimeSelector extends StatelessWidget {
  final MealTimeOption selectedOption;
  final ValueChanged<MealTimeOption> onOptionSelected;

  const MealTimeSelector({
    super.key,
    required this.selectedOption,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildOptionRow(
          option: MealTimeOption.breakfast,
          title: 'Breakfast',
          icon: Icons.wb_twilight_rounded,
        ),
        SizedBox(height: 10.h),
        _buildOptionRow(
          option: MealTimeOption.lunch,
          title: 'Lunch',
          icon: Icons.wb_sunny_outlined,
        ),
        SizedBox(height: 10.h),
        _buildOptionRow(
          option: MealTimeOption.dinner,
          title: 'Dinner',
          icon: Icons.nightlight_round,
        ),
      ],
    );
  }

  Widget _buildOptionRow({
    required MealTimeOption option,
    required String title,
    required IconData icon,
  }) {
    final isSelected = option == selectedOption;

    return GestureDetector(
      onTap: () => onOptionSelected(option),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF2F8F5) : const Color(0xFFFDFDFD),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFE5E7EB),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : const Color(0xFF4B5563),
              size: 20,
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color:
                      isSelected ? AppColors.primary : const Color(0xFF1F2937),
                ),
              ),
            ),
            Container(
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color:
                      isSelected ? AppColors.primary : const Color(0xFFD1D5DB),
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 14,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
