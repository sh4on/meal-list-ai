import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';

class ShoppingCollectedItem extends StatelessWidget {
  final String name;
  const ShoppingCollectedItem({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.textTertiary,
              borderRadius: BorderRadius.circular(AppRadius.xs),
            ),
            child: const Icon(Icons.check, color: AppColors.white, size: 13),
          ),
          SizedBox(width: AppSpacing.md.w),
          Text(
            name,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textTertiary,
              decoration: TextDecoration.lineThrough,
              decorationColor: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
