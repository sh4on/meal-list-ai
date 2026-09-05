import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import 'circle_button.dart';

// quantity row with stepper and unit badge
class QuantityRow extends StatelessWidget {
  final TextEditingController controller;
  final String unit;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const QuantityRow({
    required this.controller,
    required this.unit,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(final BuildContext context) {
    return Row(
      children: [
        // minus
        CircleButton(icon: Icons.remove, onTap: onDecrement),
        SizedBox(width: AppSpacing.md.w),

        // number + unit
        Expanded(
          child: Container(
            height: 52.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IntrinsicWidth(
                  child: TextField(
                    controller: controller,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: AppTextStyles.headlineMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(width: AppSpacing.md.w),

        // plus
        CircleButton(icon: Icons.add, onTap: onIncrement),
      ],
    );
  }
}