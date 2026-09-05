import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';

// manage subscription screen
// presents user membership status, premium tier benefits, and renewal details
class ManageSubscriptionScreen extends StatefulWidget {
  const ManageSubscriptionScreen({super.key});

  @override
  State<ManageSubscriptionScreen> createState() =>
      _ManageSubscriptionScreenState();
}

class _ManageSubscriptionScreenState extends State<ManageSubscriptionScreen> {
  bool _isAnnual = true;

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
        title: const Text('Subscription', style: AppTextStyles.headlineSmall),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSpacing.md.h),

            // active subscription card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.cardPaddingLg),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.primary, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Mealist Pro',
                          style: AppTextStyles.displayMedium,),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primarySurface,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Text(
                          'ACTIVE',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Renews automatically on September 24, 2026',
                    style: AppTextStyles.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _isAnnual ? '\$79.99 / year' : '\$9.99 / month',
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.xl.h),

            // pro benefits list
            const Text('Pro Features Included',
                style: AppTextStyles.headlineSmall,),
            SizedBox(height: AppSpacing.md.h),

            const _BenefitRow(text: 'Unlimited AI Meal Plan Generation'),
            const _BenefitRow(text: 'Smart Pantry Sync & Expiry Warnings'),
            const _BenefitRow(text: 'Automatic Macro Optimization'),
            const _BenefitRow(text: 'Interactive Cook Mode with Voice Support'),
            const _BenefitRow(
              text: 'Export Grocery Lists to Instacart / Reminders',
            ),

            SizedBox(height: AppSpacing.xl.h),

            // billing interval toggle
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardBgSecondary,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _isAnnual = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color:
                              !_isAnnual ? AppColors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        child: const Text(
                          'Monthly',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.titleSmall,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _isAnnual = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color:
                              _isAnnual ? AppColors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        child: Text(
                          'Annual (Save 33%)',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.titleSmall.copyWith(
                            color: _isAnnual
                                ? AppColors.primary
                                : AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.xl.h),

            PrimaryButtonWidget(
              label: 'Manage Plan',
              onTap: () {
                Get.snackbar(
                  'Subscription Active',
                  'Your Mealist Pro subscription is active.',
                  backgroundColor: AppColors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  margin: const EdgeInsets.all(AppSpacing.md),
                );
              },
            ),

            SizedBox(height: AppSpacing.md.h),

            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Restore Purchases',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),

            SizedBox(height: AppSpacing.xl.h),
          ],
        ),
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  final String text;
  const _BenefitRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: AppColors.primary,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text, style: AppTextStyles.bodyMedium),
          ),
        ],
      ),
    );
  }
}
