import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';

class RecipeWhyPickedCard extends StatelessWidget {
  final String whyPicked;

  const RecipeWhyPickedCard({
    super.key,
    required this.whyPicked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFFCE3C5),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          // Subtle background sparkle watermark
          Positioned(
            top: -6,
            right: -4,
            child: Icon(
              Icons.auto_awesome,
              size: 40,
              color: const Color(0xFFE8984E).withValues(alpha: 0.12),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Color(0xFFE8984E),
                  size: 18,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WHY MEALIST PICKED THIS',
                      style: TextStyle(
                        fontSize: 9.5.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                        color: const Color(0xFFE8984E),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      whyPicked,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.textPrimary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
