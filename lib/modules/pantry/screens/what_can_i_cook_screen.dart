import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mealist_ai/modules/pantry/screens/widgets/active_badge.dart';
import 'package:mealist_ai/modules/pantry/screens/widgets/filter_tab.dart';
import 'package:mealist_ai/modules/pantry/screens/widgets/member_card.dart';
import 'package:mealist_ai/modules/pantry/screens/widgets/recipe_card.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';

// what can i cook screen
// suggests recipes based on available pantry ingredients with household safety filters
class WhatCanICookScreen extends StatefulWidget {
  const WhatCanICookScreen({super.key});

  @override
  State<WhatCanICookScreen> createState() => _WhatCanICookScreenState();
}

class _WhatCanICookScreenState extends State<WhatCanICookScreen> {
  int _selectedFilterIndex = 0;

  // household members data
  final List<Map<String, dynamic>> _members = [
    {
      'initials': 'JD',
      'name': 'Jane',
      'tag': 'Gluten-Free',
      'portion': '1.0x Portion',
      'color': const Color(0xFFD6EAE3),
      'textColor': AppColors.primary,
    },
    {
      'initials': 'AX',
      'name': 'Alex',
      'tag': 'No Shellfish',
      'portion': '1.25x Portion',
      'color': const Color(0xFFD6EAE3),
      'textColor': AppColors.primary,
    },
    {
      'initials': 'LO',
      'name': 'Leo (Kid)',
      'tag': 'Nut Allergy',
      'portion': '0.5x • Mild',
      'color': const Color(0xFFD6EAE3),
      'textColor': AppColors.primary,
    },
  ];

  // recipe list data
  final List<Map<String, dynamic>> _recipes = [
    {
      'title': 'Mediterranean Lemon Herb Chicken & Quinoa',
      'time': '25 mins',
      'servings': '3 Servings (2.75x)',
      'kcal': '520 kcal',
      'image':
          'https://images.unsplash.com/photo-1598515214211-89d3c73ae83b?w=800&q=80',
      'stockBadge': '100% IN STOCK',
      'dietBadge': 'NUT & GLUTEN FREE',
      'matchNote':
          'Jane (Gluten-Free quinoa base) • Alex (Shellfish-free poultry) • Leo (Mild lemon herb marinade, zero tree nuts).',
      'filter': 0,
      'isFav': false,
    },
    {
      'title': 'Skillet Menemen with Gluten-Free Seed Toast',
      'time': '15 mins',
      'servings': '3 Servings (Scaled)',
      'kcal': '460 kcal',
      'image':
          'https://images.unsplash.com/photo-1565958011703-44f9829ba187?w=800&q=80',
      'stockBadge': 'MISSING 1 ITEM (FETA)',
      'dietBadge': 'SAFE FOR ALL 3',
      'safetyNote':
          'Naturally gluten-free eggs and stewed tomatoes. Peppers kept sweet & non-spicy for child preference.',
      'filter': 1,
      'isFav': false,
    },
    {
      'title': 'Golden Turkish Red Lentil & Lemon Soup',
      'time': '20 mins',
      'servings': '3 Servings (Scaled)',
      'kcal': '390 kcal',
      'image':
          'https://images.unsplash.com/photo-1547592180-85f173990554?w=800&q=80',
      'stockBadge': '100% IN STOCK',
      'dietBadge': 'KID FAVORITE',
      'safetyNote':
          'Smooth creamy puree loved by Leo, zero dairy/nuts/gluten, red pepper butter served on the side for Alex.',
      'filter': 0,
      'isFav': false,
    },
  ];

  List<Map<String, dynamic>> get _filteredRecipes {
    if (_selectedFilterIndex == 0) return _recipes;
    if (_selectedFilterIndex == 1) {
      return _recipes.where((r) => r['filter'] == 1).toList();
    }
    // < 30 min — show all in demo
    return _recipes;
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: Get.back,
        ),
        title: Text(
          'What Can I Cook',
          style: AppTextStyles.headlineSmall.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.tune_rounded,
              color: AppColors.textPrimary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSpacing.md.h),

            // ── Who is eating tonight? ──────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Who is eating tonight?',
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                ActiveBadge(count: _members.length),
              ],
            ),
            SizedBox(height: 2.h),
            Text(
              'Portions adapt & allergen filters apply automatically',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),

            SizedBox(height: AppSpacing.md.h),

            // member cards row
            Row(
              children: _members.asMap().entries.map((final e) {
                final Map<String, dynamic> m = e.value;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: e.key < _members.length - 1 ? 8.w : 0,
                    ),
                    child: MemberCard(member: m),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: AppSpacing.md.h),

            // scaled batch banner
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md.w,
                vertical: AppSpacing.sm.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.people_outline,
                    size: 18,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: AppSpacing.xs.w),
                  Expanded(
                    child: Text(
                      'Scaled Batch: 2.75x Standard',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person_add_outlined,
                          size: 16,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '+ Guest',
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.md.h),

            // family safety shield card
            Container(
              padding: EdgeInsets.all(AppSpacing.md.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.25),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD6EAE3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.checkmark_shield_fill,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: AppSpacing.sm.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Family Safety Shield Active',
                              style: AppTextStyles.titleSmall.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            const Icon(
                              Icons.auto_awesome,
                              size: 14,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        RichText(
                          text: TextSpan(
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.5,
                            ),
                            children: const [
                              TextSpan(
                                text: 'All suggestions are ',
                              ),
                              TextSpan(
                                text: '100% free of Gluten, Shellfish, and Peanuts',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '. Spice level calibrated to Mild for Leo.',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.xl.h),

            // ── Pantry Matches ──────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pantry Matches',
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    '4 Ready Now',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSpacing.md.h),

            // filter chip tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterTab(
                    label: '100% In-Stock (4)',
                    icon: Icons.check_circle_outline,
                    isSelected: _selectedFilterIndex == 0,
                    onTap: () => setState(() => _selectedFilterIndex = 0),
                    isFirst: true,
                  ),
                  const SizedBox(width: 8),
                  FilterTab(
                    label: 'Missing 1-2 items',
                    icon: Icons.radio_button_unchecked,
                    isSelected: _selectedFilterIndex == 1,
                    onTap: () => setState(() => _selectedFilterIndex = 1),
                  ),
                  const SizedBox(width: 8),
                  FilterTab(
                    label: '< 30 Min',
                    icon: Icons.access_time_outlined,
                    isSelected: _selectedFilterIndex == 2,
                    onTap: () => setState(() => _selectedFilterIndex = 2),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.md.h),

            // recipe cards
            ..._filteredRecipes.asMap().entries.map((final entry) {
              final Map<String, dynamic> recipe = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: AppSpacing.md.h),
                child: RecipeCard(
                  recipe: recipe,
                  onFavToggle: () {
                    setState(() {
                      _recipes[_recipes.indexOf(recipe)]['isFav'] =
                          !(_recipes[_recipes.indexOf(recipe)]['isFav']
                              as bool);
                    });
                  },
                ),
              );
            }),

            SizedBox(height: AppSpacing.xl.h),
          ],
        ),
      ),
    );
  }
}












