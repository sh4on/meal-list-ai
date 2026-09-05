import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import '../controllers/explore_controller.dart';

// explore screen — search, surprise me, made for you, cuisine grid, fresh this week
class ExploreScreen extends GetView<ExploreController> {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // top bar with utensils icon + logo + avatar
            SliverAppBar(
              backgroundColor: AppColors.bg,
              floating: true,
              snap: true,
              elevation: 0,
              scrolledUnderElevation: 0,
              leading: const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Icon(Icons.restaurant, color: AppColors.textPrimary),
              ),
              title: const Text('Mealist.ai', style: AppTextStyles.logoMark),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: AppSpacing.md.w),
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100&q=80',
                    ),
                  ),
                ),
              ],
            ),

            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: AppSpacing.md.h),

                  // section title
                  const Text('Explore', style: AppTextStyles.headlineLarge),
                  SizedBox(height: AppSpacing.xs.h),
                  Text(
                    "Find something you'll actually want to cook.",
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),

                  SizedBox(height: AppSpacing.lg.h),

                  // search bar
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: AppSpacing.md),
                        const Icon(
                          Icons.search,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: TextField(
                            onChanged: controller.updateSearch,
                            decoration: const InputDecoration(
                              hintText: 'What are you in the mood for?',
                              hintStyle: AppTextStyles.inputHint,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.mic_outlined,
                            color: AppColors.textTertiary,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: AppSpacing.xs.h),
                  Text(
                    'Try: "High-protein chicken under 30 minutes"',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                  SizedBox(height: AppSpacing.lg.h),

                  // surprise me button
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton.icon(
                      onPressed: () => Get.toNamed(AppRoutes.surpriseMe),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: AppColors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                      icon: const Icon(Icons.auto_awesome, size: 18),
                      label: Text(
                        'Surprise Me',
                        style: AppTextStyles.button.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: AppSpacing.sectionGap.h),

                  // made for you horizontal scroll
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Made For You',
                        style: AppTextStyles.headlineSmall,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'See all',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.sm.h),
                  SizedBox(
                    height: 280.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.madeForYou.length,
                      itemBuilder: (_, int index) {
                        final Map<String, String> recipe =
                            controller.madeForYou[index];
                        return _RecipeCard(recipe: recipe);
                      },
                    ),
                  ),

                  SizedBox(height: AppSpacing.sectionGap.h),

                  // browse cuisines grid
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Browse Cuisines',
                        style: AppTextStyles.headlineSmall,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'View all cuisines',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.sm.h),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.3,
                    ),
                    itemCount: controller.cuisines.length,
                    itemBuilder: (_, int index) {
                      final Map<String, String> cuisine =
                          controller.cuisines[index];
                      return _CuisineCard(cuisine: cuisine);
                    },
                  ),

                  SizedBox(height: AppSpacing.sectionGap.h),

                  // fresh this week
                  const Text(
                    'Fresh This Week',
                    style: AppTextStyles.headlineSmall,
                  ),
                  SizedBox(height: AppSpacing.sm.h),
                  ...controller.freshThisWeek.map(
                    (Map<String, String> item) => _FreshItemCard(item: item),
                  ),

                  SizedBox(height: AppSpacing.xxxl.h),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// horizontal recipe card for "made for you"
class _RecipeCard extends StatelessWidget {
  final Map<String, String> recipe;
  const _RecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240.w,
      margin: const EdgeInsets.only(right: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image with match badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppRadius.md),
                  topRight: Radius.circular(AppRadius.md),
                ),
                child: CachedNetworkImage(
                  imageUrl: recipe['image'] ?? '',
                  width: double.infinity,
                  height: 140.h,
                  memCacheWidth: 480,
                  memCacheHeight: 280,
                  fit: BoxFit.cover,
                  placeholder: (_, __) =>
                      Container(color: AppColors.shimmerBase),
                  errorWidget: (_, __, ___) =>
                      Container(color: AppColors.shimmerBase),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.92),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    recipe['match'] ?? '',
                    style: AppTextStyles.labelMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe['name'] ?? '',
                  style: AppTextStyles.titleSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.timer_outlined,
                      size: 12,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 2),
                    Text(recipe['time'] ?? '', style: AppTextStyles.bodySmall),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.local_fire_department_outlined,
                      size: 12,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 2),
                    Text(recipe['kcal'] ?? '', style: AppTextStyles.bodySmall),
                  ],
                ),
                const SizedBox(height: 6),
                // AI tag chip
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accentSurface,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    border: Border.all(
                      color: AppColors.accent.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.auto_awesome,
                        size: 10,
                        color: AppColors.accent,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          recipe['tag'] ?? '',
                          style: AppTextStyles.labelSmall
                              .copyWith(color: AppColors.textPrimary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// cuisine grid card with image background and label
class _CuisineCard extends StatelessWidget {
  final Map<String, String> cuisine;
  const _CuisineCard({required this.cuisine});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.cuisineDetail),
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
              placeholder: (_, __) => Container(color: AppColors.shimmerBase),
              errorWidget: (_, __, ___) =>
                  Container(color: AppColors.shimmerBase),
            ),
            // dark gradient overlay
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xCC000000)],
                ),
              ),
            ),
            Positioned(
              bottom: AppSpacing.md,
              left: AppSpacing.md,
              child: Text(
                cuisine['name'] ?? '',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// fresh this week list item card
class _FreshItemCard extends StatelessWidget {
  final Map<String, String> item;
  const _FreshItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
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
              imageUrl: item['image'] ?? '',
              width: AppSpacing.mealThumb.w,
              height: AppSpacing.mealThumb.w,
              memCacheWidth: 144,
              memCacheHeight: 144,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: AppColors.shimmerBase),
              errorWidget: (_, __, ___) =>
                  Container(color: AppColors.shimmerBase),
            ),
          ),
          SizedBox(width: AppSpacing.md.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['title'] ?? '', style: AppTextStyles.titleSmall),
                const SizedBox(height: 4),
                Text(
                  item['subtitle'] ?? '',
                  style: AppTextStyles.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
