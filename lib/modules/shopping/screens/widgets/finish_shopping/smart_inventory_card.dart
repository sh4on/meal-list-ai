import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_text_styles.dart';

class SmartInventoryCard extends StatelessWidget {
  final int collectedCount;

  const SmartInventoryCard({
    super.key,
    required this.collectedCount,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(16.w, 22.h, 16.w, 18.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F4EE),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: const Color(0xFFE5A869),
              width: 1.2,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: const Icon(
                  Icons.kitchen_outlined,
                  color: AppColors.primary,
                  size: 26,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Update your Pantry?',
                      style: AppTextStyles.titleMedium.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Would you like to add your $collectedCount purchased items to Pantry? This keeps your inventory up to date and improves future AI meal suggestions.',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: const Color(0xFF555555),
                        fontSize: 12.5.sp,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Floating "SMART INVENTORY" badge
        Positioned(
          top: -11,
          left: 16.w,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 4.h,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFE8984E),
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.auto_awesome,
                  color: AppColors.white,
                  size: 11,
                ),
                SizedBox(width: 4.w),
                Text(
                  'SMART INVENTORY',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
