import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';

// "for you" ai recommendation card — golden border accent from figma
class ForYouCardWidget extends StatelessWidget {
  const ForYouCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // section header with sparkle icon
        const Row(
          children: [
            Icon(
              Icons.auto_awesome,
              color: AppColors.accent,
              size: AppSpacing.iconSm,
            ),
            SizedBox(width: AppSpacing.xs),
            Text('For You', style: AppTextStyles.headlineSmall),
          ],
        ),

        SizedBox(height: AppSpacing.md.h),

        // recommendation card with accent border
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.accent, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // recipe image with match badge overlay
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppRadius.md),
                      topRight: Radius.circular(AppRadius.md),
                    ),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://images.unsplash.com/photo-1529006557810-274b9b2fc783?w=800&q=80',
                      width: double.infinity,
                      height: 180.h,
                      memCacheWidth: 800,
                      memCacheHeight: 360,
                      fit: BoxFit.cover,
                      placeholder: (_, __) =>
                          Container(color: AppColors.shimmerBase),
                      errorWidget: (_, __, ___) =>
                          Container(color: AppColors.shimmerBase),
                    ),
                  ),

                  // 94% match badge
                  Positioned(
                    top: AppSpacing.sm,
                    left: AppSpacing.sm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.auto_awesome,
                            size: 12,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '94% match',
                            style: AppTextStyles.labelMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // recipe info below image
              Padding(
                padding: const EdgeInsets.all(AppSpacing.cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'High-Protein Chicken\nShawarma Bowl',
                      style: AppTextStyles.headlineSmall,
                    ),
                    SizedBox(height: AppSpacing.xs.h),
                    Text(
                      'Matches your high-protein goal and uses ingredients already in your pantry.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: AppSpacing.md.h),
                    // show suggestions outline button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.border),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                          ),
                        ),
                        child: Text(
                          'Show suggestions',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
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
    );
  }
}
