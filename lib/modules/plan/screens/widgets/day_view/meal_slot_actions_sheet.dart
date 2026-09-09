import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../routes/app_routes.dart';
import '../../../controllers/plan_controller.dart';
import '../meal_actions/change_servings_sheet.dart';
import '../meal_actions/copy_meal_sheet.dart';
import '../meal_actions/move_meal_sheet.dart';
import '../meal_actions/regenerate_meal_sheet.dart';

void showMealSlotActions(BuildContext context, MealEntry meal) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MealSlotActionsSheet(meal: meal),
  );
}

class MealSlotActionsSheet extends StatefulWidget {
  final MealEntry meal;
  const MealSlotActionsSheet({super.key, required this.meal});

  @override
  State<MealSlotActionsSheet> createState() => _MealSlotActionsSheetState();
}

class _MealSlotActionsSheetState extends State<MealSlotActionsSheet> {
  int _servings = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppRadius.xxl)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.screenH.w,
              vertical: AppSpacing.md.h,
            ),
            child: Row(
              children: [
                Text(
                  'MEAL SLOT ACTIONS',
                  style: AppTextStyles.labelSmall.copyWith(letterSpacing: 1.2),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  child: Image.network(
                    widget.meal.imageAsset,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 56,
                      height: 56,
                      color: AppColors.shimmerBase,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.meal.name, style: AppTextStyles.titleMedium),
                      Text(
                        'Wednesday - ${widget.meal.mealType[0]}${widget.meal.mealType.substring(1).toLowerCase()} - $_servings servings',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.md.h),
          const Divider(color: AppColors.divider, height: 1),
          SheetAction(
            icon: Icons.swap_horiz_rounded,
            title: 'Replace with another recipe',
            subtitle: 'Pick or let Mealist choose',
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(
                AppRoutes.replaceMeal,
                arguments: {
                  'mealTitle': widget.meal.name,
                  'slot': 'Monday Lunch',
                },
              );
            },
          ),
          SheetAction(
            icon: Icons.auto_fix_high_outlined,
            title: 'Regenerate this meal',
            subtitle: 'New suggestion, same constraints',
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (_) => RegenerateMealSheet(
                  mealName: widget.meal.name,
                  currentSlot: 'Monday Lunch',
                ),
              );
            },
          ),
          SheetAction(
            icon: Icons.calendar_today_outlined,
            title: 'Move to another day',
            subtitle: 'Grocery list stays in sync',
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (_) => MoveMealSheet(
                  mealName: widget.meal.name,
                  currentSlot: 'Monday • Lunch',
                ),
              );
            },
          ),
          SheetAction(
            icon: Icons.copy_outlined,
            title: 'Copy to another day',
            subtitle: 'Additional items added to list',
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (_) => CopyMealSheet(
                  mealName: widget.meal.name,
                  currentSlot: 'Monday • Lunch',
                ),
              );
            },
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (_) => ChangeServingsSheet(
                  mealName: widget.meal.name,
                  initialServings: _servings,
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.screenH.w,
                vertical: AppSpacing.sm.h,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.people_alt_outlined,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Change servings',
                            style: AppTextStyles.titleSmall,),
                        Text(
                          'Grocery quantities update automatically',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  ServingsControl(
                    value: _servings,
                    onDecrement: () {
                      if (_servings > 1) setState(() => _servings--);
                    },
                    onIncrement: () => setState(() => _servings++),
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: AppColors.divider, height: 1),
          SheetAction(
            icon: Icons.bookmark_border_outlined,
            title: 'Save to My Recipes',
            subtitle: 'Add to your personal library',
            onTap: () {},
          ),
          SheetAction(
            icon: Icons.check_circle_outline,
            title: 'Mark as cooked',
            subtitle: 'Closes the cooking loop',
            onTap: () {},
          ),
          SheetAction(
            icon: Icons.delete_outline,
            title: 'Remove from plan',
            subtitle: 'Undo available for 10 seconds',
            titleColor: AppColors.error,
            iconColor: AppColors.error,
            onTap: () {},
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom + AppSpacing.md.h,
          ),
        ],
      ),
    );
  }
}

class SheetAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? titleColor;
  final Color? iconColor;
  const SheetAction({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.titleColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.screenH.w,
          vertical: AppSpacing.sm.h,
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? AppColors.textSecondary, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.titleSmall.copyWith(
                      color: titleColor ?? AppColors.textPrimary,
                    ),
                  ),
                  Text(subtitle, style: AppTextStyles.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServingsControl extends StatelessWidget {
  final int value;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  const ServingsControl({
    super.key,
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onDecrement,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child:
                  Icon(Icons.remove, size: 16, color: AppColors.textSecondary),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text('$value', style: AppTextStyles.titleMedium),
          ),
          GestureDetector(
            onTap: onIncrement,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Icon(Icons.add, size: 16, color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}

// ---- 3-DAY VIEW -------------------------------------------------------------
