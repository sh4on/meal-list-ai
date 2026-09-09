import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../routes/app_routes.dart';

// horizontal card highlighting expiring pantry ingredients
class ForYouUseItUpCard extends StatelessWidget {
  final Map<String, String> item;

  const ForYouUseItUpCard({
    super.key,
    required this.item,
  });

  // build rich text for "Uses your remaining spinach and mushrooms." with bold words
  Widget _buildUsesText(String uses, String? boldWordsRaw) {
    if (boldWordsRaw == null || boldWordsRaw.isEmpty) {
      return Text(
        uses,
        style: const TextStyle(
          fontSize: 11,
          color: AppColors.textSecondary,
          height: 1.4,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
    }
    final List<String> boldWords =
        boldWordsRaw.split(',').map((s) => s.trim()).toList();
    final List<InlineSpan> spans = [];
    String remaining = uses;

    while (remaining.isNotEmpty) {
      int earliestIndex = remaining.length;
      String? matchedWord;

      for (final String word in boldWords) {
        final int idx = remaining.indexOf(word);
        if (idx != -1 && idx < earliestIndex) {
          earliestIndex = idx;
          matchedWord = word;
        }
      }

      if (matchedWord == null) {
        spans.add(TextSpan(text: remaining));
        break;
      }

      if (earliestIndex > 0) {
        spans.add(TextSpan(text: remaining.substring(0, earliestIndex)));
      }
      spans.add(
        TextSpan(
          text: matchedWord,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      );
      remaining = remaining.substring(earliestIndex + matchedWord.length);
    }

    return RichText(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: const TextStyle(
          fontSize: 11,
          color: AppColors.textSecondary,
          height: 1.4,
        ),
        children: spans,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.recipeDetails,
        arguments: {
          'name': item['title'] ?? '',
          'time': '20 MIN',
          'kcal': '380 KCAL',
          'image': item['image'] ?? '',
        },
      ),
      child: Container(
        width: 165.w,
        margin: const EdgeInsets.only(right: AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppRadius.md),
                topRight: Radius.circular(AppRadius.md),
              ),
              child: CachedNetworkImage(
                imageUrl: item['image'] ?? '',
                width: double.infinity,
                height: 110.h,
                memCacheWidth: 330,
                memCacheHeight: 220,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  color: AppColors.shimmerBase,
                ),
                errorWidget: (_, __, ___) => Container(
                  color: AppColors.shimmerBase,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    _buildUsesText(
                      item['uses'] ?? '',
                      item['boldWords'],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
