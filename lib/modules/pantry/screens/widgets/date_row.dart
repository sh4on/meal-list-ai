import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';

// date row in the dates card
class DateRow extends StatelessWidget {
  final String label;
  final String value;
  final bool hasWarning;
  final VoidCallback? onTap;
  final bool isEditable;

  const DateRow({
    required this.label,
    required this.value,
    required this.hasWarning,
    this.onTap,
    this.isEditable = false,
  });

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      onTap: isEditable ? onTap : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.cardPadding,
          vertical: AppSpacing.md,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTextStyles.labelSmall),
            Row(
              children: [
                if (hasWarning && value != '—') ...[
                  const Icon(
                    Icons.circle,
                    size: 8,
                    color: AppColors.error,
                  ),
                  const SizedBox(width: 4),
                ],
                Text(
                  value,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: hasWarning && value != '—'
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (isEditable) ...[
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.edit_outlined,
                    size: 14,
                    color: AppColors.textTertiary,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}