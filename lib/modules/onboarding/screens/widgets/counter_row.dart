// adults / children counter row
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class CounterRow extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const CounterRow({
    super.key,
    required this.label,
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: AppTextStyles.bodyLarge),
          ),
          // decrement
          GestureDetector(
            onTap: onDecrement,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border),
                color: AppColors.bg,
              ),
              child: const Icon(
                Icons.remove,
                size: 16,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          SizedBox(
            width: 36,
            child: Center(
              child: Text(
                '$value',
                style: AppTextStyles.titleMedium,
              ),
            ),
          ),
          // increment
          GestureDetector(
            onTap: onIncrement,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border),
                color: AppColors.bg,
              ),
              child: const Icon(
                Icons.add,
                size: 16,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
