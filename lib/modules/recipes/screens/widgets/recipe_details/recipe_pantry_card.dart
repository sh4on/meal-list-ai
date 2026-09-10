import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';

// in your pantry card showing inventory match status
// displays matching and missing items with action to add missing to shopping list
class RecipePantryCard extends StatelessWidget {
  const RecipePantryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.accentSurface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          // light amber border provides soft visual grouping
          color: AppColors.accent.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header row with title and AI sparkle icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'In your pantry',
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const Icon(
                Icons.auto_awesome,
                size: 18,
                color: AppColors.accent,
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sm.h),

          // pantry item rows matching exact figma design
          const _PantryItemRow(
            icon: Icons.check_circle_rounded,
            iconColor: AppColors.primary,
            text: 'Chicken — 500g at home',
          ),
          SizedBox(height: 8.h),
          const _PantryItemRow(
            icon: Icons.check_circle_rounded,
            iconColor: AppColors.primary,
            text: 'Olive oil — at home',
          ),
          SizedBox(height: 8.h),
          const _PantryItemRow(
            icon: Icons.radio_button_unchecked,
            iconColor: AppColors.textSecondary,
            text: 'Missing: Lemon',
          ),
          SizedBox(height: AppSpacing.sm.h),

          // left-aligned add missing action link
          GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add missing to list →',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// individual pantry item row
class _PantryItemRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;

  const _PantryItemRow({
    required this.icon,
    required this.iconColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: iconColor),
        SizedBox(width: AppSpacing.xs.w),
        Text(
          text,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
