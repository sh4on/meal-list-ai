import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import 'widgets/recipe_details/recipe_allergen_banner.dart';
import 'widgets/recipe_details/recipe_details_bottom_bar.dart';
import 'widgets/recipe_details/recipe_ingredient_list.dart';
import 'widgets/recipe_details/recipe_instruction_list.dart';
import 'widgets/recipe_details/recipe_pantry_card.dart';
import 'widgets/recipe_details/recipe_servings_stepper.dart';

// recipe details screen — matches figma design exactly:
// hero image with rounded bottom corners, floating circle actions,
// title, uppercase metadata, servings, pantry card, allergen banner,
// sequential ingredients & instructions lists, and fixed 3-button bottom bar
class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({super.key});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    // recipe data passed via Get.arguments; falls back to Mediterranean Chicken matching design
    final Map<String, dynamic> recipe =
        Get.arguments is Map<String, dynamic>
            ? Get.arguments as Map<String, dynamic>
            : const <String, dynamic>{
                'name': 'Mediterranean Chicken',
                'time': '25 MIN',
                'kcal': 520,
                'servings': 2,
                'image':
                    'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=800&auto=format&fit=crop&q=80',
              };

    final String name = recipe['name'] as String? ?? 'Mediterranean Chicken';
    final String time = recipe['time'] as String? ?? '25 MIN';
    final int kcal = recipe['kcal'] as int? ?? 520;
    final int servings = recipe['servings'] as int? ?? 2;
    final String image = recipe['image'] as String? ??
        'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=800&auto=format&fit=crop&q=80';

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // main scrollable content
          CustomScrollView(
            slivers: [
              // app bar with rounded bottom hero image and floating circle buttons
              SliverAppBar(
                expandedHeight: 320.h,
                pinned: true,
                backgroundColor: AppColors.bg,
                elevation: 0,
                leading: _FloatingCircleButton(
                  icon: Icons.arrow_back,
                  onTap: Get.back,
                ),
                actions: [
                  // favorite heart button
                  _FloatingCircleButton(
                    icon: _isFavorite ? Icons.favorite : Icons.favorite_border,
                    iconColor: _isFavorite ? AppColors.error : AppColors.textPrimary,
                    onTap: () => setState(() => _isFavorite = !_isFavorite),
                  ),
                  // vertical 3-dots more options button
                  _FloatingCircleButton(
                    icon: Icons.more_vert,
                    onTap: () {},
                  ),
                  SizedBox(width: AppSpacing.xs.w),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(AppRadius.xxl),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      memCacheWidth: 800,
                      memCacheHeight: 600,
                      placeholder: (final context, final url) =>
                          Container(color: AppColors.cardBgSecondary),
                      errorWidget: (final context, final url, final error) =>
                          Container(color: AppColors.cardBgSecondary),
                    ),
                  ),
                ),
              ),

              // content body beneath the hero image
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenH.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppSpacing.md.h),

                      // recipe title matching figma
                      Text(
                        name,
                        style: AppTextStyles.headlineLarge.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppSpacing.xs.h),

                      // uppercase metadata row: time · kcal · servings
                      Row(
                        children: [
                          const Icon(
                            Icons.schedule_outlined,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            time.toUpperCase(),
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(width: 14.w),
                          const Icon(
                            Icons.local_fire_department_outlined,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '$kcal KCAL',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(width: 14.w),
                          const Icon(
                            Icons.restaurant_outlined,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '$servings SERVINGS',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSpacing.lg.h),

                      // servings stepper card
                      RecipeServingsStepper(initialServings: servings),
                      SizedBox(height: AppSpacing.sm.h),

                      // in your pantry peach card
                      const RecipePantryCard(),
                      SizedBox(height: AppSpacing.sm.h),

                      // allergen check green banner
                      const RecipeAllergenBanner(),
                      SizedBox(height: AppSpacing.lg.h),

                      // sequential ingredients list
                      const RecipeIngredientList(),
                      SizedBox(height: AppSpacing.lg.h),

                      // sequential instructions list
                      const RecipeInstructionList(),
                      // extra scroll padding for bottom action bar
                      SizedBox(height: 120.h),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // fixed bottom 3-button bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: RecipeDetailsBottomBar(
              recipeName: name,
              recipeTime: time,
              recipeImage: image,
            ),
          ),
        ],
      ),
    );
  }
}

// circular floating action button with shadow for the sliver app bar
class _FloatingCircleButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final VoidCallback onTap;

  const _FloatingCircleButton({
    required this.icon,
    this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 18,
            color: iconColor ?? AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
