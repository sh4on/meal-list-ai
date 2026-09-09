import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import 'day_pill_selector.dart';
import 'meal_time_selector.dart';

class CopyMealSheet extends StatefulWidget {
  final String mealName;
  final String currentSlot;

  const CopyMealSheet({
    super.key,
    this.mealName = 'Chicken Rice Bowl',
    this.currentSlot = 'Monday  •  Lunch',
  });

  @override
  State<CopyMealSheet> createState() => _CopyMealSheetState();
}

class _CopyMealSheetState extends State<CopyMealSheet> {
  int _selectedDayIndex = 2; // Tue 12
  MealTimeOption _selectedTime = MealTimeOption.lunch;

  final List<DayOption> _days = const [
    DayOption(dayName: 'Sun', dayNumber: 10),
    DayOption(dayName: 'Mon', dayNumber: 11, isCurrent: true),
    DayOption(dayName: 'Tue', dayNumber: 12),
    DayOption(dayName: 'Wed', dayNumber: 13),
    DayOption(dayName: 'Thu', dayNumber: 14),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),

            // Top Drag Handle
            Center(
              child: Container(
                width: 44.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFD1D5DB),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),

            SizedBox(height: 14.h),

            // Header with Close 'X'
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Copy Meal',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1E3A2F),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${widget.mealName}  •  ${widget.currentSlot}',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: const Color(0xFF6B7280),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF3F4F6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Color(0xFF4B5563),
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 14.h),
            const Divider(color: Color(0xFFE5E7EB), height: 1),
            SizedBox(height: 18.h),

            // Select Day Label
            Text(
              'SELECT DAY',
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF6B7280),
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 10.h),
            DayPillSelector(
              days: _days,
              selectedIndex: _selectedDayIndex,
              showBadgeOnSelected: true,
              onDaySelected: (idx) => setState(() => _selectedDayIndex = idx),
            ),

            SizedBox(height: 22.h),

            // Select Meal Time Label
            Text(
              'SELECT MEAL TIME',
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF6B7280),
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 10.h),
            MealTimeSelector(
              selectedOption: _selectedTime,
              onOptionSelected: (opt) => setState(() => _selectedTime = opt),
            ),

            SizedBox(height: 26.h),

            // Copy Meal Button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Get.snackbar(
                    'Meal Copied',
                    '${widget.mealName} copied successfully!',
                    backgroundColor: AppColors.white,
                    snackPosition: SnackPosition.BOTTOM,
                    margin: const EdgeInsets.all(16),
                    duration: const Duration(seconds: 2),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Copy Meal',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
