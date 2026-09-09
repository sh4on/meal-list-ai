// storage compartment container grouping ingredients
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../item_details_screen.dart';

class PantrySectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Map<String, dynamic>> items;

  const PantrySectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // section title header
          Padding(
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            child: Row(
              children: [
                Icon(icon, color: AppColors.primary, size: 20),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  title,
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          // ingredient rows
          ...items.asMap().entries.map((final entry) {
            final Map<String, dynamic> item = entry.value;
            final bool isLast = entry.key == items.length - 1;
            final String? urgency = item['urgency'] as String?;
            final String? imageUrl = item['image'] as String?;

            return Column(
              children: [
                InkWell(
                  onTap: () => Get.to(
                    () => ItemDetailsScreen(item: item),
                    transition: Transition.rightToLeft,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.cardPadding),
                    child: Row(
                      children: [
                        // ingredient thumbnail
                        ClipRRect(
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                          child: imageUrl != null
                              ? CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  width: 44.w,
                                  height: 44.w,
                                  memCacheWidth: 88,
                                  memCacheHeight: 88,
                                  fit: BoxFit.cover,
                                  placeholder: (_, __) =>
                                      Container(color: AppColors.shimmerBase),
                                  errorWidget: (_, __, ___) => Container(
                                    color: AppColors.shimmerBase,
                                    child: const Icon(
                                      Icons.restaurant,
                                      size: 20,
                                      color: AppColors.textTertiary,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 44.w,
                                  height: 44.w,
                                  color: AppColors.cardBgSecondary,
                                  child: const Icon(
                                    Icons.grid_view_rounded,
                                    size: 20,
                                    color: AppColors.textTertiary,
                                  ),
                                ),
                        ),
                        SizedBox(width: AppSpacing.md.w),

                        // ingredient name and expiration badge
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'] as String,
                                style: AppTextStyles.titleSmall,
                              ),
                              if (urgency != null) ...[
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.errorSurface,
                                    borderRadius:
                                        BorderRadius.circular(AppRadius.xs),
                                  ),
                                  child: Text(
                                    urgency,
                                    style: AppTextStyles.labelSmall.copyWith(
                                      color: AppColors.error,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                        // quantity label
                        Text(
                          item['qty'] as String,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!isLast)
                  const Divider(
                    height: 1,
                    indent: AppSpacing.md,
                    endIndent: AppSpacing.md,
                    color: AppColors.divider,
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
