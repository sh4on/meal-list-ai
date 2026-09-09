import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import '../controllers/shopping_controller.dart';
import 'widgets/shopping_list/shopping_category_section.dart';
import 'widgets/shopping_list/shopping_collected_item.dart';
import 'widgets/shopping_list/smart_pantry_banner.dart';

// Shopping List Screen -- clean architecture with separated widgets
class ShoppingListScreen extends GetView<ShoppingController> {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: Get.back,
        ),
        title: const Column(
          children: [
            Text(
              'Shopping List',
              style: AppTextStyles.headlineSmall,
            ),
            Text(
              'Generated from your planned meals',
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Tab toggle: By Aisle / By Recipe ───────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.screenH.w,
              vertical: AppSpacing.xs.h,
            ),
            child: Obx(
              () => Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBgSecondary,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.border),
                ),
                padding: const EdgeInsets.all(3),
                child: Row(
                  children: controller.tabs.asMap().entries.map((entry) {
                    final int idx = entry.key;
                    final String tab = entry.value;
                    final bool isSelected = controller.selectedTab.value == idx;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => controller.switchTab(idx),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.white
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color:
                                          Colors.black.withValues(alpha: 0.06),
                                      blurRadius: 4,
                                      offset: const Offset(0, 1),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Text(
                            tab,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.titleSmall.copyWith(
                              color: isSelected
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          // ── Scrollable body ─────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSpacing.sm.h),

                  // Smart Pantry Applied banner
                  const SmartPantryBanner(),

                  SizedBox(height: AppSpacing.md.h),

                  // Produce Category
                  ShoppingCategorySection(
                    title: 'Produce',
                    icon: Icons.eco_outlined,
                    items: const [
                      {
                        'name': 'Avocados',
                        'qty': '2',
                        'pantry': '1',
                        'buy': '1',
                      },
                      {
                        'name': 'Cherry tomatoes',
                        'qty': '250 g',
                        'pantry': null,
                        'buy': null,
                      },
                      {
                        'name': 'Baby spinach',
                        'qty': '100 g',
                        'pantry': '50 g',
                        'buy': '50 g',
                      },
                    ],
                    onItemCollected: controller.collectItem,
                  ),

                  SizedBox(height: AppSpacing.md.h),

                  // Meat & Seafood Category
                  ShoppingCategorySection(
                    title: 'Meat & Seafood',
                    icon: Icons.kebab_dining_outlined,
                    items: const [
                      {
                        'name': 'Chicken breast',
                        'qty': '800 g',
                        'pantry': null,
                        'buy': null,
                      },
                      {
                        'name': 'Salmon fillets',
                        'qty': '2 portions',
                        'pantry': null,
                        'buy': null,
                      },
                    ],
                    onItemCollected: controller.collectItem,
                  ),

                  SizedBox(height: AppSpacing.md.h),

                  // Dairy & Eggs Category
                  ShoppingCategorySection(
                    title: 'Dairy & Eggs',
                    icon: Icons.egg_outlined,
                    items: const [
                      {
                        'name': 'Eggs',
                        'qty': '12',
                        'pantry': '6',
                        'buy': '6',
                      },
                      {
                        'name': 'Greek yogurt',
                        'qty': '500 g',
                        'pantry': null,
                        'buy': null,
                      },
                    ],
                    onItemCollected: controller.collectItem,
                  ),

                  SizedBox(height: AppSpacing.md.h),

                  // + Add Item Button
                  Center(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                        size: 18,
                        color: AppColors.primary,
                      ),
                      label: const Text(
                        'Add Item',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xxl,
                          vertical: AppSpacing.sm,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: AppSpacing.lg.h),

                  // COLLECTED section
                  Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'COLLECTED (${controller.collectedItems.length})',
                          style: AppTextStyles.sectionHeader,
                        ),
                        SizedBox(height: AppSpacing.sm.h),
                        ...controller.collectedItems
                            .map((item) => ShoppingCollectedItem(name: item)),
                      ],
                    ),
                  ),

                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),

          // ── Start Shopping CTA ──────────────────────────────────────────
          SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.screenH.w,
                AppSpacing.sm.h,
                AppSpacing.screenH.w,
                AppSpacing.md.h,
              ),
              child: SizedBox(
                width: double.infinity,
                height: AppSpacing.buttonHeight,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(AppRoutes.shoppingMode),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                  child: const Text(
                    'Start Shopping  →',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
