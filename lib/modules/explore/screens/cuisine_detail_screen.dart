import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import 'widgets/add_to_meal_plan_bottom_sheet.dart';
import 'widgets/cuisine_detail/cuisine_recipe_card.dart';

// cuisine detail screen (e.g., Turkish cuisine)
// includes hero image, tailored personalization insight, filter chips, and recipes
class CuisineDetailScreen extends StatefulWidget {
  const CuisineDetailScreen({super.key});

  @override
  State<CuisineDetailScreen> createState() => _CuisineDetailScreenState();
}

class _CuisineDetailScreenState extends State<CuisineDetailScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = const [
    'All',
    'Kebabs',
    'Soups',
    'Mezes',
    'Under 30 min',
  ];

  final List<Map<String, dynamic>> _recipes = const [
    {
      'title': 'Turkish Lentil Chicken Bowl',
      'match': '96% Match',
      'time': '30 min',
      'kcal': '520 kcal',
      'tag': 'High Protein',
      'image':
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80',
    },
    {
      'title': 'Spiced Lamb Köfte with Mint Salad',
      'match': '92% Match',
      'time': '25 min',
      'kcal': '580 kcal',
      'tag': 'Dairy-Free',
      'image':
          'https://images.unsplash.com/photo-1529006557810-274b9b2fc783?w=800&q=80',
    },
    {
      'title': 'Red Lentil Soup (Mercimek Çorbası)',
      'match': '88% Match',
      'time': '20 min',
      'kcal': '280 kcal',
      'tag': 'Vegan Friendly',
      'image':
          'https://images.unsplash.com/photo-1476718406336-bb5a9690ee2a?w=800&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: CustomScrollView(
        slivers: [
          // cuisine hero banner
          SliverAppBar(
            expandedHeight: 220.h,
            pinned: true,
            backgroundColor: AppColors.bg,
            leading: CircleAvatar(
              backgroundColor: AppColors.white.withValues(alpha: 0.85),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.textPrimary,
                ),
                onPressed: Get.back,
              ),
            ),
            actions: [
              CircleAvatar(
                backgroundColor: AppColors.white.withValues(alpha: 0.85),
                child: IconButton(
                  icon: const Icon(Icons.search, color: AppColors.textPrimary),
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl:
                    'https://images.unsplash.com/photo-1529006557810-274b9b2fc783?w=800&q=80',
                fit: BoxFit.cover,
                memCacheWidth: 800,
                placeholder: (_, __) => Container(color: AppColors.shimmerBase),
                errorWidget: (_, __, ___) =>
                    Container(color: AppColors.shimmerBase),
              ),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.all(AppSpacing.screenH.w),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // title & subtitle
                const Text(
                  'Turkish Cuisine',
                  style: AppTextStyles.headlineLarge,
                ),
                const SizedBox(height: 6),
                const Text(
                  'Rich spices, tender grilled meats, and comforting slow-simmered stews.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 12),

                // personalized insight banner
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3FAF6),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: const Color(0xFFD1EEDB)),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: Color(0xFF2E634F),
                        size: 18,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Personalized for you: Dairy-free modifications automatically highlighted.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF1E4637),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // category filter chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _categories.map((String cat) {
                      final bool isSelected = _selectedCategory == cat;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(cat),
                          selected: isSelected,
                          onSelected: (bool val) {
                            if (val) {
                              setState(() {
                                _selectedCategory = cat;
                              });
                            }
                          },
                          backgroundColor: AppColors.white,
                          selectedColor: const Color(0xFF3B6E59),
                          labelStyle: TextStyle(
                            color: isSelected
                                ? AppColors.white
                                : AppColors.textPrimary,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            fontSize: 13,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                            side: BorderSide(
                              color: isSelected
                                  ? const Color(0xFF3B6E59)
                                  : AppColors.border,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 16),

                // recipe items
                ..._recipes.map(
                  (Map<String, dynamic> recipe) =>
                      CuisineRecipeCard(recipe: recipe),
                ),

                SizedBox(height: 80.h),
              ]),
            ),
          ),
        ],
      ),

      // sticky bottom bar
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
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              AddToMealPlanBottomSheet.show(
                context,
                name: 'Turkish Lentil Chicken Bowl',
                image:
                    'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80',
                time: '30 min',
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B6E59),
              foregroundColor: AppColors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
            child: const Text(
              '+ Add to Meal Plan',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
