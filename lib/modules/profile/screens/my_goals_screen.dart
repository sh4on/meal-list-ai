import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';

class MyGoalsScreen extends StatefulWidget {
  const MyGoalsScreen({super.key});

  @override
  State<MyGoalsScreen> createState() => _MyGoalsScreenState();
}

class _MyGoalsScreenState extends State<MyGoalsScreen> {
  String _primaryGoal = 'Eat healthier';
  final Set<String> _otherGoals = {'Try new cuisines'};

  final List<Map<String, dynamic>> _primaryGoalOptions = [
    {
      'title': 'Eat healthier',
      'icon': Icons.add_moderator_outlined,
    },
    {
      'title': 'Lose weight',
      'icon': Icons.hourglass_empty,
    },
    {
      'title': 'Build muscle',
      'icon': Icons.fitness_center,
    },
    {
      'title': 'Save money',
      'icon': Icons.savings_outlined,
    },
  ];

  final List<Map<String, dynamic>> _otherGoalOptions = [
    {
      'title': 'Try new cuisines',
      'icon': Icons.restaurant,
    },
    {
      'title': 'Cook faster',
      'icon': Icons.timer_outlined,
    },
    {
      'title': 'Use pantry ingredients',
      'icon': Icons.inventory_2_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'My Goals',
          style: AppTextStyles.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF264E3E),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w, vertical: AppSpacing.sm.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Choose what matters most to you.',
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
              ),
            ),
            SizedBox(height: AppSpacing.xl.h),

            // Primary goal
            Row(
              children: [
                const Text(
                  'Primary goal',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E634F),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: const Text(
                    'SELECT 1',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.md.h),

            // 2x2 Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.4,
              ),
              itemCount: _primaryGoalOptions.length,
              itemBuilder: (context, index) {
                final item = _primaryGoalOptions[index];
                final isSelected = _primaryGoal == item['title'];
                return InkWell(
                  onTap: () => setState(() => _primaryGoal = item['title']),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF2E634F) : AppColors.border,
                        width: isSelected ? 1.8 : 1,
                      ),
                    ),
                    child: Stack(
                      children: [
                        if (isSelected)
                          const Positioned(
                            top: 0,
                            right: 0,
                            child: Icon(
                              Icons.check_circle,
                              color: Color(0xFF2E634F),
                              size: 18,
                            ),
                          ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                item['icon'] as IconData,
                                color: isSelected ? const Color(0xFF2E634F) : AppColors.textPrimary,
                                size: 26,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item['title'] as String,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? const Color(0xFF2E634F) : AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: AppSpacing.sectionGap.h),

            // Other goals
            const Text(
              'Other goals',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: AppSpacing.md.h),

            ..._otherGoalOptions.map((item) {
              final isChecked = _otherGoals.contains(item['title']);
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (isChecked) {
                        _otherGoals.remove(item['title']);
                      } else {
                        _otherGoals.add(item['title']);
                      }
                    });
                  },
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(
                        color: isChecked ? const Color(0xFF2E634F) : AppColors.border,
                        width: isChecked ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item['icon'] as IconData,
                          size: 20,
                          color: const Color(0xFF2E634F),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          item['title'] as String,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          isChecked ? Icons.check_box_outlined : Icons.check_box_outline_blank,
                          size: 20,
                          color: isChecked ? const Color(0xFF2E634F) : AppColors.textTertiary,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            SizedBox(height: AppSpacing.lg.h),

            // Sparkle Callout
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.cardPaddingLg),
              decoration: BoxDecoration(
                color: const Color(0xFFFAF4ED),
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: const Color(0xFFEBDDCF)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.auto_awesome, color: Color(0xFFD48B47), size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Your primary goal has the strongest influence on your recommendations. Other goals help break ties.',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: const Color(0xFF6B4A34),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.xxxl.h),
          ],
        ),
      ),
    );
  }
}
