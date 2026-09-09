import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import 'widgets/replace_meal/replace_meal_app_bar.dart';
import 'widgets/replace_meal/replace_meal_filter_chips.dart';
import 'widgets/replace_meal/replace_meal_recipe_card.dart';

class ReplaceMealScreen extends StatefulWidget {
  final String title;

  const ReplaceMealScreen({
    super.key,
    this.title = 'Replace Monday Lunch',
  });

  @override
  State<ReplaceMealScreen> createState() => _ReplaceMealScreenState();
}

class _ReplaceMealScreenState extends State<ReplaceMealScreen> {
  String _selectedFilter = 'All';

  final List<ReplaceMealRecipeItem> _recipes = const [
    ReplaceMealRecipeItem(
      id: 'rep_1',
      name: 'Turkish Lentil Chicken Bowl',
      rating: 4.9,
      pantryMatch: 92,
      prepMinutes: 25,
      calories: 520,
      description:
          'A quick and nutritious bowl with fresh greens, savory glaze, and protein-packed lentils.',
      imageUrl:
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80',
    ),
    ReplaceMealRecipeItem(
      id: 'rep_2',
      name: 'Classic Chicken Teriyaki Bowl',
      rating: 4.7,
      pantryMatch: 85,
      prepMinutes: 30,
      calories: 610,
      description:
          'Tender chicken in a sweet and savory homemade teriyaki sauce over steamed rice and crisp broccoli.',
      imageUrl:
          'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=800&q=80',
    ),
  ];

  void _onRecipeSelect(ReplaceMealRecipeItem recipe) {
    Get.back(result: recipe.name);
    Get.snackbar(
      'Meal Replaced',
      'Updated to ${recipe.name}',
      backgroundColor: AppColors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = Get.arguments is Map && Get.arguments['slot'] != null
        ? 'Replace ${Get.arguments['slot']}'
        : widget.title;

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: ReplaceMealAppBar(
        title: title,
        onFilterTap: () {},
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 12.h),

            // Horizontal Filter Chips
            ReplaceMealFilterChips(
              selectedFilter: _selectedFilter,
              onSelected: (filter) {
                setState(() {
                  _selectedFilter = filter;
                });
              },
            ),

            SizedBox(height: 16.h),

            // Vertical List of Recipes
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                itemCount: _recipes.length,
                separatorBuilder: (_, __) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final item = _recipes[index];
                  return ReplaceMealRecipeCard(
                    item: item,
                    onTap: () => _onRecipeSelect(item),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
