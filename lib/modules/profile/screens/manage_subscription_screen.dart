import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';

class ManageSubscriptionScreen extends StatelessWidget {
  const ManageSubscriptionScreen({super.key});

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
          'Mealist Plus',
          style: AppTextStyles.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF264E3E),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w, vertical: AppSpacing.sm.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Manage Subscription',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: AppSpacing.xs.h),

            // Current Plan Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFE2F0E7),
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle_outline, size: 16, color: Color(0xFF265B46)),
                  SizedBox(width: 6),
                  Text(
                    'Current Plan: Free',
                    style: TextStyle(
                      color: Color(0xFF265B46),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.xl.h),

            // Your Monthly Usage
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Your Monthly Usage',
                style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: AppSpacing.xs.h),

            Container(
              padding: const EdgeInsets.all(AppSpacing.cardPaddingLg),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('AI Plan Generations', style: AppTextStyles.bodyMedium),
                      Text(
                        '2 of 3 used',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    child: const LinearProgressIndicator(
                      value: 2 / 3,
                      minHeight: 8,
                      backgroundColor: Color(0xFFEEEEEE),
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B6E59)),
                    ),
                  ),
                  SizedBox(height: AppSpacing.md.h),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recipe Imports', style: AppTextStyles.bodyMedium),
                      Text(
                        '4 of 5 used',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    child: const LinearProgressIndicator(
                      value: 4 / 5,
                      minHeight: 8,
                      backgroundColor: Color(0xFFEEEEEE),
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B6E59)),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.sectionGap.h),

            // Available Plans
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Available Plans',
                style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: AppSpacing.xs.h),

            // Plan 1: Free
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.cardPaddingLg),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.border),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDEDED),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'CURRENT PLAN',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF555555),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Free', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: '\$0',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            TextSpan(
                              text: '/mo',
                              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildFeatureRow(Icons.check, 'Basic planning'),
                      const SizedBox(height: 8),
                      _buildFeatureRow(Icons.check, '5 recipe imports'),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.md.h),

            // Plan 2: Plus Monthly
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
                  const Text('Plus Monthly', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: '\$9.99',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF265B46),
                          ),
                        ),
                        TextSpan(
                          text: '/mo',
                          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureRow(Icons.check_circle_outline, 'Unlimited planning', iconColor: const Color(0xFF265B46)),
                  const SizedBox(height: 8),
                  _buildFeatureRow(Icons.check_circle_outline, 'Unlimited recipe imports', iconColor: const Color(0xFF265B46)),
                  const SizedBox(height: 8),
                  _buildFeatureRow(Icons.auto_awesome, 'Advanced AI insights', iconColor: const Color(0xFFE28B38)),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B6E59),
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: const Center(
                        child: Text(
                          'Upgrade Monthly',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.md.h),

            // Plan 3: Plus Yearly
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.cardPaddingLg),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: const Color(0xFFEE9748), width: 1.5),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEE9748),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        '★ BEST VALUE',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Plus Yearly', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: '\$79.99',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF265B46),
                              ),
                            ),
                            TextSpan(
                              text: '/yr',
                              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Saves ~\$40 compared to monthly',
                        style: TextStyle(fontSize: 12, color: Color(0xFFEE9748), fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 12),
                      _buildFeatureRow(Icons.check_circle_outline, 'Everything in Monthly', iconColor: const Color(0xFF265B46)),
                      const SizedBox(height: 8),
                      _buildFeatureRow(Icons.science_outlined, 'Early access to new features', iconColor: const Color(0xFFEE9748)),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEE9748),
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                          child: const Center(
                            child: Text(
                              'Upgrade Yearly',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.lg.h),
            const Divider(color: AppColors.divider),
            SizedBox(height: AppSpacing.md.h),

            // Restore Purchases
            TextButton(
              onPressed: () {},
              child: const Text(
                'Restore Purchases',
                style: TextStyle(
                  color: Color(0xFF265B46),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 4),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Subscriptions and cancellations are managed through your App Store account settings.',
                textAlign: TextAlign.center,
                style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary),
              ),
            ),

            SizedBox(height: AppSpacing.md.h),

            // Manage App Store Subscription
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.border),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
              ),
              child: const Text(
                'Manage App Store Subscription',
                style: TextStyle(color: Color(0xFF265B46), fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),

            SizedBox(height: AppSpacing.md.h),

            TextButton(
              onPressed: () {},
              child: const Text(
                'Billing Support',
                style: TextStyle(color: AppColors.textTertiary, fontSize: 12),
              ),
            ),

            SizedBox(height: AppSpacing.xxxl.h),
          ],
        ),
      ),
    );
  }

  static Widget _buildFeatureRow(IconData icon, String text, {Color? iconColor}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor ?? AppColors.textSecondary),
        const SizedBox(width: 8),
        Text(text, style: AppTextStyles.bodyMedium.copyWith(fontSize: 13)),
      ],
    );
  }
}
