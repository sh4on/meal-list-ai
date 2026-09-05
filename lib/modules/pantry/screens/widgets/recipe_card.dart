import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../routes/app_routes.dart';
import 'image_badge.dart';
import 'meta_chip.dart';

// full recipe card
class RecipeCard extends StatelessWidget {
  final Map<String, dynamic> recipe;
  final VoidCallback onFavToggle;

  const RecipeCard({super.key,
    required this.recipe,
    required this.onFavToggle,
  });

  @override
  Widget build(final BuildContext context) {
    final String title = recipe['title'] as String;
    final String time = recipe['time'] as String;
    final String servings = recipe['servings'] as String;
    final String kcal = recipe['kcal'] as String;
    final String imageUrl = recipe['image'] as String;
    final String stockBadge = recipe['stockBadge'] as String;
    final String dietBadge = recipe['dietBadge'] as String;
    final String? matchNote = recipe['matchNote'] as String?;
    final String? safetyNote = recipe['safetyNote'] as String?;
    final bool isMissing = stockBadge.contains('MISSING');
    final bool isFav = recipe['isFav'] as bool;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image with badges overlaid
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl,
                height: 190.h,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                    Container(height: 190.h, color: AppColors.shimmerBase),
                errorWidget: (_, __, ___) =>
                    Container(height: 190.h, color: AppColors.shimmerBase),
              ),

              // top badges row
              Positioned(
                top: 12,
                left: 12,
                child: Row(
                  children: [
                    ImageBadge(
                      label: stockBadge,
                      isDark: !isMissing,
                      isWarning: isMissing,
                    ),
                    const SizedBox(width: 6),
                    ImageBadge(label: dietBadge, isDark: false),
                  ],
                ),
              ),

              // heart button
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: onFavToggle,
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      size: 18,
                      color: isFav ? AppColors.error : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // card body
          Padding(
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(
                  title,
                  style: AppTextStyles.titleLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 8.h),

                // meta row: time, servings, kcal
                Row(
                  children: [
                    MetaChip(
                      icon: Icons.access_time_outlined,
                      label: time,
                    ),
                    SizedBox(width: AppSpacing.md.w),
                    MetaChip(
                      icon: Icons.restaurant_outlined,
                      label: servings,
                    ),
                    SizedBox(width: AppSpacing.md.w),
                    MetaChip(
                      icon: Icons.local_fire_department_outlined,
                      label: kcal,
                    ),
                  ],
                ),

                SizedBox(height: 10.h),

                // match note or household safety note
                if (matchNote != null) ...[
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.cardBgSecondary,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          size: 14,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Matched for all 3 members:',
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                matchNote,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                ],

                if (safetyNote != null) ...[
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.cardBgSecondary,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.shield_outlined,
                          size: 14,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Household Safety Notes:',
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                safetyNote,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                ],

                // action buttons: Cook Now + Plan
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: AppSpacing.buttonHeight,
                        child: ElevatedButton.icon(
                          onPressed: () =>
                              Get.toNamed(AppRoutes.cookMode),
                          icon: const Icon(Icons.outdoor_grill_outlined,
                              size: 18),
                          label: const Text('Cook Now'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                            elevation: 0,
                            textStyle: AppTextStyles.button.copyWith(
                              fontSize: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(AppRadius.md),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: AppSpacing.xs.w),
                    SizedBox(
                      height: AppSpacing.buttonHeight,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.calendar_month_outlined,
                          size: 16,
                        ),
                        label: const Text('Plan'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textPrimary,
                          side: const BorderSide(color: AppColors.border),
                          textStyle: AppTextStyles.buttonSecondary.copyWith(
                            fontSize: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                        ),
                      ),
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