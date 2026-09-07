import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import '../controllers/explore_controller.dart';
import 'widgets/explore_landing/explore_cuisine_card.dart';
import 'widgets/explore_landing/explore_fresh_item_card.dart';
import 'widgets/explore_landing/explore_recipe_card.dart';

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
              centerTitle: true,
              backgroundColor: AppColors.bg,
              floating: true,
              snap: true,
              elevation: 0,
              scrolledUnderElevation: 0,
              leading: const Padding(
                padding: EdgeInsets.only(left: 16),
                child:
                    Icon(Icons.restaurant_menu, color: AppColors.textPrimary),
              ),
              title: Text(
                'Mealist.ai',
                style: AppTextStyles.logoMark.copyWith(fontSize: 22),
              ),
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
                            onSubmitted: (String value) {
                              Get.toNamed(
                                AppRoutes.searchResults,
                                arguments: {'query': value},
                              );
                            },
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
                          onPressed: () {
                            Get.toNamed(
                              AppRoutes.searchResults,
                              arguments: {
                                'query':
                                    'High-protein chicken under 30 minutes',
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: AppSpacing.xs.h),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.searchResults,
                        arguments: {
                          'query': 'High-protein chicken under 30 minutes',
                        },
                      );
                    },
                    child: Text(
                      'Try: "High-protein chicken under 30 minutes"',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
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
                        backgroundColor: const Color(0xFFE87042),
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
                        onPressed: () => Get.toNamed(AppRoutes.exploreForYou),
                        child: Text(
                          'See all',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: const Color(0xFF3B6E59),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.sm.h),
                  SizedBox(
                    height: 290.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.madeForYou.length,
                      itemBuilder: (_, int index) {
                        final Map<String, String> recipe =
                            controller.madeForYou[index];
                        return ExploreRecipeCard(recipe: recipe);
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
                        onPressed: () => Get.toNamed(
                          AppRoutes.cuisineDetail,
                          arguments: {'cuisine': 'Turkish'},
                        ),
                        child: Text(
                          'View all cuisines',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: const Color(0xFF3B6E59),
                            fontWeight: FontWeight.w700,
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
                      return ExploreCuisineCard(cuisine: cuisine);
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
                    (Map<String, String> item) =>
                        ExploreFreshItemCard(item: item),
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
