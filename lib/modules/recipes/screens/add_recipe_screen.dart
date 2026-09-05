import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';

// add a recipe screen
// entry hub offering multiple intake paths: link import, text paste, photo OCR, and manual entry
class AddRecipeScreen extends StatelessWidget {
  const AddRecipeScreen({super.key});

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
        title: const Text('Add a Recipe', style: AppTextStyles.headlineSmall),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSpacing.md.h),

            // subtitle
            Center(
              child: Text(
                'Bring your favourite recipes into Mealist.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),

            SizedBox(height: AppSpacing.xl.h),

            // option 1: import from link
            _MethodCard(
              icon: Icons.link_rounded,
              title: 'Import from a link',
              subtitle: 'Paste a recipe URL and Mealist will extract it.',
              onTap: () => Get.toNamed(AppRoutes.importFromLink),
            ),

            SizedBox(height: AppSpacing.md.h),

            // option 2: paste recipe text
            _MethodCard(
              icon: Icons.description_outlined,
              title: 'Paste recipe text',
              subtitle: 'Paste ingredients and instructions.',
              onTap: () => Get.toNamed(AppRoutes.createRecipeWizard),
            ),

            SizedBox(height: AppSpacing.md.h),

            // option 3: import from photo
            _MethodCard(
              icon: Icons.camera_alt_outlined,
              title: 'Import from a photo',
              subtitle: 'Use a photo of a recipe.',
              onTap: () => Get.toNamed(AppRoutes.createRecipeWizard),
            ),

            SizedBox(height: AppSpacing.md.h),

            // option 4: create manually
            _MethodCard(
              icon: Icons.edit_outlined,
              title: 'Create manually',
              subtitle: 'Enter the recipe yourself.',
              onTap: () => Get.toNamed(AppRoutes.createRecipeWizard),
            ),
          ],
        ),
      ),
    );
  }
}

class _MethodCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MethodCard({
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
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            // circular icon container
            Container(
              width: 48.w,
              height: 48.w,
              decoration: const BoxDecoration(
                color: AppColors.cardBgSecondary,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 22),
            ),

            SizedBox(width: AppSpacing.md.w),

            // label and description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.titleMedium),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right,
              color: AppColors.textTertiary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
