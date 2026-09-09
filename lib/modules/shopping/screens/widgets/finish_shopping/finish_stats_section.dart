import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';

class FinishStatsSection extends StatelessWidget {
  final int totalItems;
  final int collected;
  final int notCollected;

  const FinishStatsSection({
    super.key,
    required this.totalItems,
    required this.collected,
    required this.notCollected,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left Card: Total items
          Expanded(
            flex: 10,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: AppColors.border.withValues(alpha: 0.7),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Checklist icon top-right
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 32.w,
                      height: 32.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(
                          color: const Color(0xFFD5D9E0),
                          width: 1.5,
                        ),
                      ),
                      padding: EdgeInsets.all(4.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildChecklistLine(),
                          _buildChecklistLine(),
                          _buildChecklistLine(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$totalItems',
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          height: 1.0,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'TOTAL ITEMS',
                        style: TextStyle(
                          fontSize: 10.5.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Right Column: Collected & Not Collected
          Expanded(
            flex: 11,
            child: Column(
              children: [
                _buildStatCard(
                  count: '$collected',
                  label: 'COLLECTED',
                  indicatorColor: AppColors.primary,
                  trailingIcon: Icons.check_circle_outline_rounded,
                  iconColor: AppColors.primary,
                ),
                SizedBox(height: 10.h),
                _buildStatCard(
                  count: '$notCollected',
                  label: 'NOT COLLECTED',
                  indicatorColor: const Color(0xFF8B3A3A),
                  trailingIcon: Icons.error_outline_rounded,
                  iconColor: const Color(0xFF8B3A3A),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistLine() {
    return Row(
      children: [
        Container(
          width: 3,
          height: 3,
          decoration: const BoxDecoration(
            color: Color(0xFFD5D9E0),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 3),
        Expanded(
          child: Container(
            height: 1.5,
            color: const Color(0xFFD5D9E0),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String count,
    required String label,
    required Color indicatorColor,
    required IconData trailingIcon,
    required Color iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.7),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 4.w,
                color: indicatorColor,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              count,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                                height: 1.0,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              label,
                              style: TextStyle(
                                fontSize: 9.5.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.6,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        trailingIcon,
                        color: iconColor,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
