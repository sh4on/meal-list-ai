import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';
import '../controllers/recipe_creator_controller.dart';
import 'widgets/import_link/ai_smart_parsing_card.dart';
import 'widgets/import_link/import_link_header.dart';

// import from link screen — matches new Figma layout
// centered header, URL input with globe icon, disclaimer, AI card, and CTA button
class ImportFromLinkScreen extends GetView<RecipeCreatorController> {
  const ImportFromLinkScreen({super.key});

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
          'Import from Link',
          style: AppTextStyles.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // centered header icon + title + description
              const ImportLinkHeader(),

              // recipe url label
              const Text('Recipe URL', style: AppTextStyles.inputLabel),
              SizedBox(height: AppSpacing.xs.h),

              // url text input with globe prefix icon
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.border),
                ),
                child: TextField(
                  controller: controller.urlController,
                  keyboardType: TextInputType.url,
                  style: AppTextStyles.inputText,
                  decoration: const InputDecoration(
                    hintText: 'https://example.com/recipe',
                    hintStyle: AppTextStyles.inputHint,
                    prefixIcon: Icon(
                      Icons.language,
                      color: AppColors.textTertiary,
                      size: 20,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),

              SizedBox(height: AppSpacing.xs.h),

              // disclaimer about pages that may not work
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 14,
                    color: AppColors.textTertiary,
                  ),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Some pages may not work if they require a login, paywall or video-only content.',
                      style: AppTextStyles.bodySmall,
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSpacing.lg.h),

              // AI smart parsing info card
              const AiSmartParsingCard(),

              const Spacer(),

              // extract / continue button
              Obx(
                () => PrimaryButtonWidget(
                  label: 'Continue to Review  →',
                  isLoading: controller.isImporting.value,
                  onTap: controller.importUrl,
                ),
              ),

              SizedBox(height: AppSpacing.xl.h),
            ],
          ),
        ),
      ),
    );
  }
}
