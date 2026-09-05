import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mealist_ai/modules/pantry/screens/widgets/pantry_section_card.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';
import '../controllers/pantry_controller.dart';

// my pantry screen
// displays inventory items categorized into fridge, pantry, and freezer sections
class MyPantryScreen extends GetView<PantryController> {
  const MyPantryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // scaffold provides root visual structure
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: Get.back,
        ),
        title: Text(
          'My Pantry',
          style: AppTextStyles.headlineMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // scrollable inventory content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSpacing.xs.h),

                  // search input bar
                  // allows quick lookups across all inventory items
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: TextField(
                      onChanged: controller.updateSearch,
                      style: AppTextStyles.inputText,
                      decoration: const InputDecoration(
                        hintText: 'Find ingredient...',
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.textTertiary,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),

                  SizedBox(height: AppSpacing.md.h),

                  // add button
                  // triggers navigation to ingredient addition modal
                  PrimaryButtonWidget(
                    label: '+ Add',
                    onTap: () => Get.toNamed(AppRoutes.addToPantry),
                  ),

                  SizedBox(height: AppSpacing.md.h),

                  // category tabs row: All, Fridge, Freezer, Pantry
                  // enables selective filtering based on storage compartment
                  Obx(
                    () => Row(
                      children: controller.tabs.map((final String tab) {
                        final bool isSelected =
                            controller.selectedTab.value == tab;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => controller.selectTab(tab),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primarySurface
                                    : AppColors.white,
                                borderRadius:
                                    BorderRadius.circular(AppRadius.sm),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.border,
                                ),
                              ),
                              child: Text(
                                tab,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.labelMedium.copyWith(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.textPrimary,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: AppSpacing.lg.h),

                  // fridge section
                  Obx(() {
                    if (controller.selectedTab.value != 'All' &&
                        controller.selectedTab.value != 'Fridge') {
                      return const SizedBox.shrink();
                    }
                    return PantrySectionCard(
                      title: 'Fridge',
                      icon: Icons.kitchen_outlined,
                      items: controller.fridgeItems,
                    );
                  }),

                  SizedBox(height: AppSpacing.md.h),

                  // pantry section
                  Obx(() {
                    if (controller.selectedTab.value != 'All' &&
                        controller.selectedTab.value != 'Pantry') {
                      return const SizedBox.shrink();
                    }
                    return PantrySectionCard(
                      title: 'Pantry',
                      icon: Icons.table_restaurant_outlined,
                      items: controller.pantryItems,
                    );
                  }),

                  SizedBox(height: AppSpacing.md.h),

                  // freezer section
                  Obx(() {
                    if (controller.selectedTab.value != 'All' &&
                        controller.selectedTab.value != 'Freezer') {
                      return const SizedBox.shrink();
                    }
                    return PantrySectionCard(
                      title: 'Freezer',
                      icon: Icons.ac_unit_outlined,
                      items: controller.freezerItems,
                    );
                  }),

                  SizedBox(height: AppSpacing.xxxl.h),
                ],
              ),
            ),
          ),

          // bottom action bar: What can I cook?
          // uses AI to match current ingredients with delicious recipes
          Container(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.screenH.w,
              AppSpacing.sm.h,
              AppSpacing.screenH.w,
              AppSpacing.xl.h,
            ),
            decoration: const BoxDecoration(
              color: AppColors.bg,
              border: Border(top: BorderSide(color: AppColors.divider)),
            ),
            child: PrimaryButtonWidget(
              label: '✨ What can I cook?',
              onTap: () => Get.toNamed(AppRoutes.whatCanICook),
            ),
          ),
        ],
      ),
    );
  }
}
