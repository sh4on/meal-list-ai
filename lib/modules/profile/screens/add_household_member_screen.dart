import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';

class AddHouseholdMemberScreen extends StatefulWidget {
  const AddHouseholdMemberScreen({super.key});

  @override
  State<AddHouseholdMemberScreen> createState() => _AddHouseholdMemberScreenState();
}

class _AddHouseholdMemberScreenState extends State<AddHouseholdMemberScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _isAdult = true;
  String _selectedPortion = '1.0x';
  final Set<String> _selectedPreferences = {'Gluten-Free', 'Mediterranean'};
  final Set<String> _selectedAllergens = {'Peanuts / Tree Nuts'};

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

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
          'Add Household Member',
          style: AppTextStyles.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF264E3E),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w, vertical: AppSpacing.sm.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumb
            Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Text(
                    'Manage Household',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right, size: 14, color: AppColors.textTertiary),
                Text(
                  'New Member Profile',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: const Color(0xFF2E634F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.md.h),

            // Card 1: Member Details
            _buildCardWrapper(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.badge_outlined, color: Color(0xFF2E634F), size: 20),
                      const SizedBox(width: 8),
                      const Text('Member Details', style: AppTextStyles.titleMedium),
                      const Spacer(),
                      _buildPill('REQUIRED', bg: const Color(0xFFD6EDE0), fg: const Color(0xFF235843)),
                    ],
                  ),
                  SizedBox(height: AppSpacing.md.h),
                  const Text('Full Name or Nickname', style: AppTextStyles.inputLabel),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'e.g., Sarah, Leo, Alex',
                      hintStyle: const TextStyle(color: AppColors.textTertiary, fontSize: 14),
                      suffixIcon: const Icon(Icons.edit_outlined, size: 18, color: AppColors.textTertiary),
                      filled: true,
                      fillColor: const Color(0xFFFAFAFA),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        borderSide: const BorderSide(color: Color(0xFF3B6E59), width: 1.5),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.md.h),
                  const Text('Role & Nutritional Profile', style: AppTextStyles.inputLabel),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _buildRoleCard(
                          title: 'Adult',
                          desc: 'Full nutritional scale & adult metabolic benchmarks',
                          isSelected: _isAdult,
                          onTap: () => setState(() => _isAdult = true),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildRoleCard(
                          title: 'Child',
                          desc: 'Under 12 yrs (gentle spice & child-friendly portions)',
                          isSelected: !_isAdult,
                          onTap: () => setState(() => _isAdult = false),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.md.h),

            // Card 2: Portion Scaling
            _buildCardWrapper(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.hourglass_empty, color: Color(0xFF2E634F), size: 20),
                      SizedBox(width: 8),
                      Text('Portion Scaling', style: AppTextStyles.titleMedium),
                      Spacer(),
                      Icon(Icons.info_outline, size: 18, color: AppColors.textTertiary),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Used to dynamically calculate recipe servings and smart grocery volume for collective meals.',
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                  ),
                  SizedBox(height: AppSpacing.md.h),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.5,
                    children: [
                      _buildPortionTile('0.5x', 'Light', 'Ideal for toddlers, kids, or smaller appetites.'),
                      _buildPortionTile('1.0x', 'Standard', 'Standard adult benchmark baseline.'),
                      _buildPortionTile('1.25x', 'Hearty', 'For active lifestyles and endurance fitness.'),
                      _buildPortionTile('1.5x', 'Athlete', 'High-caloric or heavy training meal plans.'),
                    ],
                  ),
                  SizedBox(height: AppSpacing.sm.h),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F8F7),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.restaurant, size: 16, color: Color(0xFF3B6E59)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'A standard 4-person dinner yields exactly 1 serving for this member.',
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.md.h),

            // Card 3: Food Preferences
            _buildCardWrapper(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.eco_outlined, color: Color(0xFF2E634F), size: 20),
                      SizedBox(width: 8),
                      Text('Food Preferences', style: AppTextStyles.titleMedium),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'General culinary styles and taste guidelines (soft preferences, not health-critical).',
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                  ),
                  SizedBox(height: AppSpacing.md.h),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      'High-Protein',
                      'Gluten-Free',
                      'Vegetarian',
                      'Pescatarian',
                      'Low-Carb',
                      'Mediterranean',
                      'Mild Spices Only',
                      'Dairy-Free',
                    ].map((pref) {
                      final isSelected = _selectedPreferences.contains(pref);
                      return FilterChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isSelected) ...[
                              const Icon(Icons.check, size: 14, color: Color(0xFF1B4938)),
                              const SizedBox(width: 4),
                            ],
                            Text(pref),
                          ],
                        ),
                        selected: isSelected,
                        onSelected: (val) {
                          setState(() {
                            if (val) {
                              _selectedPreferences.add(pref);
                            } else {
                              _selectedPreferences.remove(pref);
                            }
                          });
                        },
                        backgroundColor: AppColors.white,
                        selectedColor: const Color(0xFFE2F2E9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                          side: BorderSide(
                            color: isSelected ? const Color(0xFF265B46) : AppColors.border,
                            width: isSelected ? 1.5 : 1,
                          ),
                        ),
                        labelStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? const Color(0xFF1B4938) : AppColors.textPrimary,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.md.h),

            // Card 4: Allergies & Restrictions
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: const Color(0xFF9E473F), width: 1.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Color(0xFF8E3730),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.md)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.cardPaddingLg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.shield_outlined, color: Color(0xFF8E3730), size: 20),
                            const SizedBox(width: 8),
                            const Text('Allergies & Restrictions', style: AppTextStyles.titleMedium),
                            const Spacer(),
                            _buildPill('SAFETY CRITICAL', bg: const Color(0xFFFDECEB), fg: const Color(0xFF8E3730)),
                          ],
                        ),
                        SizedBox(height: AppSpacing.sm.h),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFDF4F3),
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.shield_outlined, color: Color(0xFF8E3730), size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: RichText(
                                  text: const TextSpan(
                                    style: TextStyle(fontSize: 12, color: Color(0xFF333333), height: 1.4),
                                    children: [
                                      TextSpan(
                                        text: 'Zero-tolerance filter: ',
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF8E3730)),
                                      ),
                                      TextSpan(
                                        text:
                                            'Any recipes containing these ingredients will be permanently flagged or swapped automatically across all family dinner plans.',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppSpacing.md.h),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            'Peanuts / Tree Nuts',
                            'Shellfish',
                            'Dairy / Lactose',
                            'Eggs',
                            'Soy',
                            'Wheat / Gluten',
                            'Fish',
                            'Sesame',
                          ].map((allergen) {
                            final isSelected = _selectedAllergens.contains(allergen);
                            return FilterChip(
                              label: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isSelected ? Icons.error : Icons.block,
                                    size: 14,
                                    color: isSelected ? const Color(0xFF7A1C16) : AppColors.textSecondary,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(allergen),
                                ],
                              ),
                              selected: isSelected,
                              onSelected: (val) {
                                setState(() {
                                  if (val) {
                                    _selectedAllergens.add(allergen);
                                  } else {
                                    _selectedAllergens.remove(allergen);
                                  }
                                });
                              },
                              backgroundColor: AppColors.white,
                              selectedColor: const Color(0xFFFBE4E2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppRadius.pill),
                                side: BorderSide(
                                  color: isSelected ? const Color(0xFF7A1C16) : AppColors.border,
                                  width: isSelected ? 1.5 : 1,
                                ),
                              ),
                              labelStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                color: isSelected ? const Color(0xFF7A1C16) : AppColors.textPrimary,
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 12),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add_circle_outline, color: Color(0xFF265B46), size: 18),
                          label: const Text(
                            'Add custom allergen',
                            style: TextStyle(color: Color(0xFF265B46), fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.md.h),

            // Card 5: Why Mealist tracks individual members
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.cardPaddingLg),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F5F0),
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: const Color(0xFFEBDDCF)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.auto_awesome, color: Color(0xFFB0623A), size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Why Mealist tracks individual members',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Color(0xFF7E3D1C),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Mealist\'s engine cross-references all household members when generating dinner menus, ensuring every single shared meal satisfies dietary safety while eliminating grocery waste through exact scaled portions.',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: const Color(0xFF5A4438),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.lg.h),

            // Save Member Button
            InkWell(
              onTap: () => Get.back(),
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A5946),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_outline, color: AppColors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Save Member',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Returns to Manage Household with updated portions & allergy matrix.',
                style: AppTextStyles.labelSmall.copyWith(color: AppColors.textTertiary),
              ),
            ),

            SizedBox(height: AppSpacing.xxxl.h),
          ],
        ),
      ),
    );
  }

  Widget _buildCardWrapper({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPaddingLg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }

  Widget _buildPill(String text, {required Color bg, required Color fg}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        text,
        style: TextStyle(color: fg, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5),
      ),
    );
  }

  Widget _buildRoleCard({
    required String title,
    required String desc,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                Icon(
                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                  size: 18,
                  color: isSelected ? const Color(0xFF2E634F) : AppColors.textTertiary,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              desc,
              style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary, height: 1.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPortionTile(String factor, String badge, String desc) {
    final isSelected = _selectedPortion == factor;
    return InkWell(
      onTap: () => setState(() => _selectedPortion = factor),
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Container(
        padding: const EdgeInsets.all(10),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(factor, style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFD6EDE0) : const Color(0xFFEDEDED),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    badge,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? const Color(0xFF235843) : const Color(0xFF555555),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              desc,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
