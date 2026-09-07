import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import 'widgets/add_to_meal_plan_bottom_sheet.dart';
import 'widgets/cuisine_detail/cuisine_recipe_card.dart';

// cuisine detail screen (e.g., Turkish cuisine)
// includes hero image, personalized pill, filter chips, and recipe cards
class CuisineDetailScreen extends StatefulWidget {
  const CuisineDetailScreen({super.key});

  @override
  State<CuisineDetailScreen> createState() => _CuisineDetailScreenState();
}

class _CuisineDetailScreenState extends State<CuisineDetailScreen> {
  String _selectedFilter = 'Traditional';

  final List<String> _filters = const [
    'Traditional',
    'Quick',
    'Vegetarian',
    'High Protein',
  ];

  // per-cuisine recipe data keyed by cuisine name
  static const Map<String, List<Map<String, dynamic>>> _cuisineRecipes = {
    'Turkish': [
      {
        'title': 'Ezogelin (Turkish Lentil Soup)',
        'match': '94% MATCH',
        'time': '20 min',
        'kcal': '320 kcal',
        'insight': 'You like Turkish food · high-fiber goal met',
        'image':
            'https://images.unsplash.com/photo-1476718406336-bb5a9690ee2a?w=800&q=80',
      },
      {
        'title': 'Imam Bayildi (Stuffed Eggplant)',
        'match': '88% MATCH',
        'time': '45 min',
        'kcal': '280 kcal',
        'insight': 'Matches vegetarian preference · olive oil rich',
        'image':
            'https://images.unsplash.com/photo-1529006557810-274b9b2fc783?w=800&q=80',
      },
    ],
    'Italian': [
      {
        'title': 'Cacio e Pepe',
        'match': '91% MATCH',
        'time': '20 min',
        'kcal': '450 kcal',
        'insight': 'Matches pasta preference · quick to make',
        'image':
            'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?w=800&q=80',
      },
      {
        'title': 'Margherita Pizza',
        'match': '85% MATCH',
        'time': '35 min',
        'kcal': '520 kcal',
        'insight': 'Classic Italian · vegetarian friendly',
        'image':
            'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800&q=80',
      },
    ],
  };

  static const Map<String, String> _cuisineImages = {
    'Turkish':
        'https://images.unsplash.com/photo-1574484284002-952d92456975?w=800&q=80',
    'Italian':
        'https://images.unsplash.com/photo-1498579150354-977475b7ea0b?w=800&q=80',
    'Japanese':
        'https://images.unsplash.com/photo-1553621042-f6e147245754?w=800&q=80',
    'Mexican':
        'https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?w=800&q=80',
    'Indian':
        'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800&q=80',
  };

  List<Map<String, dynamic>> get _recipes {
    final String name = Get.arguments?['cuisine'] as String? ?? 'Turkish';
    return _cuisineRecipes[name] ??
        _cuisineRecipes['Turkish']!;
  }

  String get _cuisineName =>
      Get.arguments?['cuisine'] as String? ?? 'Turkish';

  String get _heroImage =>
      _cuisineImages[_cuisineName] ??
      'https://images.unsplash.com/photo-1574484284002-952d92456975?w=800&q=80';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: Get.back,
        ),
        title: Text(
          _cuisineName,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // hero image — full width, no rounded corners
            CachedNetworkImage(
              imageUrl: _heroImage,
              width: double.infinity,
              height: 200.h,
              fit: BoxFit.cover,
              memCacheWidth: 800,
              placeholder: (_, __) =>
                  Container(color: AppColors.shimmerBase, height: 200.h),
              errorWidget: (_, __, ___) =>
                  Container(color: AppColors.shimmerBase, height: 200.h),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.screenH.w,
                vertical: AppSpacing.md.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // cuisine name in green
                  Text(
                    _cuisineName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // subtitle
                  Text(
                    'Explore $_cuisineName recipes matched to your preferences.',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // "Personalized for you" outlined pill chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.bg,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          size: 13,
                          color: AppColors.accent,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Personalized for you',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // filter chips row
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _filters.map((String f) {
                        final bool isSelected = _selectedFilter == f;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _selectedFilter = f),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.white,
                                borderRadius:
                                    BorderRadius.circular(AppRadius.pill),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.border,
                                ),
                              ),
                              child: Text(
                                f,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? AppColors.white
                                      : AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // recipe cards
                  ..._recipes.map(
                    (Map<String, dynamic> recipe) =>
                        CuisineRecipeCard(recipe: recipe),
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),

      // sticky "Add to Meal Plan" bottom button
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.screenH.w,
            10,
            AppSpacing.screenH.w,
            12,
          ),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_recipes.isNotEmpty) {
                  AddToMealPlanBottomSheet.show(
                    context,
                    name: _recipes.first['title'] as String?,
                    image: _recipes.first['image'] as String?,
                    time: _recipes.first['time'] as String?,
                  );
                }
              },
              icon: const Icon(Icons.add, size: 20),
              label: const Text(
                'Add to Meal Plan',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
