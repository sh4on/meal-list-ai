import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/controllers/bottom_nav_controller.dart';
import 'widgets/finish_shopping/figma_basket_badge.dart';
import 'widgets/finish_shopping/finish_stats_section.dart';
import 'widgets/finish_shopping/smart_inventory_card.dart';

// Finish Shopping confirmation screen -- clean structure with modular widgets
class FinishShoppingScreen extends StatelessWidget {
  const FinishShoppingScreen({super.key});

  static const int _totalItems = 24;
  static const int _collected = 22;
  static const int _notCollected = _totalItems - _collected;

  void _returnToPlan() {
    Get.until(
      (route) => route.settings.name == AppRoutes.main || route.isFirst,
    );
    Get.find<BottomNavController>().changeTo(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 48.h),

              // Basket illustration + check badge
              const FigmaBasketBadge(),

              SizedBox(height: 28.h),

              // Title & Subtitle
              Text(
                'Shopping complete?',
                style: AppTextStyles.headlineMedium.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  fontSize: 24.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                "Great job. You've gathered most of the\ningredients for your planned meals.",
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 14.sp,
                  height: 1.45,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 32.h),

              // Stats Cards (Left 24 Total Items, Right Collected / Not Collected)
              const FinishStatsSection(
                totalItems: _totalItems,
                collected: _collected,
                notCollected: _notCollected,
              ),

              SizedBox(height: 20.h),

              // Smart Inventory Card (Update your Pantry?)
              const SmartInventoryCard(
                collectedCount: _collected,
              ),

              const Spacer(),

              // Add Purchased to Pantry CTA
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _returnToPlan();
                    Get.snackbar(
                      'Pantry Updated',
                      '$_collected grocery items added to your pantry.',
                      backgroundColor: AppColors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      margin: const EdgeInsets.all(AppSpacing.md),
                      duration: const Duration(seconds: 3),
                    );
                  },
                  icon: const Icon(
                    Icons.add_circle_outline_rounded,
                    color: AppColors.white,
                    size: 20,
                  ),
                  label: Text(
                    'Add Purchased to Pantry',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10.h),

              // Not Now Button
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: OutlinedButton(
                  onPressed: _returnToPlan,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xFFD4DDD7),
                      width: 1.2,
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                  ),
                  child: Text(
                    'Not Now',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
