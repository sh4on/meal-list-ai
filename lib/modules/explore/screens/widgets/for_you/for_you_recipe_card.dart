import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../routes/app_routes.dart';

// recommended recipe card for "recommended for you" section on for you screen
class ForYouRecipeCard extends StatefulWidget {
  final Map<String, dynamic> recipe;

  const ForYouRecipeCard({
    super.key,
    required this.recipe,
  });

  @override
  State<ForYouRecipeCard> createState() => _ForYouRecipeCardState();
}

class _ForYouRecipeCardState extends State<ForYouRecipeCard> {
  bool _dismissed = false;

  @override
  Widget build(BuildContext context) {
    if (_dismissed) return const SizedBox.shrink();

    final Map<String, dynamic> recipe = widget.recipe;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // recipe image with match badge (bottom-left) and X close (top-right)
          Stack(
            children: [
              GestureDetector(
                onTap: () => Get.toNamed(
                  AppRoutes.recipeDetails,
                  arguments: {
                    'name': recipe['title'] ?? '',
                    'time': recipe['time'] ?? '',
                    'kcal': recipe['kcal'] ?? '',
                    'image': recipe['image'] ?? '',
                  },
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppRadius.md),
                    topRight: Radius.circular(AppRadius.md),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: recipe['image'] as String? ?? '',
                    width: double.infinity,
                    height: 185.h,
                    memCacheWidth: 600,
                    memCacheHeight: 370,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      color: AppColors.shimmerBase,
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: AppColors.shimmerBase,
                    ),
                  ),
                ),
              ),
              // match badge — bottom-left
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.92),
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
                      const Icon(
                        Icons.favorite_border,
                        color: AppColors.accent,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        recipe['match'] as String? ?? '90% Match',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2D5F4F),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // X close button — top-right
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _dismissed = true;
                    });
                  },
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // details container
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
                GestureDetector(
                  onTap: () => Get.toNamed(
                    AppRoutes.recipeDetails,
                    arguments: {
                      'name': recipe['title'] ?? '',
                      'time': recipe['time'] ?? '',
                      'kcal': recipe['kcal'] ?? '',
                      'image': recipe['image'] ?? '',
                    },
                  ),
                  child: Text(
                    recipe['title'] as String? ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      height: 1.3,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                // sparkle description line
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(AppSpacing.sm),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 1),
                        child: Icon(
                          Icons.auto_awesome,
                          size: 13,
                          color: Color(0xFFD97706),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.4,
                            ),
                            children: [
                              TextSpan(
                                text: recipe['highlight'] as String? ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                              TextSpan(
                                text: recipe['description'] as String? ?? '',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // time / kcal / protein row
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
                      style: AppTextStyles.bodySmall,
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
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(width: 14),
                    const Icon(
                      Icons.fitness_center,
                      size: 13,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      recipe['protein'] as String? ?? '',
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.primary),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
