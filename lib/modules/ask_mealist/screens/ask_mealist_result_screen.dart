import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/common_widgets/outline_button_widget.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';

// ask mealist result screen
// shows what changed with AI adaptation items and nutrition impact matching figma design
class AskMealistResultScreen extends StatelessWidget {
  const AskMealistResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: Get.back,
        ),
        title: Text(
          'Ask Mealist',
          style: AppTextStyles.headlineSmall.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppSpacing.md.h),

                      // screen headline
                      Text(
                        'Here’s what changed',
                        style: AppTextStyles.headlineLarge.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),

                      // recipe being adapted
                      Text(
                        'Adapting Mediterranean Chicken',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: AppSpacing.lg.h),

                      // AI ADAPTATIONS card
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // card header label
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.auto_awesome,
                                    size: 14,
                                    color: AppColors.accent,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'AI ADAPTATIONS',
                                    style: AppTextStyles.labelSmall.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textSecondary,
                                      letterSpacing: 0.6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(height: 1, color: AppColors.divider),

                            // item 1: chicken breast increased
                            const _AdaptationRow(
                              icon: Icons.arrow_upward_rounded,
                              iconBg: Color(0xFFE2EFEA),
                              iconColor: AppColors.primary,
                              name: 'Chicken Breast',
                              oldValue: '500g',
                              newValue: '600g',
                              newValueColor: AppColors.primary,
                            ),
                            const Divider(height: 1, color: AppColors.divider),

                            // item 2: greek yogurt added
                            const _AdaptationRow(
                              icon: Icons.add,
                              iconBg: Color(0xFFFFF3E0),
                              iconColor: Color(0xFFE89020),
                              name: 'Greek Yogurt',
                              oldValue: null,
                              newValue: 'Added 100g',
                              newValueColor: Color(0xFFE89020),
                            ),
                            const Divider(height: 1, color: AppColors.divider),

                            // item 3: olive oil reduced
                            const _AdaptationRow(
                              icon: Icons.arrow_downward_rounded,
                              iconBg: Color(0xFFEDEDEA),
                              iconColor: AppColors.textSecondary,
                              name: 'Olive Oil',
                              oldValue: '2 tbsp',
                              newValue: '1 tbsp',
                              newValueColor: AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppSpacing.xl.h),

                      // NUTRITION IMPACT section
                      Text(
                        'NUTRITION IMPACT',
                        style: AppTextStyles.labelSmall.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                          letterSpacing: 0.6,
                        ),
                      ),
                      SizedBox(height: AppSpacing.sm.h),

                      // 2x2 nutrition impact grid
                      const Row(
                        children: [
                          Expanded(
                            child: _NutritionImpactCard(
                              label: 'Calories',
                              oldValue: '520',
                              newValue: '480 kcal',
                            ),
                          ),
                          SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: _NutritionImpactCard(
                              label: 'Protein',
                              oldValue: '32g',
                              newValue: '45g',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSpacing.sm.h),
                      const Row(
                        children: [
                          Expanded(
                            child: _NutritionImpactCard(
                              label: 'Carbs',
                              oldValue: '12g',
                              newValue: '10g',
                            ),
                          ),
                          SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: _NutritionImpactCard(
                              label: 'Fat',
                              oldValue: '28g',
                              newValue: '18g',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSpacing.lg.h),
                    ],
                  ),
                ),
              ),

              // dual action buttons: Save as v2 Recipe / Keep Original
              Column(
                children: [
                  PrimaryButtonWidget(
                    label: 'Save as v2 Recipe',
                    onTap: () {
                      Get.back();
                      Get.snackbar(
                        'Recipe Saved!',
                        'Mediterranean Chicken v2 saved to your recipes.',
                        backgroundColor: AppColors.white,
                        snackPosition: SnackPosition.BOTTOM,
                        margin: const EdgeInsets.all(16),
                      );
                    },
                  ),
                  SizedBox(height: AppSpacing.xs.h),
                  OutlineButtonWidget(
                    label: 'Keep Original',
                    textColor: AppColors.primary,
                    onTap: Get.back,
                  ),
                  SizedBox(height: AppSpacing.sm.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// single row inside AI ADAPTATIONS card
class _AdaptationRow extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String name;
  final String? oldValue;
  final String newValue;
  final Color newValueColor;

  const _AdaptationRow({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.name,
    required this.oldValue,
    required this.newValue,
    required this.newValueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          // circular indicator icon
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(width: 12),

          // ingredient name
          Expanded(
            child: Text(
              name,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // comparison values: old strikethrough -> new bold value
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (oldValue != null) ...[
                Text(
                  oldValue!,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.arrow_forward,
                  size: 12,
                  color: AppColors.textTertiary,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                newValue,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: newValueColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// 2x2 grid card showing nutrition impact
class _NutritionImpactCard extends StatelessWidget {
  final String label;
  final String oldValue;
  final String newValue;

  const _NutritionImpactCard({
    required this.label,
    required this.oldValue,
    required this.newValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                oldValue,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                newValue,
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
