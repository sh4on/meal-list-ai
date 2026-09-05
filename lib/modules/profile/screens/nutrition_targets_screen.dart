import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';

// nutrition targets screen
// configures macronutrient ratios and daily nutritional ceilings
class NutritionTargetsScreen extends StatefulWidget {
  const NutritionTargetsScreen({super.key});

  @override
  State<NutritionTargetsScreen> createState() => _NutritionTargetsScreenState();
}

class _NutritionTargetsScreenState extends State<NutritionTargetsScreen> {
  double _proteinPercent = 35;
  double _carbsPercent = 40;
  double _fatPercent = 25;

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
        title:
            const Text('Nutrition Targets', style: AppTextStyles.headlineSmall),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSpacing.xs.h),
            Text(
              'Tune your macronutrient distribution.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: AppSpacing.lg.h),

            // macro distribution overview card
            Container(
              padding: const EdgeInsets.all(AppSpacing.cardPaddingLg),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _MacroTarget(
                        label: 'Protein',
                        percent: '${_proteinPercent.toInt()}%',
                        grams: '160g',
                        color: AppColors.progressProtein,
                      ),
                      _MacroTarget(
                        label: 'Carbs',
                        percent: '${_carbsPercent.toInt()}%',
                        grams: '185g',
                        color: AppColors.progressCarbs,
                      ),
                      _MacroTarget(
                        label: 'Fat',
                        percent: '${_fatPercent.toInt()}%',
                        grams: '52g',
                        color: AppColors.progressFat,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.lg.h),

                  // multi-colored distribution bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    child: Row(
                      children: [
                        Expanded(
                          flex: _proteinPercent.toInt(),
                          child: Container(
                            height: 10,
                            color: AppColors.progressProtein,
                          ),
                        ),
                        Expanded(
                          flex: _carbsPercent.toInt(),
                          child: Container(
                            height: 10,
                            color: AppColors.progressCarbs,
                          ),
                        ),
                        Expanded(
                          flex: _fatPercent.toInt(),
                          child: Container(
                            height: 10,
                            color: AppColors.progressFat,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.lg.h),

            // protein slider
            _MacroSlider(
              label: 'Protein Ratio',
              value: _proteinPercent,
              color: AppColors.progressProtein,
              onChanged: (final double v) =>
                  setState(() => _proteinPercent = v),
            ),

            SizedBox(height: AppSpacing.md.h),

            // carbs slider
            _MacroSlider(
              label: 'Carbohydrates Ratio',
              value: _carbsPercent,
              color: AppColors.progressCarbs,
              onChanged: (final double v) => setState(() => _carbsPercent = v),
            ),

            SizedBox(height: AppSpacing.md.h),

            // fat slider
            _MacroSlider(
              label: 'Healthy Fats Ratio',
              value: _fatPercent,
              color: AppColors.progressFat,
              onChanged: (final double v) => setState(() => _fatPercent = v),
            ),

            SizedBox(height: AppSpacing.xl.h),

            PrimaryButtonWidget(
              label: 'Save Macro Targets',
              onTap: () {
                Get.back();
                Get.snackbar(
                  'Updated!',
                  'Macronutrient targets saved.',
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

class _MacroTarget extends StatelessWidget {
  final String label;
  final String percent;
  final String grams;
  final Color color;

  const _MacroTarget({
    required this.label,
    required this.percent,
    required this.grams,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          percent,
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(grams, style: AppTextStyles.titleSmall),
        Text(label, style: AppTextStyles.labelSmall),
      ],
    );
  }
}

class _MacroSlider extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  final ValueChanged<double> onChanged;

  const _MacroSlider({
    required this.label,
    required this.value,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: AppTextStyles.titleMedium),
              Text(
                '${value.toInt()}%',
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
          Slider(
            value: value,
            min: 10,
            max: 60,
            divisions: 50,
            activeColor: color,
            inactiveColor: AppColors.progressTrack,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
