import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';

// unit dropdown widget
class UnitDropdown extends StatelessWidget {
  final List<String> units;
  final String selectedUnit;
  final ValueChanged<String?> onChanged;

  const UnitDropdown({super.key,
    required this.units,
    required this.selectedUnit,
    required this.onChanged,
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedUnit,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.textSecondary,
            size: 20,
          ),
          style: AppTextStyles.inputText,
          onChanged: onChanged,
          items: units.map((final u) {
            return DropdownMenuItem<String>(
              value: u,
              child: Text(u),
            );
          }).toList(),
        ),
      ),
    );
  }
}