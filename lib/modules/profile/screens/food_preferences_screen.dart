import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';

class FoodPreferencesScreen extends StatefulWidget {
  const FoodPreferencesScreen({super.key});

  @override
  State<FoodPreferencesScreen> createState() => _FoodPreferencesScreenState();
}

class _FoodPreferencesScreenState extends State<FoodPreferencesScreen> {
  String _selectedDietaryStyle = 'Omnivore';

  final List<String> _favouriteCuisines = ['Mediterranean', 'Turkish', 'Italian'];
  final List<String> _lovedFoods = ['Chicken', 'Rice', 'Garlic', 'Spicy food'];
  final List<String> _dislikedFoods = ['Mushrooms', 'Very spicy food'];

  final TextEditingController _loveController = TextEditingController();
  final TextEditingController _dislikeController = TextEditingController();

  @override
  void dispose() {
    _loveController.dispose();
    _dislikeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColors.bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Food Preferences',
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
            Text(
              'Tell Mealist what you enjoy so recommendations feel more like you. Changes are saved automatically.',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary, height: 1.4),
            ),
            SizedBox(height: AppSpacing.lg.h),

            // Dietary style
            const Text(
              'Dietary style',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: AppSpacing.md.h),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.6,
              children: [
                _buildDietCard('Omnivore', Icons.restaurant),
                _buildDietCard('Vegetarian', Icons.eco_outlined),
                _buildDietCard('Vegan', Icons.local_florist_outlined),
                _buildDietCard('Pescatarian', Icons.set_meal_outlined),
              ],
            ),

            SizedBox(height: AppSpacing.sectionGap.h),

            // Favourite cuisines
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Favourite cuisines',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 16, color: Color(0xFF265B46)),
                  label: const Text(
                    'Add',
                    style: TextStyle(
                      color: Color(0xFF265B46),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.xs.h),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _favouriteCuisines.map((cuisine) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2F0E7),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    border: Border.all(color: const Color(0xFFC4E2CF)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        cuisine,
                        style: const TextStyle(
                          color: Color(0xFF1B4938),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () => setState(() => _favouriteCuisines.remove(cuisine)),
                        child: const Icon(Icons.close, size: 14, color: Color(0xFF1B4938)),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: AppSpacing.lg.h),
            const Divider(color: AppColors.divider),
            SizedBox(height: AppSpacing.md.h),

            // I love
            const Text(
              'I love',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'These improve ranking. They are not exclusions.',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
            ),
            SizedBox(height: AppSpacing.sm.h),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _lovedFoods.map((food) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(food, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary)),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () => setState(() => _lovedFoods.remove(food)),
                        child: const Icon(Icons.close, size: 14, color: AppColors.textTertiary),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: AppSpacing.sm.h),

            TextField(
              controller: _loveController,
              decoration: InputDecoration(
                hintText: 'Add ingredient or food...',
                hintStyle: const TextStyle(color: AppColors.textTertiary, fontSize: 13),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add_circle_outline, color: Color(0xFF265B46)),
                  onPressed: () {
                    if (_loveController.text.trim().isNotEmpty) {
                      setState(() {
                        _lovedFoods.add(_loveController.text.trim());
                        _loveController.clear();
                      });
                    }
                  },
                ),
                filled: true,
                fillColor: AppColors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
            ),

            SizedBox(height: AppSpacing.sectionGap.h),

            // I don't enjoy
            const Text(
              "I don't enjoy",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Dislikes lower ranking. They are not hard exclusions.',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
            ),
            SizedBox(height: AppSpacing.sm.h),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _dislikedFoods.map((food) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(food, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary)),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () => setState(() => _dislikedFoods.remove(food)),
                        child: const Icon(Icons.close, size: 14, color: AppColors.textTertiary),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: AppSpacing.sm.h),

            TextField(
              controller: _dislikeController,
              decoration: InputDecoration(
                hintText: 'Add ingredient to avoid...',
                hintStyle: const TextStyle(color: AppColors.textTertiary, fontSize: 13),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add_circle_outline, color: Color(0xFF265B46)),
                  onPressed: () {
                    if (_dislikeController.text.trim().isNotEmpty) {
                      setState(() {
                        _dislikedFoods.add(_dislikeController.text.trim());
                        _dislikeController.clear();
                      });
                    }
                  },
                ),
                filled: true,
                fillColor: AppColors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
            ),

            SizedBox(height: AppSpacing.xl.h),

            // Have an allergy or restriction card
            InkWell(
              onTap: () => Get.toNamed(AppRoutes.manageAllergies),
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.cardPaddingLg),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFDECEB),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.medical_services_outlined, color: Color(0xFFC75146), size: 20),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Have an allergy or restriction?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Manage Allergies & Restrictions',
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: AppColors.textTertiary, size: 20),
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

  Widget _buildDietCard(String title, IconData icon) {
    final isSelected = _selectedDietaryStyle == title;
    return InkWell(
      onTap: () => setState(() => _selectedDietaryStyle = title),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFE2F0E7) : const Color(0xFFF3F4F3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 18,
                color: isSelected ? const Color(0xFF265B46) : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: isSelected ? const Color(0xFF265B46) : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
