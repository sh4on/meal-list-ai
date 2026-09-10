import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';

// single option tile on the Add a Recipe screen
// circular cream icon container, title, subtitle, and a chevron arrow
class AddRecipeOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const AddRecipeOptionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            // circular cream-colored icon container
            Container(
              width: 48.w,
              height: 48.w,
              decoration: const BoxDecoration(
                color: AppColors.primarySurface,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 22),
            ),

            SizedBox(width: AppSpacing.md.w),

            // title and subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.titleMedium),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTextStyles.bodySmall),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
