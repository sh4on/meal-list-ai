import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';

class ShareYourWeekScreen extends StatefulWidget {
  const ShareYourWeekScreen({super.key});

  @override
  State<ShareYourWeekScreen> createState() => _ShareYourWeekScreenState();
}

class _ShareYourWeekScreenState extends State<ShareYourWeekScreen> {
  bool _shareCookingProgress = true;
  bool _shareStreak = true;
  bool _shareNutrition = false;
  bool _shareWeight = false;

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
          'Share Your Week',
          style: AppTextStyles.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF264E3E),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w, vertical: AppSpacing.sm.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Choose exactly what you want to share.',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
            ),
            SizedBox(height: AppSpacing.lg.h),

            // Card: Your Mealist Week
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFFCFAF7),
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Your Mealist Week',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppSpacing.lg.h),
                  const Text(
                    '5',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2A5946),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'MEALS COOKED',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const SizedBox(
                    width: 60,
                    child: Divider(height: 1, color: AppColors.divider),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '6',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2A5946),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'MEALS PLANNED',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const SizedBox(
                    width: 60,
                    child: Divider(height: 1, color: AppColors.divider),
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.local_fire_department, color: Color(0xFFE08744), size: 24),
                      SizedBox(width: 4),
                      Text(
                        '4',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE08744),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'WEEK STREAK',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.sectionGap.h),

            // CARD DATA
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'CARD DATA',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textTertiary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            SizedBox(height: AppSpacing.xs.h),

            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  SwitchListTile.adaptive(
                    title: Text('Cooking progress', style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                    value: _shareCookingProgress,
                    activeTrackColor: const Color(0xFF3B6E59),
                    onChanged: (v) => setState(() => _shareCookingProgress = v),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  SwitchListTile.adaptive(
                    title: Text('Streak', style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                    value: _shareStreak,
                    activeTrackColor: const Color(0xFF3B6E59),
                    onChanged: (v) => setState(() => _shareStreak = v),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  SwitchListTile.adaptive(
                    title: Text('Nutrition', style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                    value: _shareNutrition,
                    activeTrackColor: const Color(0xFF3B6E59),
                    onChanged: (v) => setState(() => _shareNutrition = v),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  SwitchListTile.adaptive(
                    title: Text('Weight', style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                    value: _shareWeight,
                    activeTrackColor: const Color(0xFF3B6E59),
                    onChanged: (v) => setState(() => _shareWeight = v),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.md.h),

            // Info Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F3),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, size: 18, color: AppColors.textSecondary),
                  const SizedBox(width: 8),
                  Text(
                    'Nutrition and weight are hidden by default.',
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.xxl.h),

            // Share Button
            PrimaryButtonWidget(
              label: 'Share',
              onTap: () {
                Get.snackbar('Shared', 'Your weekly recap has been prepared for sharing!');
              },
            ),

            SizedBox(height: AppSpacing.xxxl.h),
          ],
        ),
      ),
    );
  }
}
