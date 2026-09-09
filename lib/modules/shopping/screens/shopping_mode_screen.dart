import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import 'widgets/shopping_mode/shopping_mode_row.dart';

// Shopping Mode screen -- streamlined in-store checklist
class ShoppingModeScreen extends StatefulWidget {
  const ShoppingModeScreen({super.key});

  @override
  State<ShoppingModeScreen> createState() => _ShoppingModeScreenState();
}

class _ShoppingModeScreenState extends State<ShoppingModeScreen> {
  final List<Map<String, dynamic>> _toGet = [
    {'name': 'Chicken', 'qty': '800 g', 'checked': false},
    {'name': 'Tomatoes', 'qty': '6', 'checked': false},
    {'name': 'Milk', 'qty': '1 L', 'checked': false},
    {'name': 'Rice', 'qty': '600 g', 'checked': false},
  ];

  final List<Map<String, dynamic>> _collected = [
    {'name': 'Eggs', 'qty': '12', 'checked': true},
    {'name': 'Bread', 'qty': '1 loaf', 'checked': true},
  ];

  int get _totalItems => _toGet.length + _collected.length;
  int get _collectedCount => _collected.length;

  double get _progress => _totalItems == 0 ? 0 : _collectedCount / _totalItems;

  int get _percentComplete => (_progress * 100).round();

  void _toggleToGet(int index) {
    setState(() {
      final item = Map<String, dynamic>.from(_toGet[index]);
      item['checked'] = true;
      _toGet.removeAt(index);
      _collected.add(item);
    });
  }

  void _clearAllCollected() {
    setState(() {
      for (final item in _collected) {
        item['checked'] = false;
        _toGet.add(item);
      }
      _collected.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(
        children: [
          // ── App Bar ─────────────────────────────────────────────────────
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.screenH.w,
                vertical: AppSpacing.sm.h,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: const Icon(
                      Icons.close,
                      color: AppColors.textPrimary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shopping',
                          style: AppTextStyles.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$_collectedCount / $_totalItems items',
                        style: AppTextStyles.titleSmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '$_percentComplete% complete',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ── Progress bar ─────────────────────────────────────────────────
          LinearProgressIndicator(
            value: _progress,
            backgroundColor: AppColors.progressTrack,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            minHeight: 3,
          ),

          // ── Body Checklist ───────────────────────────────────────────────
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.screenH.w,
                vertical: AppSpacing.md.h,
              ),
              children: [
                if (_toGet.isNotEmpty) ...[
                  Text(
                    'TO GET (${_toGet.length})',
                    style: AppTextStyles.sectionHeader,
                  ),
                  SizedBox(height: AppSpacing.sm.h),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        for (int i = 0; i < _toGet.length; i++)
                          ShoppingModeRow(
                            name: _toGet[i]['name'] as String,
                            qty: _toGet[i]['qty'] as String,
                            isChecked: false,
                            isLast: i == _toGet.length - 1,
                            onTap: () => _toggleToGet(i),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSpacing.lg.h),
                ],
                if (_collected.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'COLLECTED (${_collected.length})',
                        style: AppTextStyles.sectionHeader,
                      ),
                      TextButton(
                        onPressed: _clearAllCollected,
                        child: Text(
                          'Clear all',
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
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
                        for (int i = 0; i < _collected.length; i++)
                          ShoppingModeRow(
                            name: _collected[i]['name'] as String,
                            qty: _collected[i]['qty'] as String,
                            isChecked: true,
                            isLast: i == _collected.length - 1,
                            onTap: () {},
                          ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // ── Finish Shopping Button ───────────────────────────────────────
          SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.screenH.w,
                AppSpacing.sm.h,
                AppSpacing.screenH.w,
                AppSpacing.md.h,
              ),
              child: SizedBox(
                width: double.infinity,
                height: AppSpacing.buttonHeight,
                child: ElevatedButton.icon(
                  onPressed: () => Get.toNamed(AppRoutes.finishShopping),
                  icon: const Icon(
                    Icons.check_circle_outline,
                    color: AppColors.white,
                    size: 20,
                  ),
                  label: const Text(
                    'Finish Shopping',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
