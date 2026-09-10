import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';
import 'recipe_options_bottom_sheet.dart';

// vertical recipe card matching the Figma design
// shows a full-bleed image, ⋮ options menu, heart favourite button, and meta row
class RecipeCardWidget extends StatelessWidget {
  final Map<String, dynamic> recipe;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const RecipeCardWidget({
    super.key,
    required this.recipe,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isFavorite = recipe['isFavorite'] as bool? ?? false;
    final int cookedCount = recipe['cookedCount'] as int? ?? 0;
    final int kcal = recipe['kcal'] as int? ?? 0;
    final int protein = recipe['protein'] as int? ?? 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image section with overlaid buttons
            Stack(
              children: [
                // full-bleed recipe photo
                CachedNetworkImage(
                  imageUrl: recipe['image'] as String? ?? '',
                  height: AppSpacing.recipeCardImage.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  memCacheWidth: 800,
                  memCacheHeight: 360,
                  placeholder: (_, __) =>
                      Container(color: AppColors.shimmerBase),
                  errorWidget: (_, __, ___) => Container(
                    color: AppColors.shimmerBase,
                    child: const Icon(
                      Icons.restaurant,
                      color: AppColors.textTertiary,
                      size: 40,
                    ),
                  ),
                ),

                // top-left ⋮ options button
                Positioned(
                  top: AppSpacing.sm.h,
                  left: AppSpacing.sm.w,
                  child: GestureDetector(
                    onTap: () => RecipeOptionsBottomSheet.show(
                      context,
                      recipeName: recipe['name'] as String? ?? '',
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.more_vert,
                        size: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),

                // top-right heart favourite button
                Positioned(
                  top: AppSpacing.sm.h,
                  right: AppSpacing.sm.w,
                  child: GestureDetector(
                    onTap: onFavoriteTap,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isFavorite ? AppColors.primary : AppColors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        size: 16,
                        color: isFavorite
                            ? AppColors.white
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // text section below the image
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.cardPadding.w,
                vertical: AppSpacing.sm.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title and calorie count on the same row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          recipe['name'] as String? ?? '',
                          style: AppTextStyles.titleLarge,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: AppSpacing.xs.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '$kcal',
                            style: AppTextStyles.titleMedium.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Text(
                            'kcal',
                            style: AppTextStyles.labelSmall,
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: AppSpacing.xs.h),

                  // meta row: time, protein, cooked count
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule_outlined,
                        size: AppSpacing.iconXs,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        recipe['time'] as String? ?? '',
                        style: AppTextStyles.bodySmall,
                      ),
                      SizedBox(width: AppSpacing.sm.w),
                      const Icon(
                        Icons.fitness_center,
                        size: AppSpacing.iconXs,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${protein}g Protein',
                        style: AppTextStyles.bodySmall,
                      ),
                      const Spacer(),
                      // cooked count badge on right
                      if (cookedCount > 0)
                        Row(
                          children: [
                            const Icon(
                              Icons.restaurant_menu_outlined,
                              size: AppSpacing.iconXs,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              'Cooked ${cookedCount}x',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                    ],
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
