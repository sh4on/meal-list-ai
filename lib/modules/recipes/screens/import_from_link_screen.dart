import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/common_widgets/app_text_field_widget.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';
import '../controllers/recipe_creator_controller.dart';

// import from a link screen
// allows importing recipes from public cooking websites and blogs by URL
class ImportFromLinkScreen extends GetView<RecipeCreatorController> {
  const ImportFromLinkScreen({super.key});

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
        title: const Text(
          'Import from a link',
          style: AppTextStyles.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSpacing.lg.h),

            const Text('Recipe URL', style: AppTextStyles.titleMedium),
            SizedBox(height: AppSpacing.xs.h),
            const Text(
              'Paste a link to any recipe on the web.',
              style: AppTextStyles.bodySmall,
            ),

            SizedBox(height: AppSpacing.md.h),

            // URL input field with paste action
            AppTextFieldWidget(
              label: 'Web Link',
              hint: 'https://example.com/recipe...',
              controller: controller.urlController,
              keyboardType: TextInputType.url,
              prefixIcon: const Icon(
                Icons.link_rounded,
                color: AppColors.textTertiary,
              ),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.content_paste_outlined,
                  color: AppColors.primary,
                ),
                onPressed: () {
                  controller.urlController.text =
                      'https://nytimes.com/cooking/recipes/pasta-primavera';
                },
              ),
            ),

            SizedBox(height: AppSpacing.lg.h),

            // supported domains info box
            Container(
              padding: const EdgeInsets.all(AppSpacing.cardPadding),
              decoration: BoxDecoration(
                color: AppColors.cardBgSecondary,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.border),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Supports AllRecipes, NYT Cooking, BBC Good Food, Bon Appétit, and hundreds of cooking blogs.',
                      style: AppTextStyles.bodySmall,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // extract recipe button
            Obx(
              () => PrimaryButtonWidget(
                label: 'Extract Recipe →',
                isLoading: controller.isImporting.value,
                onTap: controller.importUrl,
              ),
            ),

            SizedBox(height: AppSpacing.xl.h),
          ],
        ),
      ),
    );
  }
}
