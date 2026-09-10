import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';

// clean flat ingredient list matching the recipe details figma design
// directly rendered on background with left-aligned names and right-aligned quantities
class RecipeIngredientList extends StatelessWidget {
  const RecipeIngredientList({super.key});

  static const List<Map<String, String>> _ingredients = [
    {'name': 'Chicken Breasts', 'qty': '2'},
    {'name': 'Olive Oil', 'qty': '2 tbsp'},
    {'name': 'Dried Oregano', 'qty': '1 tsp'},
    {'name': 'Garlic Cloves', 'qty': '3'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // section title
        Text(
          'Ingredients',
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppSpacing.sm.h),

        // ingredient rows
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: _ingredients.length,
          separatorBuilder: (final context, final index) =>
              SizedBox(height: 12.h),
          itemBuilder: (final BuildContext ctx, final int index) {
            final Map<String, String> item = _ingredients[index];
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item['name'] ?? '',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  item['qty'] ?? '',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
