import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';

enum RegeneratePreference {
  similarCuisine,
  differentCuisine,
  quickMeal,
  usePantryIngredients,
}

class RegenerateMealSheet extends StatefulWidget {
  final String mealName;
  final String currentSlot;

  const RegenerateMealSheet({
    super.key,
    this.mealName = 'Chicken Rice Bowl',
    this.currentSlot = 'Monday Lunch',
  });

  @override
  State<RegenerateMealSheet> createState() => _RegenerateMealSheetState();
}

class _RegenerateMealSheetState extends State<RegenerateMealSheet> {
  RegeneratePreference _selectedPreference =
      RegeneratePreference.similarCuisine;

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
                        'Regenerate this meal?',
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
            SizedBox(height: 16.h),

            // Description text
            Text(
              'Mealist will create a new option using your current goals, preferences, available ingredients and meal constraints.',
              style: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xFF6B7280),
                height: 1.4,
              ),
            ),

            SizedBox(height: 20.h),

            // Adjustment Preferences Label
            Text(
              'ADJUSTMENT PREFERENCES',
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF6B7280),
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 12.h),

            // Preference Options
            _buildPreferenceOption(
              preference: RegeneratePreference.similarCuisine,
              title: 'Similar cuisine',
            ),
            SizedBox(height: 10.h),
            _buildPreferenceOption(
              preference: RegeneratePreference.differentCuisine,
              title: 'Different cuisine',
            ),
            SizedBox(height: 10.h),
            _buildPreferenceOption(
              preference: RegeneratePreference.quickMeal,
              title: 'Quick meal',
            ),
            SizedBox(height: 10.h),
            _buildPreferenceOption(
              preference: RegeneratePreference.usePantryIngredients,
              title: 'Use pantry ingredients',
              hasSparkle: true,
              isHighlight: true,
            ),

            SizedBox(height: 24.h),

            // Regenerate Button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Get.snackbar(
                    'Meal Regenerated',
                    'Generating a fresh new option for ${widget.mealName}!',
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
                    const Icon(
                      Icons.sync_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Regenerate',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
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

  Widget _buildPreferenceOption({
    required RegeneratePreference preference,
    required String title,
    bool hasSparkle = false,
    bool isHighlight = false,
  }) {
    final isSelected = _selectedPreference == preference;

    return GestureDetector(
      onTap: () => setState(() => _selectedPreference = preference),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isHighlight
              ? const Color(0xFFFFF9F2)
              : (isSelected ? const Color(0xFFF2F8F5) : AppColors.white),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isHighlight
                ? const Color(0xFFFFD8B3)
                : (isSelected ? AppColors.primary : const Color(0xFFE5E7EB)),
            width: isSelected || isHighlight ? 1.2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Custom Radio Circle
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    isSelected ? const Color(0xFFB5DFCC) : Colors.transparent,
                border: Border.all(
                  color:
                      isSelected ? AppColors.primary : const Color(0xFFD1D5DB),
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.5.sp,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  if (hasSparkle) ...[
                    SizedBox(width: 6.w),
                    const Icon(
                      Icons.auto_awesome,
                      color: Color(0xFFE88B46),
                      size: 15,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
