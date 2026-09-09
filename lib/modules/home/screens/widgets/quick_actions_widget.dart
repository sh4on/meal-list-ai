import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../routes/app_routes.dart';

// quick actions grid
// provides immediate access to core everyday workflows: Add, Generate, Grocery, Scan, Pantry
class QuickActionsWidget extends StatelessWidget {
  const QuickActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _ActionButton(
              icon: Icons.add,
              label: 'Add',
              onTap: () => Get.toNamed(AppRoutes.addRecipe),
            ),
            _ActionButton(
              icon: Icons.auto_awesome,
              label: 'Generate',
              onTap: () => Get.toNamed(AppRoutes.askMealist),
            ),
            _ActionButton(
              icon: Icons.shopping_bag_outlined,
              label: 'Grocery',
              onTap: () => Get.toNamed(AppRoutes.shoppingList),
            ),
            _ActionButton(
              icon: Icons.camera_alt_outlined,
              label: 'Scan',
              onTap: () => Get.toNamed(AppRoutes.addRecipe),
            ),
          ],
        ),
        const SizedBox(
          height: AppSpacing.sm,
        ),
        _ActionButton(
          icon: Icons.kitchen_outlined,
          label: 'Pantry',
          onTap: () => Get.toNamed(AppRoutes.pantry),
          width: double.infinity,
        ),
      ],
    );
  }
}

// individual circular action icon button
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final double width;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.width = 72,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: width.w,
              height: 82.w,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black.withValues(alpha: 0.05),
                    child: Icon(
                      icon,
                      color: AppColors.primary,
                      size: AppSpacing.iconMd,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xs.h),
                  Text(label, style: AppTextStyles.labelMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
