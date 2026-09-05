import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';

// in-store shopping mode screen
// streamlined checklist with oversized touch targets optimized for walking supermarket aisles
class ShoppingModeScreen extends StatefulWidget {
  const ShoppingModeScreen({super.key});

  @override
  State<ShoppingModeScreen> createState() => _ShoppingModeScreenState();
}

class _ShoppingModeScreenState extends State<ShoppingModeScreen> {
  final List<Map<String, dynamic>> _items = [
    {'name': 'Chicken Breast', 'qty': '1.2 kg', 'checked': true},
    {'name': 'Greek Yogurt', 'qty': '600g', 'checked': true},
    {'name': 'Fresh Baby Spinach', 'qty': '250g', 'checked': true},
    {'name': 'Roma Tomatoes', 'qty': '6 items', 'checked': false},
    {'name': 'Whole Milk', 'qty': '1 L', 'checked': false},
    {'name': 'Feta Cheese', 'qty': '200g', 'checked': false},
  ];

  int get _collectedCount =>
      _items.where((final i) => i['checked'] as bool).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimary),
          onPressed: Get.back,
        ),
        title: Column(
          children: [
            const Text('Shopping Mode', style: AppTextStyles.headlineSmall),
            Text(
              '$_collectedCount of ${_items.length} items in cart',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // progress indicator across top
          LinearProgressIndicator(
            value: _items.isEmpty ? 0 : _collectedCount / _items.length,
            backgroundColor: AppColors.progressTrack,
            color: AppColors.primary,
            minHeight: 6,
          ),

          // oversized items list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.screenH.w,
                vertical: AppSpacing.md.h,
              ),
              itemCount: _items.length,
              itemBuilder: (final BuildContext ctx, final int index) {
                final Map<String, dynamic> item = _items[index];
                final bool isChecked = item['checked'] as bool;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      item['checked'] = !isChecked;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(AppSpacing.cardPaddingLg),
                    decoration: BoxDecoration(
                      color: isChecked
                          ? AppColors.white.withValues(alpha: 0.6)
                          : AppColors.white,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(
                        color: isChecked ? AppColors.border : AppColors.primary,
                        width: isChecked ? 1 : 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        // large check circle
                        Container(
                          width: 32.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                            color: isChecked
                                ? AppColors.primary
                                : Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isChecked
                                  ? AppColors.primary
                                  : AppColors.border,
                              width: 2,
                            ),
                          ),
                          child: isChecked
                              ? const Icon(
                                  Icons.check,
                                  color: AppColors.white,
                                  size: 20,
                                )
                              : null,
                        ),
                        SizedBox(width: AppSpacing.md.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'] as String,
                                style: AppTextStyles.titleMedium.copyWith(
                                  decoration: isChecked
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color: isChecked
                                      ? AppColors.textTertiary
                                      : AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                item['qty'] as String,
                                style: AppTextStyles.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // finish shopping action button
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
              label: 'Finish Shopping ($_collectedCount/${_items.length})',
              onTap: () {
                Get.defaultDialog(
                  title: 'Update Pantry?',
                  middleText:
                      'Would you like to automatically add these $_collectedCount collected items into your Smart Pantry?',
                  textConfirm: 'Update Pantry & Exit',
                  textCancel: 'Just Exit',
                  confirmTextColor: AppColors.white,
                  buttonColor: AppColors.primary,
                  cancelTextColor: AppColors.textSecondary,
                  onConfirm: () {
                    Get.back(); // close dialog
                    Get.offAllNamed(AppRoutes.main);
                    Get.snackbar(
                      'Pantry Updated',
                      '$_collectedCount grocery items added to your pantry.',
                      backgroundColor: AppColors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      margin: const EdgeInsets.all(AppSpacing.md),
                    );
                  },
                  onCancel: () {
                    Get.offAllNamed(AppRoutes.main);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
