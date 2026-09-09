import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';

class ShoppingCategorySection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Map<String, dynamic>> items;
  final ValueChanged<String>? onItemCollected;

  const ShoppingCategorySection({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
    this.onItemCollected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: AppColors.primary),
            const SizedBox(width: 6),
            Text(
              '$title (${items.length})',
              style: AppTextStyles.titleSmall.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.xs.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              for (int i = 0; i < items.length; i++) ...[
                ShoppingItemRow(
                  item: items[i],
                  onTap: () =>
                      onItemCollected?.call(items[i]['name'] as String),
                ),
                if (i < items.length - 1)
                  const Divider(
                    height: 1,
                    color: AppColors.border,
                    indent: AppSpacing.md,
                    endIndent: AppSpacing.md,
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class ShoppingItemRow extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;

  const ShoppingItemRow({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String? pantryQty = item['pantry'] as String?;
    final String? buyQty = item['buy'] as String?;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 2,
        ),
        child: Row(
          children: [
            // Checkbox outline
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.xs),
                border: Border.all(
                  color: AppColors.textTertiary,
                  width: 1.5,
                ),
              ),
            ),
            SizedBox(width: AppSpacing.md.w),
            // Item name
            Expanded(
              child: Text(
                item['name'] as String,
                style: AppTextStyles.titleSmall,
              ),
            ),
            // Quantity info
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (buyQty != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primarySurface,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(
                      'Buy $buyQty',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                ],
                if (pantryQty != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.kitchen_outlined,
                        size: 11,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        'Pantry $pantryQty',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  )
                else
                  Text(
                    item['qty'] as String,
                    style: AppTextStyles.bodySmall,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
