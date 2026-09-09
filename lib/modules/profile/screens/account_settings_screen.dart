import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

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
          'Account Settings',
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
            // SECURITY
            _buildSectionHeader('SECURITY'),
            SizedBox(height: AppSpacing.xs.h),
            _buildCardWrapper(
              child: ListTile(
                leading: const Icon(
                  Icons.lock_outline,
                  color: Color(0xFF2E634F),
                  size: 22,
                ),
                title: Text(
                  'Change password',
                  style: AppTextStyles.titleSmall
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: AppColors.textTertiary,
                ),
                onTap: () {},
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              ),
            ),

            SizedBox(height: AppSpacing.sectionGap.h),

            // PREFERENCES
            _buildSectionHeader('PREFERENCES'),
            SizedBox(height: AppSpacing.xs.h),
            _buildCardWrapper(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.notifications_none,
                      color: Color(0xFF2E634F),
                      size: 22,
                    ),
                    title: Text(
                      'Notifications',
                      style: AppTextStyles.titleSmall
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: AppColors.textTertiary,
                    ),
                    onTap: () {},
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  ListTile(
                    leading: const Icon(
                      Icons.language,
                      color: Color(0xFF2E634F),
                      size: 22,
                    ),
                    title: Text(
                      'Language & Region',
                      style: AppTextStyles.titleSmall
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'English (US)',
                          style: AppTextStyles.bodySmall
                              .copyWith(color: AppColors.textSecondary),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.chevron_right,
                          size: 18,
                          color: AppColors.textTertiary,
                        ),
                      ],
                    ),
                    onTap: () {},
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.sectionGap.h),

            // INFORMATION & LEGAL
            _buildSectionHeader('INFORMATION & LEGAL'),
            SizedBox(height: AppSpacing.xs.h),
            _buildCardWrapper(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.description_outlined,
                      color: Color(0xFF2E634F),
                      size: 22,
                    ),
                    title: Text(
                      'Terms of services',
                      style: AppTextStyles.titleSmall
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: AppColors.textTertiary,
                    ),
                    onTap: () {},
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  ListTile(
                    leading: const Icon(
                      Icons.shield_outlined,
                      color: Color(0xFF2E634F),
                      size: 22,
                    ),
                    title: Text(
                      'Privacy Policy',
                      style: AppTextStyles.titleSmall
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: AppColors.textTertiary,
                    ),
                    onTap: () {},
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  ListTile(
                    leading: const Icon(
                      Icons.info_outline,
                      color: Color(0xFF2E634F),
                      size: 22,
                    ),
                    title: Text(
                      'About us',
                      style: AppTextStyles.titleSmall
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: AppColors.textTertiary,
                    ),
                    onTap: () {},
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.xxl.h),

            // Delete Account Button
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: const Color(0xFFE8B4B0)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete_outline,
                      color: Color(0xFFB9382F),
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Delete Account',
                      style: TextStyle(
                        color: Color(0xFFB9382F),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
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

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppTextStyles.labelSmall.copyWith(
        color: AppColors.textTertiary,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _buildCardWrapper({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}
