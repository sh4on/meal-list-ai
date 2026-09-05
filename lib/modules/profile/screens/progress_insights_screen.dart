import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';

// progress & insights screen
// visualizes plan adherence, weekly cooking stats, streaks, and smart habits
class ProgressInsightsScreen extends StatelessWidget {
  const ProgressInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    const List<bool> adherenceDays = [
      true,
      true,
      true,
      false,
      true,
      true,
      false,
    ];

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: Get.back,
        ),
        title: const Text('Progress', style: AppTextStyles.headlineSmall),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSpacing.xs.h),

            // subtitle
            Text(
              'See how your planning turns into real meals.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),

            SizedBox(height: AppSpacing.lg.h),

            // plan adherence card with weekly bar dots
            Container(
              padding: const EdgeInsets.all(AppSpacing.cardPaddingLg),
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
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Plan Adherence',
                            style: AppTextStyles.titleLarge,
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Consistency over perfection.',
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '78%',
                            style: AppTextStyles.displayMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Text('This Week',
                              style: AppTextStyles.labelSmall,),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: AppSpacing.xl.h),

                  // weekly adherence day chart
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: days.asMap().entries.map((final entry) {
                      final bool adhered = adherenceDays[entry.key];
                      return Column(
                        children: [
                          Container(
                            width: 32.w,
                            height: 32.w,
                            decoration: BoxDecoration(
                              color: adhered
                                  ? AppColors.primarySurface
                                  : AppColors.cardBgSecondary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: adhered
                                    ? AppColors.primary
                                    : AppColors.border,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                adhered ? Icons.check : Icons.remove,
                                size: 16,
                                color: adhered
                                    ? AppColors.primary
                                    : AppColors.textTertiary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            entry.value,
                            style: AppTextStyles.labelSmall.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.md.h),

            // streak highlight card
            Container(
              padding: const EdgeInsets.all(AppSpacing.cardPadding),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: const BoxDecoration(
                      color: AppColors.primarySurface,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.local_fire_department,
                      color: AppColors.primary,
                      size: 26,
                    ),
                  ),
                  SizedBox(width: AppSpacing.md.w),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('4 Week Streak', style: AppTextStyles.titleMedium),
                        SizedBox(height: 2),
                        Text(
                          "You're building consistent planning habits.",
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.sectionGap.h),

            // weekly summary 3-box row
            const Text('Weekly Summary', style: AppTextStyles.headlineSmall),
            SizedBox(height: AppSpacing.md.h),

            Row(
              children: [
                const _SummaryBox(label: 'Planned', count: '14'),
                SizedBox(width: AppSpacing.sm.w),
                const _SummaryBox(
                  label: 'Cooked',
                  count: '11',
                  color: AppColors.primary,
                ),
                SizedBox(width: AppSpacing.sm.w),
                const _SummaryBox(label: 'Skipped', count: '3'),
              ],
            ),

            SizedBox(height: AppSpacing.sectionGap.h),

            // mealist insights callout cards
            const Text('Mealist Insights', style: AppTextStyles.headlineSmall),
            SizedBox(height: AppSpacing.md.h),

            const _InsightCard(
              icon: Icons.auto_awesome,
              iconColor: AppColors.accent,
              bgColor: AppColors.accentSurface,
              text:
                  'You cooked 5 of 6 planned dinners this week. Thursday was the only deviation, showing strong evening consistency.',
            ),

            SizedBox(height: AppSpacing.md.h),

            const _InsightCard(
              icon: Icons.kitchen_outlined,
              iconColor: AppColors.primary,
              bgColor: AppColors.white,
              text:
                  '3 meals used ingredients already in your pantry, optimizing your grocery efficiency.',
            ),

            SizedBox(height: AppSpacing.xl.h),

            // share your week CTA button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.snackbar(
                    'Shared!',
                    'Weekly summary copied to clipboard.',
                    backgroundColor: AppColors.white,
                    snackPosition: SnackPosition.BOTTOM,
                    margin: const EdgeInsets.all(AppSpacing.md),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
                icon: const Icon(Icons.share_outlined, size: 20),
                label:
                    const Text('Share Your Week', style: AppTextStyles.button),
              ),
            ),

            SizedBox(height: AppSpacing.xxxl.h),
          ],
        ),
      ),
    );
  }
}

class _SummaryBox extends StatelessWidget {
  final String label;
  final String count;
  final Color? color;

  const _SummaryBox({
    required this.label,
    required this.count,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: AppTextStyles.displayMedium.copyWith(
                color: color ?? AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(label, style: AppTextStyles.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String text;

  const _InsightCard({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 22),
          SizedBox(width: AppSpacing.md.w),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyMedium.copyWith(height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
