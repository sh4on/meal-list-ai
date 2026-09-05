import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import '../controllers/recipes_controller.dart';

// my recipes library screen
// presents user's saved and generated recipes in a clean card list
class MyRecipesScreen extends GetView<RecipesController> {
  const MyRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // scaffold provides root visual structure conforming to app background styling
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        title: const Text(
          'My Recipes',
          style: AppTextStyles.headlineSmall,
        ),
        actions: [
          IconButton(
            icon:
                const Icon(Icons.bookmark_border, color: AppColors.textPrimary),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add, color: AppColors.textPrimary),
            onPressed: () => Get.toNamed(AppRoutes.addRecipe),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // search box section
            // placing search prominently allows quick filtering through collected recipes
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.screenH.w,
                vertical: AppSpacing.xs.h,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.border),
                ),
                child: TextField(
                  onChanged: (final String val) =>
                      controller.searchQuery.value = val,
                  style: AppTextStyles.inputText,
                  decoration: const InputDecoration(
                    hintText: 'Search saved recipes...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.textTertiary,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),

            SizedBox(height: AppSpacing.sm.h),

            // recipes list view
            // expands to fill available vertical space with smooth scrolling
            Expanded(
              child: Obx(() {
                final List<Map<String, String>> list = controller.recipes;
                if (list.isEmpty) {
                  return const Center(
                    child: Text(
                      'No recipes found',
                      style: AppTextStyles.bodyMedium,
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenH.w,
                    vertical: AppSpacing.xs.h,
                  ),
                  itemCount: list.length,
                  itemBuilder: (final BuildContext ctx, final int index) {
                    final Map<String, String> item = list[index];
                    return _RecipeListItem(
                      recipe: item,
                      onTap: () => Get.toNamed(
                        AppRoutes.recipeDetails,
                        arguments: item,
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// recipe card widget within the list
// displays visual thumbnail, title, tags, and calorie information
class _RecipeListItem extends StatelessWidget {
  final Map<String, String> recipe;
  final VoidCallback onTap;

  const _RecipeListItem({
    required this.recipe,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // inkwell enables subtle material ripple feedback on tap
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.md.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.md),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            child: Row(
              children: [
                // recipe thumbnail preview
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  child: CachedNetworkImage(
                    imageUrl: recipe['image'] ?? '',
                    width: 76.w,
                    height: 76.w,
                    memCacheWidth: 152,
                    memCacheHeight: 152,
                    fit: BoxFit.cover,
                    placeholder: (_, __) =>
                        Container(color: AppColors.shimmerBase),
                    errorWidget: (_, __, ___) => Container(
                      color: AppColors.shimmerBase,
                      child: const Icon(
                        Icons.restaurant,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: AppSpacing.md.w),

                // recipe details text layout
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // tag badge
                      if (recipe['tag'] != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primarySurface,
                            borderRadius: BorderRadius.circular(AppRadius.xs),
                          ),
                          child: Text(
                            recipe['tag']!,
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],

                      // recipe title
                      Text(
                        recipe['name'] ?? '',
                        style: AppTextStyles.titleSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 6),

                      // recipe timing and caloric meta
                      Row(
                        children: [
                          const Icon(
                            Icons.timer_outlined,
                            size: 13,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            recipe['time'] ?? '',
                            style: AppTextStyles.bodySmall,
                          ),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.local_fire_department_outlined,
                            size: 13,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            recipe['kcal'] ?? '',
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
        ),
      ),
    );
  }
}
