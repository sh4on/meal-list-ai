import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../routes/app_routes.dart';

// cuisine recipe card matching screenshot:
// full image, heart+match badge top-right, title, time/kcal, salmon insight row
class CuisineRecipeCard extends StatefulWidget {
  final Map<String, dynamic> recipe;

  const CuisineRecipeCard({
    super.key,
    required this.recipe,
  });

  @override
  State<CuisineRecipeCard> createState() => _CuisineRecipeCardState();
}

class _CuisineRecipeCardState extends State<CuisineRecipeCard> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> recipe = widget.recipe;

    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.recipeDetails,
        arguments: {
          'name': recipe['title'] ?? '',
          'time': recipe['time'] ?? '30 min',
          'kcal': recipe['kcal'] ?? '400 kcal',
          'image': recipe['image'] ?? '',
        },
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image with heart + match badge overlay (top-right)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppRadius.lg),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: recipe['image'] as String? ?? '',
                    height: 185.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    memCacheWidth: 700,
                    placeholder: (_, __) => Container(
                      color: AppColors.shimmerBase,
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: AppColors.shimmerBase,
                    ),
                  ),
                ),
                // heart icon + match badge — top-right
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => _isLiked = !_isLiked),
                          child: Icon(
                            _isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 14,
                            color: _isLiked
                                ? Colors.red
                                : AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          recipe['match'] as String? ?? '90% MATCH',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // card content
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Text(
                    recipe['title'] as String? ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // time + kcal row
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 13,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        recipe['time'] as String? ?? '',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Icon(
                        Icons.local_fire_department_outlined,
                        size: 13,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        recipe['kcal'] as String? ?? '',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // salmon/peach insight row
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDF0EC),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.auto_awesome,
                          size: 13,
                          color: Color(0xFFD97706),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            recipe['insight'] as String? ?? '',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textPrimary,
                              height: 1.3,
                            ),
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

