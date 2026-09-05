import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';
import '../../../shared/common_widgets/selection_chip_widget.dart';

// food preferences screen
// manages preferred regional cuisines and disliked ingredients
class FoodPreferencesScreen extends StatefulWidget {
  const FoodPreferencesScreen({super.key});

  @override
  State<FoodPreferencesScreen> createState() => _FoodPreferencesScreenState();
}

class _FoodPreferencesScreenState extends State<FoodPreferencesScreen> {
  final List<String> _cuisines = const [
    'Mediterranean',
    'Turkish',
    'Italian',
    'Japanese',
    'Mexican',
    'Indian',
    'Greek',
    'Thai',
  ];

  final Set<String> _selectedCuisines = {'Mediterranean', 'Turkish', 'Italian'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: Get.back,
        ),
        title:
            const Text('Food Preferences', style: AppTextStyles.headlineSmall),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSpacing.md.h),
            const Text('Favourite Cuisines', style: AppTextStyles.titleMedium),
            SizedBox(height: AppSpacing.xs.h),
            const Text(
              'Select the culinary traditions you enjoy most.',
              style: AppTextStyles.bodySmall,
            ),
            SizedBox(height: AppSpacing.md.h),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _cuisines.map((final String c) {
                final bool isSelected = _selectedCuisines.contains(c);
                return SelectionChipWidget(
                  label: c,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedCuisines.remove(c);
                      } else {
                        _selectedCuisines.add(c);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const Spacer(),
            PrimaryButtonWidget(
              label: 'Save Preferences',
              onTap: () {
                Get.back();
                Get.snackbar(
                  'Preferences Saved',
                  'Your cuisine preferences have been updated.',
                  backgroundColor: AppColors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  margin: const EdgeInsets.all(AppSpacing.md),
                );
              },
            ),
            SizedBox(height: AppSpacing.xl.h),
          ],
        ),
      ),
    );
  }
}
