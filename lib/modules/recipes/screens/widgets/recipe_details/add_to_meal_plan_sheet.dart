import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';

// add to meal plan bottom sheet matching the exact figma design
// features date selection, meal category chips, servings capsule, replace warning, and cta
class AddToMealPlanSheet {
  const AddToMealPlanSheet._();

  static void show(
    final BuildContext context, {
    required final String recipeName,
  }) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (final BuildContext ctx) =>
          _AddToMealPlanContent(recipeName: recipeName),
    );
  }
}

class _AddToMealPlanContent extends StatefulWidget {
  final String recipeName;

  const _AddToMealPlanContent({required this.recipeName});

  @override
  State<_AddToMealPlanContent> createState() => _AddToMealPlanContentState();
}

class _AddToMealPlanContentState extends State<_AddToMealPlanContent> {
  int _selectedDayIndex = 0;
  String _selectedMeal = 'Dinner';
  int _servings = 2;

  static const List<Map<String, String>> _days = [
    {'date': 'Oct 23', 'sub': 'Today'},
    {'date': 'Oct 24', 'sub': 'Tomorrow'},
    {'date': 'Oct 25', 'sub': 'Wed'},
    {'date': 'Oct 26', 'sub': 'Thu'},
  ];

  static const List<Map<String, dynamic>> _meals = [
    {'label': 'Breakfast', 'icon': Icons.bakery_dining_outlined},
    {'label': 'Lunch', 'icon': Icons.lunch_dining_outlined},
    {'label': 'Dinner', 'icon': Icons.dinner_dining_outlined},
    {'label': 'Snack', 'icon': Icons.tapas_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.screenH.w,
            AppSpacing.sm.h,
            AppSpacing.screenH.w,
            AppSpacing.md.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // centered top drag handle
              Center(
                child: Container(
                  width: 36.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.md.h),

              // header: title + subtitle + close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add to Plan',
                        style: AppTextStyles.headlineSmall.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        widget.recipeName,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF4F3EE),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.lg.h),

              // section: WHEN
              Text(
                'WHEN',
                style: AppTextStyles.labelSmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(height: AppSpacing.xs.h),
              Row(
                children: _days.asMap().entries.map((final entry) {
                  final bool isSelected = entry.key == _selectedDayIndex;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedDayIndex = entry.key),
                      child: Container(
                        margin: EdgeInsets.only(
                          right: entry.key < 3 ? AppSpacing.xs.w : 0,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : AppColors.white,
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.border,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              entry.value['date']!,
                              style: AppTextStyles.labelMedium.copyWith(
                                fontWeight: FontWeight.w700,
                                color: isSelected
                                    ? AppColors.white
                                    : AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              entry.value['sub']!,
                              style: AppTextStyles.labelSmall.copyWith(
                                color: isSelected
                                    ? AppColors.white.withValues(alpha: 0.8)
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: AppSpacing.lg.h),

              // section: MEAL
              Text(
                'MEAL',
                style: AppTextStyles.labelSmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(height: AppSpacing.xs.h),
              Row(
                children: _meals.map((final m) {
                  final String label = m['label'] as String;
                  final IconData icon = m['icon'] as IconData;
                  final bool isSelected = _selectedMeal == label;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedMeal = label),
                      child: Container(
                        margin: EdgeInsets.only(
                          right: m != _meals.last ? AppSpacing.xs.w : 0,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFC3E8D8)
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF86CCA9)
                                : AppColors.border,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              icon,
                              size: 22,
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textPrimary,
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              label,
                              style: AppTextStyles.labelSmall.copyWith(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.textPrimary,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: AppSpacing.lg.h),

              // section: SERVINGS with upper and lower border lines
              Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: const BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(color: AppColors.divider),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SERVINGS',
                      style: AppTextStyles.labelSmall.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondary,
                        letterSpacing: 0.8,
                      ),
                    ),

                    // capsule stepper
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDECE8),
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: _servings > 1
                                ? () => setState(() => _servings--)
                                : null,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: Icon(
                                Icons.remove,
                                size: 16,
                                color: _servings > 1
                                    ? AppColors.textPrimary
                                    : AppColors.textTertiary,
                              ),
                            ),
                          ),
                          SizedBox(width: 14.w),
                          Text(
                            '$_servings',
                            style: AppTextStyles.titleMedium.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(width: 14.w),
                          GestureDetector(
                            onTap: () => setState(() => _servings++),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: const Icon(
                                Icons.add,
                                size: 16,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSpacing.md.h),

              // replacement warning banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.cardPadding),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF0F0),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(
                    color: const Color(0xFFF7D2D2),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: AppColors.error,
                      size: 18,
                    ),
                    SizedBox(width: AppSpacing.sm.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'This will replace:',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Turkish Lentil Soup',
                            style: AppTextStyles.titleSmall.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSpacing.sm.h),

              // missing ingredients added to shopping list notice
              Row(
                children: [
                  const Icon(
                    Icons.shopping_bag_outlined,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: AppSpacing.xs.w),
                  Text(
                    'Missing ingredients will be added to your Shopping List.',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.lg.h),

              // add to plan cta button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                  child: const Text('Add to Plan', style: AppTextStyles.button),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
