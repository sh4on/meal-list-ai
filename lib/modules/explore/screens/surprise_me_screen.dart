import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/common_widgets/outline_button_widget.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';

// surprise me screen
// selects an unexpected recipe aligned with user macros and pantry inventory
class SurpriseMeScreen extends StatefulWidget {
  const SurpriseMeScreen({super.key});

  @override
  State<SurpriseMeScreen> createState() => _SurpriseMeScreenState();
}

class _SurpriseMeScreenState extends State<SurpriseMeScreen> {
  int _recipeIndex = 0;

  final List<Map<String, String>> _candidates = [
    {
      'title': 'Crispy Skin Salmon & Asparagus',
      'desc':
          'Quick 25-minute high-protein dinner utilizing fresh lemon and herbs.',
      'time': '25 min',
      'kcal': '460 kcal',
      'match': '96% Match',
      'image':
          'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=800&q=80',
    },
    {
      'title': 'Garlic Butter Herb Steak Bites',
      'desc': 'Tender seared beef morsels tossed in garlic-herb pan reduction.',
      'time': '20 min',
      'kcal': '520 kcal',
      'match': '93% Match',
      'image':
          'https://images.unsplash.com/photo-1544025162-d76694265947?w=800&q=80',
    },
    {
      'title': 'Mediterranean Harvest Bowl',
      'desc':
          'Warm grains with roasted chickpeas, kalamata olives, and feta crumble.',
      'time': '18 min',
      'kcal': '390 kcal',
      'match': '91% Match',
      'image':
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800&q=80',
    },
  ];

  void _spin() {
    setState(() {
      _recipeIndex = (_recipeIndex + 1) % _candidates.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> recipe = _candidates[_recipeIndex];

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: Get.back,
        ),
        title: const Text('Surprise Me', style: AppTextStyles.headlineSmall),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
        child: Column(
          children: [
            SizedBox(height: AppSpacing.md.h),

            // recommendation container
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.accent, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // recipe image with match badge
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(AppRadius.md),
                            topRight: Radius.circular(AppRadius.md),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: recipe['image']!,
                            height: 220.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (_, __) =>
                                Container(color: AppColors.shimmerBase),
                            errorWidget: (_, __, ___) =>
                                Container(color: AppColors.shimmerBase),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.95),
                              borderRadius:
                                  BorderRadius.circular(AppRadius.pill),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.auto_awesome,
                                  size: 13,
                                  color: AppColors.accent,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  recipe['match']!,
                                  style: AppTextStyles.labelSmall.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.cardPaddingLg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipe['title']!,
                            style: AppTextStyles.headlineMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            recipe['desc']!,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Icon(
                                Icons.timer_outlined,
                                size: 16,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                recipe['time']!,
                                style: AppTextStyles.bodyMedium,
                              ),
                              const SizedBox(width: 16),
                              const Icon(
                                Icons.local_fire_department_outlined,
                                size: 16,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                recipe['kcal']!,
                                style: AppTextStyles.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: AppSpacing.lg.h),

            // cook this recipe CTA
            PrimaryButtonWidget(
              label: 'Cook This Recipe',
              onTap: () {
                Get.toNamed(
                  AppRoutes.recipeDetails,
                  arguments: {
                    'name': recipe['title']!,
                    'time': recipe['time']!,
                    'kcal': recipe['kcal']!,
                    'tag': 'Surprise',
                    'image': recipe['image']!,
                  },
                );
              },
            ),

            SizedBox(height: AppSpacing.sm.h),

            // spin again
            OutlineButtonWidget(
              label: '🎲 Spin Again (Different Meal)',
              onTap: _spin,
            ),

            SizedBox(height: AppSpacing.xl.h),
          ],
        ),
      ),
    );
  }
}
