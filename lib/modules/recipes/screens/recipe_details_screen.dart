import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import 'widgets/recipe_details/recipe_details_bottom_bar.dart';
import 'widgets/recipe_details/recipe_macro_card.dart';
import 'widgets/recipe_details/recipe_planned_for_card.dart';
import 'widgets/recipe_details/recipe_why_picked_card.dart';

// Recipe Details Screen -- clean architecture using screen-specific widget classes
class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({super.key});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  int _servings = 2;
  bool _isFavorite = false;

  late List<Map<String, dynamic>> _ingredients;

  @override
  void initState() {
    super.initState();
    _ingredients = [
      {
        'name': 'Chicken breast',
        'qty': '200g',
        'image':
            'https://images.unsplash.com/photo-1604503468506-a8da13d82791?w=150&q=80',
        'checked': false,
      },
      {
        'name': 'Jasmine rice',
        'qty': '1 cup',
        'image':
            'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=150&q=80',
        'checked': false,
      },
      {
        'name': 'Avocado',
        'qty': '1',
        'icon': Icons.eco_outlined,
        'checked': false,
      },
      {
        'name': 'Soy sauce',
        'qty': '2 tbsp',
        'icon': Icons.water_drop_outlined,
        'checked': false,
      },
      {
        'name': 'Sesame seeds',
        'qty': '1 tsp',
        'icon': Icons.grain_outlined,
        'checked': false,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final dynamic args = Get.arguments;
    final Map<String, dynamic> recipe = (args is Map<String, dynamic>)
        ? args
        : (args is Map<String, String>)
            ? Map<String, dynamic>.from(args)
            : <String, dynamic>{};

    final String recipeName =
        (recipe['name'] as String?) ?? 'Chicken Rice Bowl';
    final String recipeTime = (recipe['time'] as String?) ?? '25 min';
    final String recipeKcal = (recipe['kcal'] as String?) ?? '520 kcal';
    final String plannedFor =
        (recipe['plannedFor'] as String?) ?? 'Monday Lunch';
    final String whyPicked = (recipe['whyPicked'] as String?) ??
        'Matches your high-protein goal for lunch while keeping prep time under 30 minutes.';
    final String recipeImage = (recipe['image'] as String?) ??
        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80';

    final String kcalVal = (recipe['kcalVal'] as String?) ??
        recipeKcal.replaceAll(RegExp(r'[^0-9]'), '');
    final String proteinVal = (recipe['protein'] as String?) ?? '42g';
    final String carbsVal = (recipe['carbs'] as String?) ?? '65g';
    final String fatVal = (recipe['fat'] as String?) ?? '18g';

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // ── Scrollable Body ───────────────────────────────────────────────
          CustomScrollView(
            slivers: [
              // Hero Image with floating buttons
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    SizedBox(
                      height: 380.h,
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: recipeImage,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(
                          color: AppColors.shimmerBase,
                        ),
                        errorWidget: (_, __, ___) => Container(
                          color: AppColors.shimmerBase,
                          child: const Icon(
                            Icons.restaurant,
                            color: AppColors.textTertiary,
                            size: 48,
                          ),
                        ),
                      ),
                    ),

                    // Top gradient overlay
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 120.h,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black45,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Floating Back Button
                    Positioned(
                      top: 48.h,
                      left: 16.w,
                      child: GestureDetector(
                        onTap: Get.back,
                        child: Container(
                          width: 38.w,
                          height: 38.w,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.28),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),

                    // Floating Favorite Heart Button
                    Positioned(
                      top: 48.h,
                      right: 16.w,
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _isFavorite = !_isFavorite);
                        },
                        child: Container(
                          width: 38.w,
                          height: 38.w,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.28),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: _isFavorite ? Colors.red : Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // White Content Card with Rounded Top
              SliverToBoxAdapter(
                child: Transform.translate(
                  offset: Offset(0, -26.h),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24.r),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 100.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Recipe Title
                        Text(
                          recipeName,
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),

                        // Metrics Row
                        Row(
                          children: [
                            const Icon(
                              Icons.schedule_outlined,
                              size: 15,
                              color: AppColors.textSecondary,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              recipeTime,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '  •  ',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.textTertiary,
                              ),
                            ),
                            const Icon(
                              Icons.local_fire_department_outlined,
                              size: 15,
                              color: AppColors.textSecondary,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              recipeKcal,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '  •  ',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.textTertiary,
                              ),
                            ),
                            const Icon(
                              Icons.restaurant_outlined,
                              size: 14,
                              color: AppColors.textSecondary,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '$_servings servings',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 18.h),

                        // Planned for Card
                        RecipePlannedForCard(plannedFor: plannedFor),

                        SizedBox(height: 14.h),

                        // WHY MEALIST PICKED THIS Banner
                        RecipeWhyPickedCard(whyPicked: whyPicked),

                        SizedBox(height: 22.h),

                        // Nutrition per serving
                        Text(
                          'Nutrition per serving',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            RecipeMacroCard(
                              value: kcalVal.isNotEmpty ? kcalVal : '520',
                              label: 'Kcal',
                            ),
                            SizedBox(width: 8.w),
                            RecipeMacroCard(
                              value: proteinVal,
                              label: 'Protein',
                            ),
                            SizedBox(width: 8.w),
                            RecipeMacroCard(
                              value: carbsVal,
                              label: 'Carbs',
                            ),
                            SizedBox(width: 8.w),
                            RecipeMacroCard(
                              value: fatVal,
                              label: 'Fat',
                            ),
                          ],
                        ),

                        SizedBox(height: 24.h),

                        // Ingredients Header & Servings Stepper
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ingredients',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFEFEF),
                                borderRadius:
                                    BorderRadius.circular(AppRadius.pill),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (_servings > 1) {
                                        setState(() => _servings--);
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                        vertical: 2.h,
                                      ),
                                      child: const Icon(
                                        Icons.remove,
                                        size: 14,
                                        color: Color(0xFF555555),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6.w),
                                    child: Text(
                                      '$_servings',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() => _servings++);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                        vertical: 2.h,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        size: 14,
                                        color: Color(0xFF555555),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10.h),

                        // Ingredients List
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _ingredients.length,
                          separatorBuilder: (_, __) => SizedBox(height: 10.h),
                          itemBuilder: (context, index) {
                            final item = _ingredients[index];
                            final bool checked = item['checked'] as bool;
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  item['checked'] = !checked;
                                });
                              },
                              borderRadius: BorderRadius.circular(8.r),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40.w,
                                      height: 40.w,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEFEFEF),
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: item['image'] != null
                                          ? CachedNetworkImage(
                                              imageUrl: item['image'] as String,
                                              fit: BoxFit.cover,
                                              placeholder: (_, __) => Container(
                                                color: const Color(0xFFE5E5E5),
                                              ),
                                              errorWidget: (_, __, ___) =>
                                                  const Icon(
                                                Icons.restaurant,
                                                size: 20,
                                                color: AppColors.textTertiary,
                                              ),
                                            )
                                          : Center(
                                              child: Icon(
                                                item['icon'] as IconData,
                                                size: 20,
                                                color: const Color(0xFF9E9E9E),
                                              ),
                                            ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Text(
                                        item['name'] as String,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      item['qty'] as String,
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Container(
                                      width: 20.w,
                                      height: 20.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: checked
                                            ? AppColors.primary
                                            : Colors.transparent,
                                        border: Border.all(
                                          color: checked
                                              ? AppColors.primary
                                              : const Color(0xFFD0D5DD),
                                          width: 1.5,
                                        ),
                                      ),
                                      child: checked
                                          ? const Icon(
                                              Icons.check,
                                              size: 13,
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ── Bottom Fixed Action Bar ───────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: RecipeDetailsBottomBar(
              recipeName: recipeName,
              recipeTime: recipeTime,
              recipeImage: recipeImage,
            ),
          ),
        ],
      ),
    );
  }
}
