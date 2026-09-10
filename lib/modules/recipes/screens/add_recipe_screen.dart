import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import 'widgets/add_recipe/add_recipe_option_tile.dart';

// add a recipe entry screen
// shows four intake methods: link import, text paste, photo OCR, manual creation
class AddRecipeScreen extends StatelessWidget {
  const AddRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: Get.back,
        ),
        title: const Text(
          'Add a Recipe',
          style: AppTextStyles.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
          child: Column(
            children: [
              SizedBox(height: AppSpacing.md.h),

              // screen subtitle
              Text(
                'Bring your favourite recipes into Mealist.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: AppSpacing.xl.h),

              // option 1: import from a link
              AddRecipeOptionTile(
                icon: Icons.link_rounded,
                title: 'Import from a link',
                subtitle: 'Paste a recipe URL and Mealist will extract it.',
                onTap: () => Get.toNamed(AppRoutes.importFromLink),
              ),

              SizedBox(height: AppSpacing.sm.h),

              // option 2: paste recipe text
              AddRecipeOptionTile(
                icon: Icons.description_outlined,
                title: 'Paste recipe text',
                subtitle: 'Paste ingredients and instructions.',
                onTap: () => Get.toNamed(AppRoutes.createRecipeWizard),
              ),

              SizedBox(height: AppSpacing.sm.h),

              // option 3: import from a photo
              AddRecipeOptionTile(
                icon: Icons.camera_alt_outlined,
                title: 'Import from a photo',
                subtitle: 'Use a photo of a recipe.',
                onTap: () => Get.toNamed(AppRoutes.createRecipeWizard),
              ),

              SizedBox(height: AppSpacing.sm.h),

              // option 4: create manually
              AddRecipeOptionTile(
                icon: Icons.edit_outlined,
                title: 'Create manually',
                subtitle: 'Enter the recipe yourself.',
                onTap: () => Get.toNamed(AppRoutes.createRecipeWizard),
              ),

              SizedBox(height: AppSpacing.xxl.h),
            ],
          ),
        ),
      ),
    );
  }
}
