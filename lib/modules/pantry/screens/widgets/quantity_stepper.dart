import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_text_styles.dart';

// stepper widget for quantity
class QuantityStepper extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const QuantityStepper({
    super.key,
    required this.controller,
    required this.onDecrement,
    required this.onIncrement,
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
      child: Row(
        children: [
          // decrement button
          GestureDetector(
            onTap: onDecrement,
            child: Container(
              width: 40.w,
              alignment: Alignment.center,
              child: const Icon(
                Icons.remove,
                size: 18,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // number input
          Expanded(
            child: TextField(
              controller: controller,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: AppTextStyles.titleSmall,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),

          // increment button
          GestureDetector(
            onTap: onIncrement,
            child: Container(
              width: 40.w,
              alignment: Alignment.center,
              child: const Icon(
                Icons.add,
                size: 18,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
