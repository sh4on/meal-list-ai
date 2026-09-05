import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';

// my goals settings screen
// lets user refine their target objective and daily meal frequency
class MyGoalsScreen extends StatefulWidget {
  const MyGoalsScreen({super.key});

  @override
  State<MyGoalsScreen> createState() => _MyGoalsScreenState();
}

class _MyGoalsScreenState extends State<MyGoalsScreen> {
  String _selectedGoal = 'Lose weight';
  double _calorieTarget = 1850;
  int _mealsPerDay = 3;

  final List<Map<String, String>> _goals = [
    {
      'title': 'Lose weight',
      'desc': 'Calorie deficit with high protein saturation',
    },
    {'title': 'Maintain weight', 'desc': 'Balanced macronutrient distribution'},
    {'title': 'Gain muscle', 'desc': 'Protein-dense surplus meals'},
    {'title': 'Eat healthier', 'desc': 'Unprocessed whole food focus'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: Get.back,
        ),
        title: const Text('My Goals', style: AppTextStyles.headlineSmall),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSpacing.xs.h),
            Text(
              'Choose your primary nutritional objective.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: AppSpacing.lg.h),

            // goals list
            ..._goals.map((final item) {
              final bool isSelected = _selectedGoal == item['title'];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedGoal = item['title']!;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(AppSpacing.cardPadding),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title']!,
                              style: AppTextStyles.titleMedium,
                            ),
                            const SizedBox(height: 2),
                            Text(item['desc']!, style: AppTextStyles.bodySmall),
                          ],
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.primary,
                          size: 22,
                        ),
                    ],
                  ),
                ),
              );
            }),

            SizedBox(height: AppSpacing.lg.h),

            // calorie target slider
            Container(
              padding: const EdgeInsets.all(AppSpacing.cardPadding),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Daily Calorie Target',
                        style: AppTextStyles.titleMedium,
                      ),
                      Text(
                        '${_calorieTarget.toInt()} kcal',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: _calorieTarget,
                    min: 1200,
                    max: 3500,
                    divisions: 46,
                    activeColor: AppColors.primary,
                    inactiveColor: AppColors.progressTrack,
                    onChanged: (final double val) {
                      setState(() {
                        _calorieTarget = val;
                      });
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.md.h),

            // meals per day selector
            Container(
              padding: const EdgeInsets.all(AppSpacing.cardPadding),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Planned Meals Per Day',
                    style: AppTextStyles.titleMedium,
                  ),
                  Row(
                    children: [3, 4, 5].map((final int m) {
                      final bool isSelected = _mealsPerDay == m;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _mealsPerDay = m;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 8),
                          width: 36.w,
                          height: 36.w,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.cardBgSecondary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '$m',
                              style: AppTextStyles.labelMedium.copyWith(
                                color: isSelected
                                    ? AppColors.white
                                    : AppColors.textPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.xl.h),

            PrimaryButtonWidget(
              label: 'Save Changes',
              onTap: () {
                Get.back();
                Get.snackbar(
                  'Saved!',
                  'Nutrition goal set to $_selectedGoal.',
                  backgroundColor: AppColors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  margin: const EdgeInsets.all(AppSpacing.md),
                );
              },
            ),

            SizedBox(height: AppSpacing.xxxl.h),
          ],
        ),
      ),
    );
  }
}
