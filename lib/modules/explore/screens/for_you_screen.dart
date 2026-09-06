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
      'title': 'Crispy Skin Salmon Bowl',
      'match': '94% match',
      'time': '25 MIN',
      'kcal': '520 KCAL',
      'protein': '42g',
      'carbs': '38g',
      'fat': '14g',
      'fiber': '6g',
      'image':
          'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=800&q=80',
    },
    {
      'title': 'Mediterranean Lentil & Chicken Salad',
      'match': '91% match',
      'time': '20 MIN',
      'kcal': '460 KCAL',
      'protein': '38g',
      'carbs': '42g',
      'fat': '12g',
      'fiber': '9g',
      'image':
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80',
    },
  ];

  final List<Map<String, String>> _useItUpItems = const [
    {
      'title': 'Greek Yogurt Dip',
      'ingredient': 'Greek yogurt',
      'expiry': 'Expires in 2 days',
      'image':
          'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=400&q=80',
    },
    {
      'title': 'Spinach & Egg Scramble',
      'ingredient': 'Baby spinach',
      'expiry': 'Expires tomorrow',
      'image':
          'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=400&q=80',
    },
  ];

  final List<Map<String, String>> _fasterMeals = const [
    {
      'title': '10-Minute Garlic Shrimp',
      'time': '10 MIN',
      'kcal': '320 KCAL',
      'image':
          'https://images.unsplash.com/photo-1559742811-822873691df8?w=400&q=80',
    },
    {
      'title': 'Pan-Seared Lemon Tofu',
      'time': '15 MIN',
      'kcal': '280 KCAL',
      'image':
          'https://images.unsplash.com/photo-1546069901-d5bfd2cbfb1f?w=400&q=80',
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
        title: const Text(
          'For you',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.screenH.w,
          vertical: AppSpacing.sm.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // breadcrumbs / top label
            Text(
              'Explore > For you',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: AppSpacing.xs.h),
            const Text(
              'Personalized For You',
              style: AppTextStyles.headlineLarge,
            ),
            SizedBox(height: AppSpacing.md.h),

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

            // recommended for you section
            const Text(
              'Recommended For You',
              style: AppTextStyles.headlineSmall,
            ),
            SizedBox(height: AppSpacing.xs.h),
            Text(
              'Tailored to your macro goals and flavor preferences.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: AppSpacing.sm.h),
            ..._recommendedRecipes.map(
              (Map<String, dynamic> recipe) =>
                  ForYouRecipeCard(recipe: recipe),
            ),

            SizedBox(height: AppSpacing.md.h),

            // "Use it up" horizontal list
            const Text('Use It Up', style: AppTextStyles.headlineSmall),
            SizedBox(height: AppSpacing.xs.h),
            Text(
              'Recipes that prioritize ingredients expiring soon in your pantry.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: AppSpacing.sm.h),
            SizedBox(
              height: 200.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _useItUpItems.length,
                itemBuilder: (_, int index) =>
                    ForYouUseItUpCard(item: _useItUpItems[index]),
              ),
            ),

            SizedBox(height: AppSpacing.sectionGap.h),

            // faster meals section
            const Text('Faster Meals', style: AppTextStyles.headlineSmall),
            SizedBox(height: AppSpacing.xs.h),
            Text(
              'Delicious, balanced meals ready in 15 minutes or less.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: AppSpacing.sm.h),
            ..._fasterMeals.map(
              (Map<String, String> meal) => ForYouFasterMealCard(item: meal),
            ),

            SizedBox(height: AppSpacing.xxxl.h),
          ],
        ),
      ),
    );
  }
}
