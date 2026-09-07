import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../routes/app_routes.dart';

// horizontal recipe card for "made for you" section on explore landing
class ExploreRecipeCard extends StatelessWidget {
  final Map<String, String> recipe;

  const ExploreRecipeCard({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.recipeDetails,
        arguments: {
          'name': recipe['name'] ?? '',
          'time': recipe['time'] ?? '',
          'kcal': recipe['kcal'] ?? '',
          'image': recipe['image'] ?? '',
        },
      ),
      child: Container(
        width: 240.w,
        margin: const EdgeInsets.only(right: AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image with match badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppRadius.md),
                    topRight: Radius.circular(AppRadius.md),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: recipe['image'] ?? '',
                    width: double.infinity,
                    height: 140.h,
                    memCacheWidth: 480,
                    memCacheHeight: 280,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      color: AppColors.shimmerBase,
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: AppColors.shimmerBase,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      recipe['match'] ?? '',
                      style: AppTextStyles.labelMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2E7D32),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe['name'] ?? '',
                    style: AppTextStyles.titleSmall.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        size: 12,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        recipe['time'] ?? '',
                        style: AppTextStyles.bodySmall,
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.local_fire_department_outlined,
                        size: 12,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        recipe['kcal'] ?? '',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // AI tag chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      border: Border.all(
                        color: AppColors.accent,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.auto_awesome,
                          size: 11,
                          color: AppColors.accent,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            recipe['tag'] ?? '',
                            style: AppTextStyles.labelSmall.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.textSecondary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
