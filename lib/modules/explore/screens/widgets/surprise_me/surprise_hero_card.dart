import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';

// hero recipe card on surprise me screen
class SurpriseHeroCard extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const SurpriseHeroCard({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppRadius.lg),
            ),
            child: CachedNetworkImage(
              imageUrl: recipe['image'] as String? ?? '',
              height: 240.h,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                color: AppColors.shimmerBase,
              ),
              errorWidget: (_, __, ___) => Container(
                color: AppColors.shimmerBase,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.cardPaddingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe['title'] as String? ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      recipe['time'] as String? ?? '',
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.local_fire_department_outlined,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      recipe['kcal'] as String? ?? '',
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.check_circle_outline,
                      size: 16,
                      color: Color(0xFF2E634F),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      recipe['match'] as String? ?? '',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: const Color(0xFF2E634F),
                        fontWeight: FontWeight.bold,
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
