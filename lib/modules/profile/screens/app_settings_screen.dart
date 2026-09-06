import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  bool _mealPlanReminders = true;
  bool _shoppingReminders = true;
  bool _cookingReminders = false;
  bool _pantryReminders = true;
  bool _progressReminders = false;

  bool _isMetric = true;

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
          'Settings',
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
            // MEAL SCHEDULE
            _buildSectionHeader('MEAL SCHEDULE'),
            SizedBox(height: AppSpacing.xs.h),
            _buildCardWrapper(
              child: Column(
                children: [
                  _buildScheduleRow(
                    icon: Icons.wb_sunny_outlined,
                    label: 'Breakfast',
                    time: '08:00 AM',
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  _buildScheduleRow(
                    icon: Icons.wb_sunny,
                    label: 'Lunch',
                    time: '12:30 PM',
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  _buildScheduleRow(
                    icon: Icons.nightlight_round,
                    label: 'Dinner',
                    time: '07:00 PM',
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.sectionGap.h),

            // NOTIFICATIONS
            _buildSectionHeader('NOTIFICATIONS'),
            SizedBox(height: AppSpacing.xs.h),
            _buildCardWrapper(
              child: Column(
                children: [
                  _buildSwitchRow(
                    label: 'Meal plan reminders',
                    value: _mealPlanReminders,
                    onChanged: (v) => setState(() => _mealPlanReminders = v),
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  _buildSwitchRow(
                    label: 'Shopping reminders',
                    value: _shoppingReminders,
                    onChanged: (v) => setState(() => _shoppingReminders = v),
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  _buildSwitchRow(
                    label: 'Cooking reminders',
                    value: _cookingReminders,
                    onChanged: (v) => setState(() => _cookingReminders = v),
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  _buildSwitchRow(
                    label: 'Pantry reminders',
                    value: _pantryReminders,
                    onChanged: (v) => setState(() => _pantryReminders = v),
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  _buildSwitchRow(
                    label: 'Progress reminders',
                    value: _progressReminders,
                    onChanged: (v) => setState(() => _progressReminders = v),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.sectionGap.h),

            // UNITS
            _buildSectionHeader('UNITS'),
            SizedBox(height: AppSpacing.xs.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _isMetric = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _isMetric ? const Color(0xFF3B6E59) : Colors.transparent,
                          borderRadius: BorderRadius.circular(AppRadius.md - 2),
                        ),
                        child: Center(
                          child: Text(
                            'Metric',
                            style: TextStyle(
                              color: _isMetric ? AppColors.white : AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _isMetric = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: !_isMetric ? const Color(0xFF3B6E59) : Colors.transparent,
                          borderRadius: BorderRadius.circular(AppRadius.md - 2),
                        ),
                        child: Center(
                          child: Text(
                            'Imperial',
                            style: TextStyle(
                              color: !_isMetric ? AppColors.white : AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.sectionGap.h),

            // PREFERENCES
            _buildSectionHeader('PREFERENCES'),
            SizedBox(height: AppSpacing.xs.h),
            _buildCardWrapper(
              child: Column(
                children: [
                  _buildNavRow(
                    icon: Icons.language,
                    label: 'Language',
                    value: 'English',
                    onTap: () {},
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  _buildNavRow(
                    icon: Icons.palette_outlined,
                    label: 'Appearance',
                    value: 'System',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.sectionGap.h),

            // PRIVACY & ACCOUNT
            _buildSectionHeader('PRIVACY & ACCOUNT'),
            SizedBox(height: AppSpacing.xs.h),
            _buildCardWrapper(
              child: Column(
                children: [
                  _buildSimpleNavRow(
                    label: 'Account Settings',
                    onTap: () => Get.toNamed(AppRoutes.accountSettings),
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  _buildSimpleNavRow(
                    label: 'Privacy Controls',
                    onTap: () {},
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  ListTile(
                    title: const Text('Export Data', style: AppTextStyles.titleSmall),
                    trailing: const Icon(Icons.download_outlined, color: AppColors.textSecondary, size: 20),
                    onTap: () {},
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  _buildSimpleNavRow(
                    label: 'Model-training consent',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.xxl.h),

            // Log out button
            Center(
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout, color: Color(0xFFB9382F), size: 20),
                label: const Text(
                  'Log Out',
                  style: TextStyle(
                    color: Color(0xFFB9382F),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),

            SizedBox(height: AppSpacing.xs.h),
            Center(
              child: Text(
                'Deleting your account is permanent and cannot be undone.',
                style: AppTextStyles.labelSmall.copyWith(color: AppColors.textTertiary),
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

  Widget _buildScheduleRow({required IconData icon, required String label, required String time}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondary, size: 20),
      title: Text(label, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFE5F2EB),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          time,
          style: const TextStyle(
            color: Color(0xFF265B46),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    );
  }

  Widget _buildSwitchRow({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile.adaptive(
      title: Text(label, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
      value: value,
      activeTrackColor: const Color(0xFF3B6E59),
      onChanged: onChanged,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    );
  }

  Widget _buildNavRow({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondary, size: 20),
      title: Text(label, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right, size: 18, color: AppColors.textTertiary),
        ],
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    );
  }

  Widget _buildSimpleNavRow({required String label, required VoidCallback onTap}) {
    return ListTile(
      title: Text(label, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
      trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.textTertiary),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    );
  }
}
