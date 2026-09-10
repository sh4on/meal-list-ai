import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import '../controllers/recipes_controller.dart';
import 'widgets/my_recipes/recipe_card_widget.dart';
import 'widgets/my_recipes/recipe_filter_chips.dart';
import 'widgets/my_recipes/recipe_sort_row.dart';
import 'widgets/my_recipes/recipes_search_bar.dart';

// my recipes library screen
// composes extracted widgets to keep the screen file slim and readable
class MyRecipesScreen extends GetView<RecipesController> {
  const MyRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        scrolledUnderElevation: 0,
        // logo icon on left matching the Figma app bar
        leading: Padding(
          padding: EdgeInsets.only(left: AppSpacing.md.w),
          child: const Icon(
            Icons.restaurant_menu,
            color: AppColors.primary,
          ),
        ),
        title: const Text(
          'Mealist.ai',
          style: AppTextStyles.logoMark,
        ),
        centerTitle: true,
        actions: [
          // user avatar on the right
          Padding(
            padding: EdgeInsets.only(right: AppSpacing.md.w),
            child: CircleAvatar(
              radius: 18.r,
              backgroundColor: AppColors.border,
              backgroundImage: const NetworkImage(
                'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=100&q=80',
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSpacing.xs.h),

            // page title + subtitle block
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Recipes',
                          style: AppTextStyles.headlineLarge,
                        ),
                        Text(
                          'Your personal recipe library',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  // green + button to add a new recipe
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.addRecipe),
                    child: Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppColors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.md.h),

            // search input
            RecipesSearchBar(
              onChanged: (final String val) =>
                  controller.searchQuery.value = val,
            ),

            SizedBox(height: AppSpacing.sm.h),

            // horizontal category filter chips
            Obx(
              () => RecipeFilterChips(
                selectedCategory: controller.selectedCategory.value,
                onSelected: (final String cat) =>
                    controller.selectedCategory.value = cat,
              ),
            ),

            SizedBox(height: AppSpacing.md.h),

            // recipe count + sort button row
            Obx(
              () => RecipeSortRow(
                count: controller.filteredRecipes.length,
                sortBy: controller.sortBy.value,
                onSortChanged: (final String s) => controller.sortBy.value = s,
              ),
            ),

            SizedBox(height: AppSpacing.sm.h),

            // scrollable recipe card list
            Expanded(
              child: Obx(() {
                final List<Map<String, dynamic>> list =
                    controller.filteredRecipes;

                if (list.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.restaurant_outlined,
                          size: 48,
                          color: AppColors.textTertiary,
                        ),
                        SizedBox(height: AppSpacing.sm.h),
                        const Text(
                          'No recipes found',
                          style: AppTextStyles.titleMedium,
                        ),
                        const Text(
                          'Try a different search or category',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenH.w,
                    vertical: AppSpacing.xxs.h,
                  ),
                  itemCount: list.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: AppSpacing.md.h),
                  itemBuilder: (final BuildContext ctx, final int index) {
                    final Map<String, dynamic> item = list[index];
                    return RecipeCardWidget(
                      recipe: item,
                      onTap: () => Get.toNamed(
                        AppRoutes.recipeDetails,
                        arguments: item,
                      ),
                      // favourite toggle finds the item by name in master list
                      onFavoriteTap: () =>
                          controller.toggleFavoriteByName(
                        item['name'] as String,
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
