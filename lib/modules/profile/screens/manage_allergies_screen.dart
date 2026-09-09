import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';

class ManageAllergiesScreen extends StatefulWidget {
  const ManageAllergiesScreen({super.key});

  @override
  State<ManageAllergiesScreen> createState() => _ManageAllergiesScreenState();
}

class _ManageAllergiesScreenState extends State<ManageAllergiesScreen> {
  bool _noRestrictions = false;

  final Set<String> _selectedAllergies = {'Dairy', 'Gluten'};
  final List<String> _allergyList = [
    'Dairy',
    'Peanuts',
    'Tree Nuts',
    'Gluten',
    'Eggs',
  ];

  final Set<String> _selectedDietary = {'Halal'};
  final List<String> _dietaryList = ['Halal', 'Kosher', 'No Alcohol'];

  final List<String> _specificIngredients = ['Cilantro', 'Mushrooms', 'Olives'];
  bool _showShellfishCard = true;

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
          'Allergies & Restrictions',
          style: AppTextStyles.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF264E3E),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.screenH.w,
          vertical: AppSpacing.sm.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // I have no restrictions card
            InkWell(
              onTap: () => setState(() => _noRestrictions = !_noRestrictions),
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.cardPaddingLg),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(
                    color: _noRestrictions
                        ? const Color(0xFF2E634F)
                        : AppColors.border,
                    width: _noRestrictions ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD6EDE0),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Color(0xFF235843),
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'I have no restrictions',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Skip this step and eat everything',
                            style: AppTextStyles.bodySmall
                                .copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      _noRestrictions
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: _noRestrictions
                          ? const Color(0xFF2E634F)
                          : AppColors.textTertiary,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: AppSpacing.md.h),
            const Divider(color: AppColors.divider),
            SizedBox(height: AppSpacing.md.h),

            // ALLERGIES
            Row(
              children: [
                Text(
                  'ALLERGIES',
                  style: AppTextStyles.labelSmall.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.medical_services,
                  size: 14,
                  color: Color(0xFFB9382F),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.xs.h),

            _buildSearchField('Search allergies...'),
            SizedBox(height: AppSpacing.sm.h),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _allergyList.map((allergy) {
                final isSelected = _selectedAllergies.contains(allergy);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedAllergies.remove(allergy);
                      } else {
                        _selectedAllergies.add(allergy);
                      }
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFB9382F)
                          : AppColors.white,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFFB9382F)
                            : AppColors.border,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          allergy,
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.white
                                : AppColors.textPrimary,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (isSelected) ...[
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.close,
                            size: 14,
                            color: AppColors.white,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: AppSpacing.sectionGap.h),

            // DIETARY & RELIGIOUS
            Row(
              children: [
                Text(
                  'DIETARY & RELIGIOUS',
                  style: AppTextStyles.labelSmall.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.menu_book_outlined,
                  size: 14,
                  color: Color(0xFF2E634F),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.xs.h),

            _buildSearchField('Search restrictions...'),
            SizedBox(height: AppSpacing.sm.h),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _dietaryList.map((diet) {
                final isSelected = _selectedDietary.contains(diet);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedDietary.remove(diet);
                      } else {
                        _selectedDietary.add(diet);
                      }
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF2E634F)
                          : AppColors.white,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF2E634F)
                            : AppColors.border,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          diet,
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.white
                                : AppColors.textPrimary,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (isSelected) ...[
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.close,
                            size: 14,
                            color: AppColors.white,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: AppSpacing.sectionGap.h),

            // SPECIFIC INGREDIENTS
            Row(
              children: [
                Text(
                  'SPECIFIC INGREDIENTS',
                  style: AppTextStyles.labelSmall.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.spa_outlined,
                  size: 14,
                  color: Color(0xFF2E634F),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.xs.h),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.search,
                    color: AppColors.textTertiary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'I cannot eat shellfish',
                      style:
                          TextStyle(fontSize: 13, color: AppColors.textPrimary),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E4E2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF555555),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (_showShellfishCard) ...[
              SizedBox(height: AppSpacing.sm.h),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.cardPaddingLg),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7EE),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: const Color(0xFFF7D9BC)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      color: Color(0xFFE28B38),
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shellfish',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Categorized as Allergy',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFFDF7F25),
                            ),
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () =>
                          setState(() => _showShellfishCard = false),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'Remove',
                        style: TextStyle(
                          color: Color(0xFF555555),
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEE9748),
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            SizedBox(height: AppSpacing.sm.h),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _specificIngredients.map((ingredient) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    ingredient,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: AppSpacing.xxxl.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textTertiary, fontSize: 13),
        prefixIcon:
            const Icon(Icons.search, size: 20, color: AppColors.textTertiary),
        filled: true,
        fillColor: AppColors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}
