import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../routes/app_routes.dart';

// meal card widget
// displays scheduled meal slot with direct access to full details and hands-free cook mode
class MealCardWidget extends StatelessWidget {
  final Map<String, dynamic> meal;

  const MealCardWidget({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    final bool isCooked = meal['isCooked'] as bool? ?? false;
    final String mealType = meal['type'] as String? ?? '';
    final String time = meal['time'] as String? ?? '';
    final String name = meal['name'] as String? ?? '';
    final int calories = meal['calories'] as int? ?? 0;
    final String? protein = meal['protein'] as String?;
    final String? imageUrl = meal['image'] as String?;

    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.recipeDetails,
          arguments: {
            'name': name,
            'time': time,
            'kcal': '$calories kcal',
            'tag': mealType,
            'image': imageUrl ?? '',
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.itemGap),
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            // meal thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.sm),
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: AppSpacing.mealThumb.w,
                      height: AppSpacing.mealThumb.w,
                      memCacheWidth: 144,
                      memCacheHeight: 144,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        color: AppColors.shimmerBase,
                      ),
                      errorWidget: (_, __, ___) => Container(
                        color: AppColors.shimmerBase,
                        child: const Icon(
                          Icons.restaurant,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    )
                  : Container(
                      width: AppSpacing.mealThumb.w,
                      height: AppSpacing.mealThumb.w,
                      color: AppColors.shimmerBase,
                    ),
            ),

            SizedBox(width: AppSpacing.md.w),

            // meal info column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // meal type + time + cooked badge row
                  Row(
                    children: [
                      Text(
                        '$mealType • $time',
                        style: AppTextStyles.mealMeta,
                      ),
                      const Spacer(),
                      if (isCooked) ...[
                        const SizedBox(width: AppSpacing.xs),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.successSurface,
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.check,
                                size: 10,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                'Cooked',
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(name, style: AppTextStyles.titleSmall),
                  const SizedBox(height: AppRadius.sm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Icon(
                      //   Icons.local_fire_department_outlined,
                      //   size: AppSpacing.iconXs,
                      //   color: AppColors.textSecondary,
                      // ),
                      // const SizedBox(width: 2),
                      Text(
                        '$calories kcal',
                        style: AppTextStyles.bodySmall,
                      ),
                      if (protein != null) ...[
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          'Protein $protein',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // cook button — launches guided cook mode
            if (!isCooked) ...[
              SizedBox(width: AppSpacing.xs.w),
              ElevatedButton(
                onPressed: () => Get.toNamed(AppRoutes.cookMode),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Cook', style: TextStyle(fontSize: 13)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
