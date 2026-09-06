import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import 'widgets/add_to_meal_plan_bottom_sheet.dart';
import 'widgets/surprise_me/surprise_filter_chips.dart';
import 'widgets/surprise_me/surprise_hero_card.dart';
import 'widgets/surprise_me/surprise_why_picked_card.dart';

// surprise me screen
// presents a personalized single recipe pick with explainability and spinning options
class SurpriseMeScreen extends StatefulWidget {
  const SurpriseMeScreen({super.key});

  @override
  State<SurpriseMeScreen> createState() => _SurpriseMeScreenState();
}

class _SurpriseMeScreenState extends State<SurpriseMeScreen> {
  String _selectedFilter = 'Something new';

  final List<String> _filters = const [
    'Quick',
    'Use what I have',
    'Something new',
    'High Protein',
  ];

  int _currentIndex = 0;
  final List<Map<String, dynamic>> _recipes = const [
    {
      'title': 'Turkish Lentil Chicken Bowl',
      'time': '30 min',
      'kcal': '520 kcal',
      'match': '94% Match',
      'reason':
          'Matches your high-protein goal • you like Turkish food • 6 of 8 ingredients at home',
      'image':
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80',
    },
    {
      'title': 'Crispy Skin Salmon & Asparagus',
      'time': '25 min',
      'kcal': '460 kcal',
      'match': '96% Match',
      'reason':
          'Rich in Omega-3 • Fits your 30-minute preference • High protein',
      'image':
          'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=800&q=80',
    },
    {
      'title': 'Garlic Butter Herb Steak Bites',
      'time': '20 min',
      'kcal': '520 kcal',
      'match': '93% Match',
      'reason':
          'High protein • Quick dinner • Utilizes pantry rosemary and garlic',
      'image':
          'https://images.unsplash.com/photo-1544025162-d76694265947?w=800&q=80',
    },
  ];

  void _spin() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _recipes.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> recipe = _recipes[_currentIndex];

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColors.bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: Get.back,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Surprise Me',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Not sure what to cook? I'll choose one.",
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: AppSpacing.md.h),

            // filter chips
            SurpriseFilterChips(
              filters: _filters,
              selectedFilter: _selectedFilter,
              onSelected: (String filter) {
                setState(() {
                  _selectedFilter = filter;
                });
              },
            ),

            SizedBox(height: AppSpacing.md.h),

            // hero recipe card
            SurpriseHeroCard(recipe: recipe),

            SizedBox(height: AppSpacing.md.h),

            // why Mealist Picked It callout
            SurpriseWhyPickedCard(
              reason: (recipe['reason'] as String?) ?? '',
            ),

            SizedBox(height: AppSpacing.lg.h),

            // + Add This Meal button
            InkWell(
              onTap: () {
                AddToMealPlanBottomSheet.show(
                  context,
                  name: recipe['title'] as String?,
                  image: recipe['image'] as String?,
                  time: recipe['time'] as String?,
                );
              },
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B6E59),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: AppColors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Add This Meal',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // surprise Again button
            InkWell(
              onTap: _spin,
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.refresh, size: 18, color: Color(0xFF3B6E59)),
                    SizedBox(width: 8),
                    Text(
                      'Surprise Again',
                      style: TextStyle(
                        color: Color(0xFF3B6E59),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: AppSpacing.xxxl.h),
          ],
        ),
      ),
    );
  }
}
