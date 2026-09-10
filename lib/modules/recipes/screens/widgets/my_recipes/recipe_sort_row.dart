import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';

// row displaying recipe count on the left and an active sort label on the right
// tapping the sort label opens a bottom sheet sort picker
class RecipeSortRow extends StatelessWidget {
  final int count;
  final String sortBy;
  final ValueChanged<String> onSortChanged;

  const RecipeSortRow({
    super.key,
    required this.count,
    required this.sortBy,
    required this.onSortChanged,
  });

  static const List<String> _sortOptions = [
    'Most Cooked',
    'Newest',
    'Quickest',
  ];

  void _showSortSheet(final BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.screenH.w,
          AppSpacing.md.h,
          AppSpacing.screenH.w,
          AppSpacing.xxl.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: AppSpacing.md.h),
            const Text('Sort by', style: AppTextStyles.titleLarge),
            SizedBox(height: AppSpacing.sm.h),
            ..._sortOptions.map((final String option) {
              final bool isActive = option == sortBy;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  option,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: isActive ? AppColors.primary : AppColors.textPrimary,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                trailing: isActive
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  onSortChanged(option);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$count Recipes',
            style: AppTextStyles.labelMedium,
          ),
          // tapping the sort label opens a sheet to change sort order
          GestureDetector(
            onTap: () => _showSortSheet(context),
            child: Row(
              children: [
                Text(
                  '$sortBy ',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 16,
                  color: AppColors.textPrimary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
