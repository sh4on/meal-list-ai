import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../routes/app_routes.dart';

// cuisine grid card with image background and label
class ExploreCuisineCard extends StatelessWidget {
  final Map<String, String> cuisine;

  const ExploreCuisineCard({
    super.key,
    required this.cuisine,
  });

  @override
  Widget build(BuildContext context) {
    final String cuisineName = cuisine['name'] ?? 'Turkish';

    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.cuisineDetail,
        arguments: {'cuisine': cuisineName},
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: cuisine['image'] ?? '',
              fit: BoxFit.cover,
              memCacheWidth: 400,
              memCacheHeight: 300,
              placeholder: (_, __) => Container(
                color: AppColors.shimmerBase,
              ),
              errorWidget: (_, __, ___) => Container(
                color: AppColors.shimmerBase,
              ),
            ),
            // dark gradient overlay
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Color(0xCC000000),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: AppSpacing.md,
              left: AppSpacing.md,
              child: Text(
                cuisineName,
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
