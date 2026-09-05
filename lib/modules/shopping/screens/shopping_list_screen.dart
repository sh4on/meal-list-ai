import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';
import '../controllers/shopping_controller.dart';

// shopping list screen — matches figma: aisle/recipe tab, smart pantry banner,
// grouped items with checkboxes, collected items section, start shopping cta
class ShoppingListScreen extends GetView<ShoppingController> {
  const ShoppingListScreen({super.key});

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
        title: const Column(
          children: [
            Text('Shopping List', style: AppTextStyles.headlineSmall),
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
          // tab bar — By Aisle / By Recipe
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.screenH.w,
              vertical: AppSpacing.sm.h,
            ),
            child: Obx(
              () => Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBgSecondary,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: controller.tabs.asMap().entries.map((entry) {
                    final bool isSelected =
                        controller.selectedTab.value == entry.key;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => controller.switchTab(entry.key),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.white
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                          ),
                          child: Text(
                            entry.value,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.titleSmall.copyWith(
                              color: isSelected
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
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

          // scrollable list
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSpacing.sm.h),

                  // smart pantry applied banner
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
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
                          size: AppSpacing.iconMd,
                        ),
                        SizedBox(width: AppSpacing.md.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Smart Pantry Applied',
                                style: AppTextStyles.titleSmall.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'We subtracted items you already have based on your last pantry update.',
                                style: AppTextStyles.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: AppSpacing.lg.h),

                  // category groups
                  Obx(
                    () => Column(
                      children: controller.categories
                          .asMap()
                          .entries
                          .map(
                            (MapEntry<int, Map<String, dynamic>> catEntry) =>
                                _CategorySection(
                              catIndex: catEntry.key,
                              category: catEntry.value,
                              controller: controller,
                            ),
                          )
                          .toList(),
                    ),
                  ),

                  SizedBox(height: AppSpacing.lg.h),

                  // add item button
                  Center(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                        color: AppColors.textPrimary,
                      ),
                      label: const Text(
                        'Add Item',
                        style: AppTextStyles.labelLarge,
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xl,
                          vertical: AppSpacing.sm,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: AppSpacing.lg.h),

                  // collected items
                  Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'COLLECTED (${controller.collectedItems.length})',
                          style: AppTextStyles.sectionHeader,
                        ),
                        SizedBox(height: AppSpacing.sm.h),
                        ...controller.collectedItems.map(
                          (String item) => _CollectedItem(name: item),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: AppSpacing.xxxl.h),
                ],
              ),
            ),
          ),

          // start shopping cta at bottom
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.screenH.w,
              AppSpacing.md.h,
              AppSpacing.screenH.w,
              AppSpacing.xl.h,
            ),
            child: PrimaryButtonWidget(
              label: 'Start Shopping →',
              onTap: () => Get.toNamed(AppRoutes.shoppingMode),
            ),
          ),
        ],
      ),
    );
  }
}

// category group section with header and items
class _CategorySection extends StatelessWidget {
  final int catIndex;
  final Map<String, dynamic> category;
  final ShoppingController controller;

  const _CategorySection({
    required this.catIndex,
    required this.category,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final List<dynamic> items = category['items'] as List<dynamic>;
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          // category header
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                Text(category['icon'] as String),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  category['category'] as String,
                  style: AppTextStyles.sectionHeader,
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),

          // item rows
          ...items.asMap().entries.map(
            (MapEntry<int, dynamic> itemEntry) {
              final Map<String, dynamic> item =
                  itemEntry.value as Map<String, dynamic>;
              return _ShoppingItem(
                item: item,
                onToggle: () => controller.toggleItem(
                  catIndex,
                  itemEntry.key,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// individual shopping item row
class _ShoppingItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onToggle;

  const _ShoppingItem({required this.item, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final bool isChecked = item['checked'] as bool? ?? false;
    final String? buyQty = item['buy'] as String?;
    final String? pantryQty = item['pantry'] as String?;

    return InkWell(
      onTap: onToggle,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            // checkbox
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isChecked ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(AppRadius.xs),
                border: Border.all(
                  color: isChecked ? AppColors.primary : AppColors.border,
                  width: 1.5,
                ),
              ),
              child: isChecked
                  ? const Icon(Icons.check, color: AppColors.white, size: 13)
                  : null,
            ),
            SizedBox(width: AppSpacing.md.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'] as String,
                    style: AppTextStyles.bodyMedium.copyWith(
                      decoration: isChecked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: isChecked
                          ? AppColors.textTertiary
                          : AppColors.textPrimary,
                    ),
                  ),
                  if (buyQty != null)
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.successSurface,
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                          child: Text(
                            'Buy $buyQty',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          'Total-${item['qty']}',
                          style: AppTextStyles.bodySmall,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        const Icon(
                          Icons.kitchen_outlined,
                          size: 12,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          'Pantry $pantryQty',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    )
                  else
                    Text(item['qty'] as String, style: AppTextStyles.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// already-collected item — greyed out with checkmark
class _CollectedItem extends StatelessWidget {
  final String name;
  const _CollectedItem({required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.textTertiary,
              borderRadius: BorderRadius.circular(AppRadius.xs),
            ),
            child: const Icon(Icons.check, color: AppColors.white, size: 13),
          ),
          SizedBox(width: AppSpacing.md.w),
          Text(
            name,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textTertiary,
              decoration: TextDecoration.lineThrough,
              decorationColor: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
