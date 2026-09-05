import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/common_widgets/outline_button_widget.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';

// ask mealist result screen
// displays the tailored recipe resulting from AI customization prompt
class AskMealistResultScreen extends StatelessWidget {
  const AskMealistResultScreen({super.key});

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
        title: const Text('Adapted Recipe', style: AppTextStyles.headlineSmall),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSpacing.md.h),

            // AI adaptation summary badge
            Container(
              padding: const EdgeInsets.all(AppSpacing.cardPadding),
              decoration: BoxDecoration(
                color: AppColors.accentSurface,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: AppColors.accent.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.auto_awesome,
                    color: AppColors.accent,
                    size: 24,
                  ),
                  SizedBox(width: AppSpacing.md.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AI Customization Applied',
                          style: AppTextStyles.titleSmall.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Adjusted for higher protein and fresh garden vegetables.',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.lg.h),

            // recipe image with match tag
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: CachedNetworkImage(
                imageUrl:
                    'https://images.unsplash.com/photo-1544025162-d76694265947?w=800&q=80',
                height: 200.h,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: AppColors.shimmerBase),
                errorWidget: (_, __, ___) =>
                    Container(color: AppColors.shimmerBase),
              ),
            ),

            SizedBox(height: AppSpacing.md.h),

            // title and nutrition badges
            const Text(
              'High-Protein Mediterranean Chicken',
              style: AppTextStyles.headlineMedium,
            ),
            SizedBox(height: AppSpacing.sm.h),

            const Row(
              children: [
                _TagChip(label: '56g Protein', color: AppColors.primary),
                SizedBox(width: 8),
                _TagChip(label: '480 kcal', color: AppColors.textSecondary),
                SizedBox(width: 8),
                _TagChip(label: '25 min', color: AppColors.textSecondary),
              ],
            ),

            SizedBox(height: AppSpacing.lg.h),

            // key modifications made by AI
            Container(
              padding: const EdgeInsets.all(AppSpacing.cardPadding),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.border),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Key Changes', style: AppTextStyles.titleSmall),
                  SizedBox(height: 8),
                  _ChangeItem(
                    text:
                        'Replaced heavy cream with strained Greek yogurt (-140 kcal)',
                  ),
                  _ChangeItem(
                    text:
                        'Increased chicken breast portion from 350g to 500g (+22g protein)',
                  ),
                  _ChangeItem(
                    text:
                        'Added roasted zucchini and sweet bell peppers (+fiber)',
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.xl.h),

            // action buttons
            PrimaryButtonWidget(
              label: 'Cook This Now →',
              onTap: () => Get.toNamed(AppRoutes.cookMode),
            ),

            SizedBox(height: AppSpacing.sm.h),

            OutlineButtonWidget(
              label: 'Save to My Recipes',
              onTap: () {
                Get.back();
                Get.snackbar(
                  'Saved!',
                  'High-Protein Mediterranean Chicken saved to your recipes.',
                  backgroundColor: AppColors.white,
                  colorText: AppColors.textPrimary,
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

class _TagChip extends StatelessWidget {
  final String label;
  final Color color;

  const _TagChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cardBgSecondary,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ChangeItem extends StatelessWidget {
  final String text;
  const _ChangeItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 16,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: AppTextStyles.bodyMedium),
          ),
        ],
      ),
    );
  }
}
