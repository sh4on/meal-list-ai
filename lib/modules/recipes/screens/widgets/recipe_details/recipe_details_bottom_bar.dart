import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../routes/app_routes.dart';

class RecipeDetailsBottomBar extends StatelessWidget {
  final String recipeName;
  final String recipeTime;
  final String recipeImage;

  const RecipeDetailsBottomBar({
    super.key,
    required this.recipeName,
    required this.recipeTime,
    required this.recipeImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16.w,
        12.h,
        16.w,
        MediaQuery.of(context).padding.bottom > 0
            ? MediaQuery.of(context).padding.bottom
            : 16.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.border.withValues(alpha: 0.6),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Ask Mealist Button
          Expanded(
            child: SizedBox(
              height: 48.h,
              child: OutlinedButton.icon(
                onPressed: () {
                  Get.toNamed(
                    AppRoutes.askMealist,
                    arguments: {
                      'recipe': recipeName,
                      'context': 'meal_details',
                    },
                  );
                },
                icon: const Icon(
                  Icons.auto_awesome,
                  color: AppColors.primary,
                  size: 18,
                ),
                label: Text(
                  'Ask Mealist',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color(0xFFD4DDD7),
                    width: 1.2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Start Cooking Button
          Expanded(
            child: SizedBox(
              height: 48.h,
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.toNamed(
                    AppRoutes.cookMode,
                    arguments: {
                      'recipe': recipeName,
                      'time': recipeTime,
                      'image': recipeImage,
                    },
                  );
                },
                icon: const Icon(
                  Icons.play_arrow_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
                label: Text(
                  'Start Cooking',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC3E8D8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
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
