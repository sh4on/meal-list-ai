import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';

// recipe details screen
// provides detailed culinary steps, ingredient breakdowns, and macro facts
class RecipeDetailsScreen extends StatelessWidget {
  const RecipeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // extract arguments passed during navigation or provide sensible defaults
    final dynamic args = Get.arguments;
    final Map<String, String> recipe = (args is Map<String, String>)
        ? args
        : {
            'name': 'Greek Yogurt Berry Bowl',
            'time': '5m',
            'kcal': '380 kcal',
            'tag': 'Breakfast',
            'image':
                'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=800&q=80',
          };

    // scaffold structure with custom scroll view for parallax-style hero image header
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: CustomScrollView(
        slivers: [
          // hero image sliver app bar
          // collapsible image header delivers visually captivating culinary presentation
          SliverAppBar(
            expandedHeight: 280.h,
            pinned: true,
            backgroundColor: AppColors.bg,
            leading: CircleAvatar(
              backgroundColor: AppColors.white.withValues(alpha: 0.85),
              child: IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                onPressed: Get.back,
              ),
            ),
            actions: [
              CircleAvatar(
                backgroundColor: AppColors.white.withValues(alpha: 0.85),
                child: IconButton(
                  icon: const Icon(
                    Icons.bookmark_border,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: recipe['image'] ?? '',
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
          // contains nutritional profile, ingredients checklist, and preparation instructions
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.screenH.w,
                vertical: AppSpacing.md.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // meal category tag
                  if (recipe['tag'] != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primarySurface,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Text(
                        recipe['tag']!,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                  SizedBox(height: AppSpacing.xs.h),

                  // recipe title
                  Text(
                    recipe['name'] ?? '',
                    style: AppTextStyles.headlineMedium,
                  ),

                  SizedBox(height: AppSpacing.sm.h),

                  // quick stats row
                  _QuickStatsBar(
                    time: recipe['time'] ?? '15m',
                    kcal: recipe['kcal'] ?? '400 kcal',
                  ),

                  SizedBox(height: AppSpacing.sectionGap.h),

                  // ingredients section
                  const Text('Ingredients', style: AppTextStyles.headlineSmall),
                  SizedBox(height: AppSpacing.sm.h),
                  const _IngredientItem(
                    name: 'Greek Yogurt (plain, non-fat)',
                    amount: '200g',
                  ),
                  const _IngredientItem(
                    name: 'Fresh Strawberries & Blueberries',
                    amount: '100g',
                  ),
                  const _IngredientItem(
                    name: 'Honey or Maple Syrup',
                    amount: '1 tbsp',
                  ),
                  const _IngredientItem(
                    name: 'Chia Seeds & Almond Slices',
                    amount: '15g',
                  ),

                  SizedBox(height: AppSpacing.sectionGap.h),

                  // preparation steps section
                  const Text(
                    'Instructions',
                    style: AppTextStyles.headlineSmall,
                  ),
                  SizedBox(height: AppSpacing.sm.h),
                  const _InstructionStep(
                    stepNumber: 1,
                    text:
                        'Spoon the Greek yogurt into a clean, chilled bowl and smooth the surface evenly.',
                  ),
                  const _InstructionStep(
                    stepNumber: 2,
                    text:
                        'Rinse fresh berries thoroughly, slice strawberries in halves, and arrange neatly across the yogurt.',
                  ),
                  const _InstructionStep(
                    stepNumber: 3,
                    text:
                        'Drizzle with pure honey or syrup, then garnish with chia seeds and toasted almond slices.',
                  ),

                  SizedBox(height: AppSpacing.sectionGap.h),

                  // action button to add to meal plan
                  PrimaryButtonWidget(
                    label: 'Add to Today\'s Plan',
                    onTap: () {
                      Get.back();
                      Get.snackbar(
                        'Added!',
                        '${recipe['name']} added to your meal plan.',
                        backgroundColor: AppColors.white,
                        colorText: AppColors.textPrimary,
                        snackPosition: SnackPosition.BOTTOM,
                        margin: const EdgeInsets.all(AppSpacing.md),
                        duration: const Duration(seconds: 2),
                      );
                    },
                  ),

                  SizedBox(height: AppSpacing.xl.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// quick stats bar displaying time, calories, and difficulty rating
class _QuickStatsBar extends StatelessWidget {
  final String time;
  final String kcal;

  const _QuickStatsBar({required this.time, required this.kcal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatColumn(
            icon: Icons.timer_outlined,
            label: 'Cook Time',
            value: time,
          ),
          Container(width: 1, height: 28, color: AppColors.divider),
          _StatColumn(
            icon: Icons.local_fire_department_outlined,
            label: 'Calories',
            value: kcal,
          ),
          Container(width: 1, height: 28, color: AppColors.divider),
          const _StatColumn(
            icon: Icons.speed,
            label: 'Difficulty',
            value: 'Easy',
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatColumn({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(height: 2),
        Text(value, style: AppTextStyles.titleSmall),
        Text(label, style: AppTextStyles.labelSmall),
      ],
    );
  }
}

// ingredient item row with checkmark indicator
class _IngredientItem extends StatelessWidget {
  final String name;
  final String amount;

  const _IngredientItem({required this.name, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 16,
            color: AppColors.primary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(name, style: AppTextStyles.bodyMedium),
          ),
          Text(
            amount,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// instruction step row with ordered numeric badge
class _InstructionStep extends StatelessWidget {
  final int stepNumber;
  final String text;

  const _InstructionStep({required this.stepNumber, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$stepNumber',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(text, style: AppTextStyles.bodyMedium),
          ),
        ],
      ),
    );
  }
}
