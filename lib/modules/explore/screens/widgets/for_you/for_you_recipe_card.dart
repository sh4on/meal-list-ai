import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../routes/app_routes.dart';
import '../add_to_meal_plan_bottom_sheet.dart';

// recommended recipe card for "recommended for you" section on for you screen
class ForYouRecipeCard extends StatefulWidget {
  final Map<String, dynamic> recipe;

  const ForYouRecipeCard({
    super.key,
    required this.recipe,
  });

  @override
  State<ForYouRecipeCard> createState() => _ForYouRecipeCardState();
}

class _ForYouRecipeCardState extends State<ForYouRecipeCard> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> recipe = widget.recipe;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // recipe image with match and favorite badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppRadius.md),
                  topRight: Radius.circular(AppRadius.md),
                ),
                child: CachedNetworkImage(
                  imageUrl: recipe['image'] as String? ?? '',
                  width: double.infinity,
                  height: 180.h,
                  memCacheWidth: 600,
                  memCacheHeight: 360,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    color: AppColors.shimmerBase,
                  ),
                  errorWidget: (_, __, ___) => Container(
                    color: AppColors.shimmerBase,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    recipe['match'] as String? ?? '90% match',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.white.withValues(alpha: 0.9),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 18,
                    icon: Icon(
                      _isLiked ? Icons.favorite : Icons.favorite_border,
                      color: _isLiked ? Colors.red : AppColors.textPrimary,
                    ),
                    onPressed: () {
                      setState(() {
                        _isLiked = !_isLiked;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),

          // details container
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed(
                    AppRoutes.recipeDetails,
                    arguments: {
                      'name': recipe['title'] ?? '',
                      'time': recipe['time'] ?? '',
                      'kcal': recipe['kcal'] ?? '',
                      'image': recipe['image'] ?? '',
                    },
                  ),
                  child: Text(
                    recipe['title'] as String? ?? '',
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${recipe['time']} • ${recipe['kcal']}',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 10),
                // macro badges
                Row(
                  children: [
                    ForYouMacroPill(
                      label: 'Protein',
                      value: recipe['protein'] as String? ?? '0g',
                      highlight: true,
                    ),
                    const SizedBox(width: 6),
                    ForYouMacroPill(
                      label: 'Carbs',
                      value: recipe['carbs'] as String? ?? '0g',
                    ),
                    const SizedBox(width: 6),
                    ForYouMacroPill(
                      label: 'Fat',
                      value: recipe['fat'] as String? ?? '0g',
                    ),
                    const SizedBox(width: 6),
                    ForYouMacroPill(
                      label: 'Fiber',
                      value: recipe['fiber'] as String? ?? '0g',
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      AddToMealPlanBottomSheet.show(
                        context,
                        name: recipe['title'] as String?,
                        image: recipe['image'] as String?,
                        time: recipe['time'] as String?,
                      );
                    },
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text(
                      'Add to Meal Plan',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B6E59),
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// macro nutrition pill component
class ForYouMacroPill extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const ForYouMacroPill({
    super.key,
    required this.label,
    required this.value,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: highlight ? const Color(0xFFE8F5E9) : const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(AppRadius.xs),
        border: Border.all(
          color: highlight ? const Color(0xFF81C784) : const Color(0xFFE0E0E0),
        ),
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 11, color: AppColors.textPrimary),
          children: [
            TextSpan(
              text: '$value ',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: highlight
                    ? const Color(0xFF2E7D32)
                    : AppColors.textPrimary,
              ),
            ),
            TextSpan(
              text: label,
              style: TextStyle(
                color: highlight
                    ? const Color(0xFF2E7D32)
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
