import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';

class ShoppingModeRow extends StatelessWidget {
  final String name;
  final String qty;
  final bool isChecked;
  final bool isLast;
  final VoidCallback onTap;

  const ShoppingModeRow({
    super.key,
    required this.name,
    required this.qty,
    required this.isChecked,
    required this.isLast,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: isLast
              ? const BorderRadius.vertical(
                  bottom: Radius.circular(AppRadius.md),
                )
              : BorderRadius.zero,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 16,
            ),
            child: Row(
              children: [
                // checkbox
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: isChecked ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppRadius.xs),
                    border: Border.all(
                      color: isChecked ? AppColors.primary : AppColors.border,
                      width: 1.5,
                    ),
                  ),
                  child: isChecked
                      ? const Icon(
                          Icons.check,
                          color: AppColors.white,
                          size: 14,
                        )
                      : null,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    name,
                    style: AppTextStyles.titleSmall.copyWith(
                      color: isChecked
                          ? AppColors.textTertiary
                          : AppColors.textPrimary,
                      decoration: isChecked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      decorationColor: AppColors.textTertiary,
                    ),
                  ),
                ),
                Text(
                  qty,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isChecked
                        ? AppColors.textTertiary
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!isLast)
          const Divider(
            height: 1,
            color: AppColors.border,
            indent: AppSpacing.md,
            endIndent: AppSpacing.md,
          ),
      ],
    );
  }
}
