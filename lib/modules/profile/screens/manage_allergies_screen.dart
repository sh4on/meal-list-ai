import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';

// manage allergies & restrictions screen
// allows toggling allergens to guarantee recipes and meal plans avoid them
class ManageAllergiesScreen extends StatefulWidget {
  const ManageAllergiesScreen({super.key});

  @override
  State<ManageAllergiesScreen> createState() => _ManageAllergiesScreenState();
}

class _ManageAllergiesScreenState extends State<ManageAllergiesScreen> {
  final List<String> _allergens = const [
    'Gluten',
    'Dairy',
    'Eggs',
    'Peanuts',
    'Tree Nuts',
    'Shellfish',
    'Fish',
    'Soy',
    'Sesame',
    'Sulfites',
  ];

  final Set<String> _selected = {'Dairy', 'Peanuts'};

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
        title: const Text(
          'Allergies & Restrictions',
          style: AppTextStyles.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.screenH.w,
                vertical: AppSpacing.md.h,
              ),
              itemCount: _allergens.length,
              itemBuilder: (final BuildContext ctx, final int index) {
                final String allergen = _allergens[index];
                final bool isSelected = _selected.contains(allergen);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selected.remove(allergen);
                      } else {
                        _selected.add(allergen);
                      }
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(
                        color:
                            isSelected ? AppColors.primary : AppColors.border,
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child:
                              Text(allergen, style: AppTextStyles.bodyMedium),
                        ),
                        Icon(
                          isSelected
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textTertiary,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.screenH.w,
              AppSpacing.sm.h,
              AppSpacing.screenH.w,
              AppSpacing.xl.h,
            ),
            child: PrimaryButtonWidget(
              label: 'Save Restrictions',
              onTap: () {
                Get.back();
                Get.snackbar(
                  'Restrictions Saved',
                  'Your dietary exclusions have been updated.',
                  backgroundColor: AppColors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  margin: const EdgeInsets.all(AppSpacing.md),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
