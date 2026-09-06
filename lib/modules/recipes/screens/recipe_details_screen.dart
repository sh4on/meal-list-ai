import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../explore/screens/widgets/add_to_meal_plan_bottom_sheet.dart';
import 'widgets/recipe_details/recipe_ingredient_row.dart';
import 'widgets/recipe_details/recipe_pantry_check_item.dart';
import 'widgets/recipe_details/recipe_step_card.dart';
import 'widgets/recipe_details/recipe_stepper_button.dart';

// recipe details screen
// provides detailed culinary steps, pantry ingredient match, allergen verification, and macro breakdown
class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({super.key});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  int _servings = 2;
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    // extract arguments passed during navigation or provide sensible defaults
    final dynamic args = Get.arguments;
    final Map<String, dynamic> recipe = (args is Map<String, dynamic>)
        ? args
        : (args is Map<String, String>)
            ? Map<String, dynamic>.from(args)
            : {
                'name': 'Mediterranean Chicken',
                'time': '25 MIN',
                'kcal': '520 KCAL',
                'tag': 'High Protein',
                'image':
                    'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80',
              };

    final String recipeName =
        (recipe['name'] as String?) ?? 'Mediterranean Chicken';
    final String recipeTime = (recipe['time'] as String?) ?? '25 MIN';
    final String recipeKcal = (recipe['kcal'] as String?) ?? '520 KCAL';
    final String recipeImage = (recipe['image'] as String?) ??
        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80';

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: CustomScrollView(
        slivers: [
          // hero image sliver app bar
          SliverAppBar(
            expandedHeight: 280.h,
            pinned: true,
            backgroundColor: AppColors.bg,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: AppColors.white.withValues(alpha: 0.9),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.textPrimary,
                    size: 20,
                  ),
                  onPressed: Get.back,
                ),
              ),
            ),
            actions: [
              CircleAvatar(
                backgroundColor: AppColors.white.withValues(alpha: 0.9),
                child: IconButton(
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorite ? Colors.red : AppColors.textPrimary,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _isFavorite = !_isFavorite;
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: AppColors.white.withValues(alpha: 0.9),
                child: IconButton(
                  icon: const Icon(
                    Icons.share_outlined,
                    color: AppColors.textPrimary,
                    size: 20,
                  ),
                  onPressed: () {
                    Get.snackbar(
                      'Share Recipe',
                      'Link to $recipeName copied to clipboard.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.white,
                      colorText: AppColors.textPrimary,
                    );
                  },
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: recipeImage,
                fit: BoxFit.cover,
                memCacheWidth: 800,
                placeholder: (_, __) => Container(color: AppColors.shimmerBase),
                errorWidget: (_, __, ___) => Container(
                  color: AppColors.shimmerBase,
                  child: const Icon(Icons.restaurant, size: 48),
                ),
              ),
            ),
          ),

          // recipe body content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.screenH.w,
                vertical: AppSpacing.md.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // recipe title
                  Text(
                    recipeName,
                    style: AppTextStyles.headlineMedium.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  SizedBox(height: 6.h),

                  // metrics row: 25 MIN • 520 KCAL • 2 SERVINGS
                  Row(
                    children: [
                      Text(
                        recipeTime.toUpperCase().replaceAll('MINUTES', 'MIN'),
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const Text(
                        ' • ',
                        style: TextStyle(
                          color: AppColors.textTertiary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        recipeKcal.toUpperCase(),
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const Text(
                        ' • ',
                        style: TextStyle(
                          color: AppColors.textTertiary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$_servings SERVINGS',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: AppSpacing.md.h),

                  // servings stepper row
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Servings',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Row(
                          children: [
                            RecipeStepperButton(
                              icon: Icons.remove,
                              onTap: () {
                                if (_servings > 1) {
                                  setState(() => _servings--);
                                }
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              child: Text(
                                '$_servings',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            RecipeStepperButton(
                              icon: Icons.add,
                              onTap: () {
                                setState(() => _servings++);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: AppSpacing.md.h),

                  // "In your pantry" checklist box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.kitchen_outlined,
                              size: 20,
                              color: Color(0xFF3B6E59),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'In your pantry',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const RecipePantryCheckItem(
                          text: 'Chicken breast (500g)',
                          inPantry: true,
                        ),
                        const SizedBox(height: 8),
                        const RecipePantryCheckItem(
                          text: 'Olive oil',
                          inPantry: true,
                        ),
                        const SizedBox(height: 8),
                        const RecipePantryCheckItem(
                          text: 'Missing: Lemon (1 medium)',
                          inPantry: false,
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            Get.snackbar(
                              'Shopping List',
                              'Added Lemon (1 medium) to your shopping list.',
                              backgroundColor: AppColors.white,
                              colorText: AppColors.textPrimary,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          },
                          child: const Row(
                            children: [
                              Text(
                                'Add missing to list',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF3B6E59),
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward,
                                size: 14,
                                color: Color(0xFF3B6E59),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: AppSpacing.md.h),

                  // "Allergen check: Nothing flagged" callout container
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBF5ED),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(color: const Color(0xFFB7DFC6)),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 20,
                          color: Color(0xFF2E7D32),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Allergen check: Nothing flagged for your profile (dairy-free, nut-free)',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1B5E20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: AppSpacing.lg.h),

                  // ingredients section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Ingredients',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '$_servings servings',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.sm.h),
                  RecipeIngredientRow(
                    name: 'Chicken breast',
                    amount: '${250 * _servings}g',
                  ),
                  RecipeIngredientRow(
                    name: 'Extra virgin olive oil',
                    amount: '${1 * _servings} tbsp',
                  ),
                  RecipeIngredientRow(
                    name: 'Fresh lemon juice',
                    amount: '${1 * _servings} tbsp',
                  ),
                  RecipeIngredientRow(
                    name: 'Garlic cloves, minced',
                    amount: '${1 * _servings} cloves',
                  ),
                  RecipeIngredientRow(
                    name: 'Dried oregano',
                    amount: '${(0.5 * _servings).toStringAsFixed(1)} tsp',
                  ),
                  const RecipeIngredientRow(
                    name: 'Sea salt & cracked black pepper',
                    amount: 'To taste',
                  ),

                  SizedBox(height: AppSpacing.lg.h),

                  // preparation steps section
                  const Text(
                    'Preparation Steps',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppSpacing.sm.h),
                  const RecipeStepCard(
                    stepNumber: 1,
                    text:
                        'Pat the chicken breasts thoroughly dry with paper towels. Season both sides generously with sea salt, black pepper, and dried oregano.',
                  ),
                  const RecipeStepCard(
                    stepNumber: 2,
                    text:
                        'Heat extra virgin olive oil in a heavy skillet over medium-high heat until shimmering. Add minced garlic and sauté for 30 seconds until fragrant.',
                  ),
                  const RecipeStepCard(
                    stepNumber: 3,
                    text:
                        'Place seasoned chicken in the skillet. Sear undisturbed for 6-8 minutes until golden brown, flip, and cook an additional 6 minutes until cooked through (165°F / 74°C).',
                  ),
                  const RecipeStepCard(
                    stepNumber: 4,
                    text:
                        'Remove from heat, drizzle freshly squeezed lemon juice over the top, and allow to rest for 3-5 minutes before slicing.',
                  ),

                  SizedBox(height: AppSpacing.xl.h),
                ],
              ),
            ),
          ),
        ],
      ),

      // sticky bottom actions
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.screenH.w,
          12,
          AppSpacing.screenH.w,
          MediaQuery.of(context).padding.bottom + 12,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(
            top: BorderSide(color: AppColors.border.withValues(alpha: 0.6)),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  AddToMealPlanBottomSheet.show(
                    context,
                    name: recipeName,
                    image: recipeImage,
                    time: recipeTime,
                  );
                },
                icon: const Icon(Icons.add, color: AppColors.white, size: 20),
                label: const Text(
                  '+ Add to Meal Plan',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B6E59),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Get.snackbar(
                        'Mealist Assistant',
                        'Tip: You can swap lemon for white wine vinegar if needed!',
                        backgroundColor: AppColors.white,
                        colorText: AppColors.textPrimary,
                        snackPosition: SnackPosition.TOP,
                        icon: const Icon(
                          Icons.auto_awesome,
                          color: Color(0xFF3B6E59),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.auto_awesome,
                      size: 16,
                      color: Color(0xFF3B6E59),
                    ),
                    label: const Text(
                      'Ask Mealist',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3B6E59),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF3B6E59)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Get.snackbar(
                        'Cook Mode',
                        'Starting step-by-step guided cook mode.',
                        backgroundColor: AppColors.white,
                        colorText: AppColors.textPrimary,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    icon: const Icon(
                      Icons.play_arrow_rounded,
                      size: 18,
                      color: Color(0xFF3B6E59),
                    ),
                    label: const Text(
                      'Start Cooking',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3B6E59),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF3B6E59)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
