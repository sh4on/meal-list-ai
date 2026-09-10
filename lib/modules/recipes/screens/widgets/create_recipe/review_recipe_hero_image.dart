import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';

// hero image card at the top of recipe review
// displays the finished dish photograph with rounded corners matching figma
class ReviewRecipeHeroImage extends StatelessWidget {
  final String imageUrl;

  const ReviewRecipeHeroImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    // clipping with large radius to match rounded card treatment across the app
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Container(
        width: double.infinity,
        height: 210.h,
        color: AppColors.cardBgSecondary,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          // memory cache bounds optimize ram usage for list/detail renders
          memCacheWidth: 800,
          memCacheHeight: 600,
          placeholder: (final context, final url) => const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            ),
          ),
          errorWidget: (final context, final url, final error) => const Center(
            child: Icon(
              Icons.restaurant_rounded,
              size: 40,
              color: AppColors.textTertiary,
            ),
          ),
        ),
      ),
    );
  }
}
