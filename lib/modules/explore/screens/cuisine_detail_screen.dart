import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';

// cuisine detail screen
// explores curated cultural culinary traditions, highlighted ingredients, and recipes
class CuisineDetailScreen extends StatelessWidget {
  const CuisineDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> recipes = [
      {
        'title': 'Turkish Shakshuka (Menemen)',
        'time': '20m',
        'kcal': '340 kcal',
        'image':
            'https://images.unsplash.com/photo-1590412200988-a436970781fa?w=400&q=80',
      },
      {
        'title': 'Red Lentil Soup (Mercimek)',
        'time': '30m',
        'kcal': '280 kcal',
        'image':
            'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=400&q=80',
      },
      {
        'title': 'Grilled Chicken Shish Bowl',
        'time': '25m',
        'kcal': '510 kcal',
        'image':
            'https://images.unsplash.com/photo-1529006557810-274b9b2fc783?w=400&q=80',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: CustomScrollView(
        slivers: [
          // hero image app bar
          SliverAppBar(
            expandedHeight: 240.h,
            pinned: true,
            backgroundColor: AppColors.bg,
            leading: CircleAvatar(
              backgroundColor: AppColors.white.withValues(alpha: 0.85),
              child: IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                onPressed: Get.back,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl:
                    'https://images.unsplash.com/photo-1529006557810-274b9b2fc783?w=800&q=80',
                fit: BoxFit.cover,
                memCacheWidth: 800,
                placeholder: (_, __) => Container(color: AppColors.shimmerBase),
                errorWidget: (_, __, ___) =>
                    Container(color: AppColors.shimmerBase),
              ),
            ),
          ),

          // content body
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.screenH.w,
                vertical: AppSpacing.md.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Turkish Cuisine',
                      style: AppTextStyles.headlineLarge,),
                  SizedBox(height: AppSpacing.xs.h),
                  Text(
                    'Rich in olive oil, fresh herbs, flame-roasted vegetables, and slow-simmered savory legumes.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: AppSpacing.lg.h),

                  // hallmark ingredients
                  const Text('Hallmark Flavors',
                      style: AppTextStyles.titleMedium,),
                  SizedBox(height: AppSpacing.xs.h),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      'Sumac',
                      'Aleppo Pepper',
                      'Yogurt',
                      'Eggplant',
                      'Fresh Mint',
                      'Garlic',
                    ].map((final String flavor) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cardBgSecondary,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Text(flavor, style: AppTextStyles.labelSmall),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: AppSpacing.sectionGap.h),

                  // popular recipes list
                  const Text('Featured Dishes',
                      style: AppTextStyles.headlineSmall,),
                  SizedBox(height: AppSpacing.md.h),

                  ...recipes.map((final item) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.recipeDetails,
                          arguments: {
                            'name': item['title']!,
                            'time': item['time']!,
                            'kcal': item['kcal']!,
                            'tag': 'Turkish',
                            'image': item['image']!,
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(AppSpacing.cardPadding),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                              child: CachedNetworkImage(
                                imageUrl: item['image']!,
                                width: 72.w,
                                height: 72.w,
                                memCacheWidth: 144,
                                fit: BoxFit.cover,
                                placeholder: (_, __) =>
                                    Container(color: AppColors.shimmerBase),
                                errorWidget: (_, __, ___) =>
                                    Container(color: AppColors.shimmerBase),
                              ),
                            ),
                            SizedBox(width: AppSpacing.md.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title']!,
                                    style: AppTextStyles.titleSmall,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.timer_outlined,
                                        size: 13,
                                        color: AppColors.textSecondary,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        item['time']!,
                                        style: AppTextStyles.bodySmall,
                                      ),
                                      const SizedBox(width: 10),
                                      const Icon(
                                        Icons.local_fire_department_outlined,
                                        size: 13,
                                        color: AppColors.textSecondary,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        item['kcal']!,
                                        style: AppTextStyles.bodySmall,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: AppColors.textTertiary,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

                  SizedBox(height: AppSpacing.xl.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
