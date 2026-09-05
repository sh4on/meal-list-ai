import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../controllers/plan_controller.dart';

// plan screen — weekly/day meal planning view
class PlanScreen extends GetView<PlanController> {
  const PlanScreen({super.key});

  static const List<String> _days = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
  static const List<String> _mealSlots = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        title: const Text('Meal Plan', style: AppTextStyles.headlineSmall),
        actions: [
          // view mode toggle
          Obx(
            () => Container(
              margin: EdgeInsets.only(right: AppSpacing.md.w),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.cardBgSecondary,
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: controller.viewModes.map((String mode) {
                  final bool isActive = controller.viewMode.value == mode;
                  return GestureDetector(
                    onTap: () => controller.setViewMode(mode),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isActive ? AppColors.primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(AppRadius.xs),
                      ),
                      child: Text(
                        mode,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: isActive
                              ? AppColors.white
                              : AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // day selector row
          SizedBox(
            height: 70.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
              itemCount: _days.length,
              itemBuilder: (_, int index) {
                return Obx(() {
                  final bool isSelected =
                      controller.selectedDayIndex.value == index;
                  return GestureDetector(
                    onTap: () => controller.selectDay(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.white,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        border: Border.all(
                          color:
                              isSelected ? AppColors.primary : AppColors.border,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _days[index],
                            style: AppTextStyles.labelMedium.copyWith(
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
            ),
          ),

          // meal slot list for selected day
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.screenH.w,
                vertical: AppSpacing.md.h,
              ),
              itemCount: _mealSlots.length,
              itemBuilder: (_, int index) {
                return _MealSlotCard(slotName: _mealSlots[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// empty meal slot card with add button
class _MealSlotCard extends StatelessWidget {
  final String slotName;
  const _MealSlotCard({required this.slotName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                slotName.toUpperCase(),
                style: AppTextStyles.sectionHeader,
              ),
              const SizedBox(height: 4),
              Text(
                'No meal planned',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
          const Spacer(),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add, size: 16),
            label: const Text('Add'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}
