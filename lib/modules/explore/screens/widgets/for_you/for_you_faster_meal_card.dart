import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../routes/app_routes.dart';

// list item card for "faster meals" section
class ForYouFasterMealCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const ForYouFasterMealCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> bullets =
        (item['bullets'] as List<dynamic>?)?.cast<String>() ?? [];

    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.recipeDetails,
        arguments: {
          'name': item['title'] ?? '',
          'time': '10 MIN',
          'kcal': '360 KCAL',
          'image': item['image'] ?? '',
        },
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.sm),
              child: CachedNetworkImage(
                imageUrl: item['image'] as String? ?? '',
                width: 72,
                height: 72,
                memCacheWidth: 144,
                memCacheHeight: 144,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  color: AppColors.shimmerBase,
                ),
                errorWidget: (_, __, ___) => Container(
                  color: AppColors.shimmerBase,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] as String? ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 5),
                  ...bullets.map(
                    (String bullet) => Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 1),
                            child: Icon(
                              Icons.auto_awesome,
                              size: 11,
                              color: Color(0xFFD97706),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              bullet,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
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
