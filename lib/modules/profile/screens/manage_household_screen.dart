import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';

class ManageHouseholdScreen extends StatelessWidget {
  const ManageHouseholdScreen({super.key});

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
          'Manage Household',
          style: AppTextStyles.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF264E3E),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w, vertical: AppSpacing.sm.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Your Household overview
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Your Household', style: AppTextStyles.headlineSmall),
                Text(
                  '3 Total Members',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: const Color(0xFF336A56),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.sm.h),

            // Summary Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.cardPaddingLg),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildCountBadge('2 ADULTS', isPrimary: true),
                      const SizedBox(width: 8),
                      _buildCountBadge('1 CHILD', isPrimary: false),
                      const Spacer(),
                      const Icon(Icons.sync, size: 14, color: Color(0xFF336A56)),
                      const SizedBox(width: 4),
                      Text(
                        'Active sync',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: const Color(0xFF336A56),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.sm.h),
                  Text(
                    'Meal plans and grocery lists automatically scale portions and filter recipes to keep everyone safe and satisfied.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.sectionGap.h),

            // Household Members Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Household Members', style: AppTextStyles.headlineSmall),
                Text(
                  'Tap to edit rules',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.sm.h),

            // Member 1: Jane Doe
            _buildMemberCard(
              initials: 'JD',
              avatarBg: const Color(0xFFC6EAD7),
              avatarFg: const Color(0xFF1B4938),
              name: 'Jane Doe',
              nameSuffix: ' (You)',
              isAdult: true,
              portionIcon: Icons.restaurant,
              portionText: '1.0x Standard portion',
              tags: [
                _buildChip('Gluten-Free', isGreen: true),
                _buildChip('High-Protein', isGreen: false),
              ],
              onTap: () => Get.toNamed(AppRoutes.addHouseholdMember),
            ),
            SizedBox(height: AppSpacing.sm.h),

            // Member 2: Alex
            _buildMemberCard(
              initials: 'A',
              avatarBg: const Color(0xFFE8ECEA),
              avatarFg: const Color(0xFF333333),
              name: 'Alex',
              isAdult: true,
              portionIcon: Icons.open_in_full,
              portionText: '1.25x Active / Large portion',
              tags: [
                _buildWarningChip(Icons.warning_amber_rounded, 'No Shellfish'),
              ],
              onTap: () => Get.toNamed(AppRoutes.addHouseholdMember),
            ),
            SizedBox(height: AppSpacing.sm.h),

            // Member 3: Leo
            _buildMemberCard(
              initials: 'L',
              avatarBg: const Color(0xFFC6EAD7),
              avatarFg: const Color(0xFF1B4938),
              name: 'Leo',
              isAdult: false,
              portionIcon: Icons.sentiment_satisfied_alt,
              portionText: '0.5x Child portion',
              tags: [
                _buildWarningChip(Icons.block, 'Nut Allergy'),
                _buildChip('Mild Spices', isGreen: false),
              ],
              onTap: () => Get.toNamed(AppRoutes.addHouseholdMember),
            ),

            SizedBox(height: AppSpacing.lg.h),

            // Add Household Member Button
            PrimaryButtonWidget(
              label: '+ Add Household Member',
              onTap: () => Get.toNamed(AppRoutes.addHouseholdMember),
            ),

            SizedBox(height: AppSpacing.md.h),

            // What can I cook? Button
            InkWell(
              onTap: () => Get.toNamed(AppRoutes.whatCanICook),
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B6E59),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.auto_awesome, color: AppColors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'What can I cook?',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: AppSpacing.lg.h),

            // Safety Guarantee Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.cardPaddingLg),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF3F1),
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.shield_outlined, color: Color(0xFF2E634F), size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SAFETY GUARANTEE',
                          style: AppTextStyles.labelSmall.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF264E3E),
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Allergies and restrictions defined for any household member apply across shared family meal suggestions.',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ],
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

  static Widget _buildCountBadge(String label, {required bool isPrimary}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isPrimary ? const Color(0xFFD6EDE0) : const Color(0xFFECECEC),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isPrimary ? const Color(0xFF235843) : const Color(0xFF555555),
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Widget _buildMemberCard({
    required String initials,
    required Color avatarBg,
    required Color avatarFg,
    required String name,
    String? nameSuffix,
    required bool isAdult,
    required IconData portionIcon,
    required String portionText,
    required List<Widget> tags,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.cardPaddingLg),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: avatarBg,
              child: Text(
                initials,
                style: TextStyle(
                  color: avatarFg,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name, style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                      if (nameSuffix != null)
                        Text(
                          nameSuffix,
                          style: AppTextStyles.titleSmall.copyWith(
                            color: const Color(0xFF336A56),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDEDED),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          isAdult ? 'ADULT' : 'CHILD',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(portionIcon, size: 14, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        portionText,
                        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: tags,
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }

  static Widget _buildChip(String label, {required bool isGreen}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isGreen ? const Color(0xFFE3F3EB) : const Color(0xFFEDEDED),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: isGreen ? const Color(0xFF265B46) : const Color(0xFF555555),
        ),
      ),
    );
  }

  static Widget _buildWarningChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFDECEB),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: const Color(0xFFB9382F)),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFFB9382F),
            ),
          ),
        ],
      ),
    );
  }
}
