import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';

// horizontal scrollable category filter chips
// the selected chip uses the primary green fill; others show a white bordered style
class RecipeFilterChips extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onSelected;

  const RecipeFilterChips({
    super.key,
    required this.selectedCategory,
    required this.onSelected,
  });

  static const List<String> _categories = [
    'All',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
        itemCount: _categories.length,
        separatorBuilder: (_, __) => SizedBox(width: AppSpacing.xs.w),
        itemBuilder: (final BuildContext ctx, final int index) {
          final String cat = _categories[index];
          final bool isSelected = selectedCategory == cat;
          return GestureDetector(
            onTap: () => onSelected(cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md.w,
                vertical: AppSpacing.xs.h,
              ),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.chipSelected : AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                border: Border.all(
                  color: isSelected
                      ? AppColors.chipSelected
                      : AppColors.chipUnselectedBorder,
                ),
              ),
              child: Text(
                cat,
                style: AppTextStyles.labelMedium.copyWith(
                  color: isSelected
                      ? AppColors.chipSelectedText
                      : AppColors.textPrimary,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
