import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import 'widgets/for_you/for_you_faster_meal_card.dart';
import 'widgets/for_you/for_you_nudge_banner.dart';
import 'widgets/for_you/for_you_recipe_card.dart';
import 'widgets/for_you/for_you_use_it_up_card.dart';

// for you screen
// displays personalized daily recommendations, expiring pantry highlights, and quick meals
class ForYouScreen extends StatefulWidget {
  const ForYouScreen({super.key});

  @override
  State<ForYouScreen> createState() => _ForYouScreenState();
}

class _ForYouScreenState extends State<ForYouScreen> {
  bool _showNudge = true;

  final List<Map<String, dynamic>> _recommendedRecipes = const [
    {
      'title': 'Grilled Chicken & Quinoa Power Bowl',
      'match': '94% Match',
      'time': '25m',
      'kcal': '400 kcal',
      'protein': '42g Protein',
      'highlight': 'High protein',
      'description':
          ' · fits your 30-minute preference · similar to recipes you\'ve liked.',
      'image':
          'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=800&q=80',
    },
    {
      'title': 'Honey Soy Glazed Salmon',
      'match': '89% Match',
      'time': '20m',
      'kcal': '360 kcal',
      'protein': '34g Protein',
      'highlight': 'Omega-3 boost',
      'description': ' · low carb · perfect for a light dinner.',
      'image':
          'https://images.unsplash.com/photo-1485921325833-c519f76c4927?w=800&q=80',
    },
  ];

  final List<Map<String, String>> _useItUpItems = const [
    {
      'title': 'Creamy Spinach & Mushroom Pasta',
      'uses': 'Uses your remaining spinach and mushrooms.',
      'boldWords': 'spinach,mushrooms',
      'image':
          'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?w=400&q=80',
    },
    {
      'title': 'Classic Vegetable Frittata',
      'uses': 'Uses your remaining eggs and bell peppers.',
      'boldWords': 'eggs,bell peppers',
      'image':
          'https://images.unsplash.com/photo-1506084868230-bb9d95c24759?w=400&q=80',
    },
  ];

  final List<Map<String, dynamic>> _fasterMeals = const [
    {
      'title': 'Poached Egg Avocado Toast',
      'bullets': [
        'Ready in 10 mins',
        'Matches your breakfast routine.',
      ],
      'image':
          'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?w=400&q=80',
    },
    {
      'title': 'Matcha Green Smoothie Bowl',
      'bullets': [
        'Ready in 5 mins',
        'High antioxidant boost.',
      ],
      'image':
          'https://images.unsplash.com/photo-1511690656952-34342bb7c2f2?w=400&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: Get.back,
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Made For You',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            Text(
              'Recipes picked around your tastes, goals and habits.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w400,
                height: 1.3,
              ),
            ),
          ],
        ),
        titleSpacing: 0,
        toolbarHeight: 64,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.screenH.w,
          vertical: AppSpacing.sm.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // today's nudge banner
            if (_showNudge) ...[
              ForYouNudgeBanner(
                onDismiss: () {
                  setState(() {
                    _showNudge = false;
                  });
                },
              ),
              SizedBox(height: AppSpacing.lg.h),
            ],

            // recommended for you section header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Recommended for you',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'Based on your goals',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.sm.h),

            // recommended recipe cards
            ..._recommendedRecipes.map(
              (Map<String, dynamic> recipe) => ForYouRecipeCard(recipe: recipe),
            ),

            SizedBox(height: AppSpacing.md.h),

            // "Use it up" section header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Use it up',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'View Pantry',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.sm.h),
            SizedBox(
              height: 195.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _useItUpItems.length,
                itemBuilder: (_, int index) =>
                    ForYouUseItUpCard(item: _useItUpItems[index]),
              ),
            ),

            SizedBox(height: AppSpacing.sectionGap.h),

            // faster meals section
            const Text(
              'Faster meals',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: AppSpacing.sm.h),
            ..._fasterMeals.map(
              (Map<String, dynamic> meal) => ForYouFasterMealCard(item: meal),
            ),

            SizedBox(height: AppSpacing.xxxl.h),
          ],
        ),
      ),
    );
  }
}
