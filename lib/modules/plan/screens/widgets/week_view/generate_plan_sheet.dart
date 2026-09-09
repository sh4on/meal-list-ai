import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../routes/app_routes.dart';

void showGeneratePlanSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => const GeneratePlanSheet(),
  );
}

class GeneratePlanSheet extends StatefulWidget {
  const GeneratePlanSheet({super.key});

  @override
  State<GeneratePlanSheet> createState() => _GeneratePlanSheetState();
}

class _GeneratePlanSheetState extends State<GeneratePlanSheet> {
  String _selectedRange = 'Next 3 days';
  final Set<String> _selectedMealTypes = {'Breakfast', 'Lunch', 'Dinner'};
  bool _keepPlanned = true;
  bool _keepFavourites = false;

  final List<String> _ranges = [
    'Rest of today',
    'Tomorrow',
    'Next 3 days',
    'Next 7 days',
  ];

  final List<String> _mealTypes = ['Breakfast', 'Lunch', 'Snacks', 'Dinner'];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.92,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(AppRadius.xxl)),
          ),
          child: ListView(
            controller: scrollController,
            padding: EdgeInsets.zero,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.screenH.w,
                  AppSpacing.md.h,
                  AppSpacing.screenH.w,
                  0,
                ),
                child: Row(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Generate a plan',
                          style: AppTextStyles.headlineSmall,
                        ),
                        Text(
                          'Tell Mealist what you want planned.',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSpacing.lg.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WHAT SHOULD WE PLAN?',
                      style:
                          AppTextStyles.labelSmall.copyWith(letterSpacing: 1.2),
                    ),
                    SizedBox(height: AppSpacing.xs.h),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 3.5,
                      children: _ranges.map((r) {
                        final selected = _selectedRange == r;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedRange = r),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.primary
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                              border: Border.all(
                                color: selected
                                    ? AppColors.primary
                                    : AppColors.border,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (selected)
                                  const Padding(
                                    padding: EdgeInsets.only(right: 4),
                                    child: Icon(
                                      Icons.check,
                                      color: AppColors.white,
                                      size: 14,
                                    ),
                                  ),
                                Text(
                                  r,
                                  style: AppTextStyles.labelLarge.copyWith(
                                    color: selected
                                        ? AppColors.white
                                        : AppColors.textPrimary,
                                    fontWeight: selected
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSpacing.lg.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MEAL TYPES',
                      style:
                          AppTextStyles.labelSmall.copyWith(letterSpacing: 1.2),
                    ),
                    SizedBox(height: AppSpacing.xs.h),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _mealTypes.map((mt) {
                        final selected = _selectedMealTypes.contains(mt);
                        return GestureDetector(
                          onTap: () => setState(() {
                            if (selected) {
                              _selectedMealTypes.remove(mt);
                            } else {
                              _selectedMealTypes.add(mt);
                            }
                          }),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.primary
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                              border: Border.all(
                                color: selected
                                    ? AppColors.primary
                                    : AppColors.border,
                              ),
                            ),
                            child: Text(
                              mt,
                              style: AppTextStyles.labelLarge.copyWith(
                                color: selected
                                    ? AppColors.white
                                    : AppColors.textPrimary,
                                fontWeight: selected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSpacing.lg.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'KEEP OR REPLACE',
                      style:
                          AppTextStyles.labelSmall.copyWith(letterSpacing: 1.2),
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
                          ToggleRow(
                            title: "Keep meals I've already planned",
                            subtitle: 'Only fill the empty slots',
                            value: _keepPlanned,
                            onChanged: (v) => setState(() => _keepPlanned = v),
                          ),
                          const Divider(
                            color: AppColors.divider,
                            height: 1,
                            indent: 16,
                            endIndent: 16,
                          ),
                          ToggleRow(
                            title: "Keep meals I've marked as favourites",
                            subtitle: '',
                            value: _keepFavourites,
                            onChanged: (v) =>
                                setState(() => _keepFavourites = v),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSpacing.lg.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.cardPadding),
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border:
                        Border.all(color: AppColors.primary.withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.auto_awesome,
                            color: AppColors.primary,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Mealist will use',
                            style: AppTextStyles.titleSmall
                                .copyWith(color: AppColors.primary),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSpacing.sm.h),
                      ...[
                        (true, 'Goals: High protein'),
                        (true, 'Nutrition targets: Low carb'),
                        (true, 'Dietary preferences: Mediterranean'),
                        (true, 'Favourite cuisines: Italian, Greek, Japanese'),
                        (false, 'Allergies / restrictions: Peanuts, Shellfish'),
                        (true, 'Cooking time: 15-30 min'),
                        (true, 'Household size: 2 adults'),
                        (true, 'Pantry inventory: 14 items, 3 near expiry'),
                      ].map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            children: [
                              Icon(
                                item.$1 ? Icons.check : Icons.block_outlined,
                                size: 14,
                                color: item.$1
                                    ? AppColors.primary
                                    : AppColors.error,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  item.$2,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: item.$1
                                        ? AppColors.textPrimary
                                        : AppColors.error,
                                    fontWeight: item.$1
                                        ? FontWeight.w400
                                        : FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.lg.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: AppSpacing.buttonHeight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          Get.toNamed(AppRoutes.buildingPlan);
                        },
                        icon: const Icon(
                          Icons.auto_awesome,
                          color: AppColors.white,
                          size: 18,
                        ),
                        label: const Text(
                          'Generate plan',
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
                    SizedBox(height: AppSpacing.xs.h),
                    Text(
                      'You can edit, swap or regenerate any meal after.',
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.textTertiary),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom + AppSpacing.md.h,
              ),
            ],
          ),
        );
      },
    );
  }
}

class ToggleRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  const ToggleRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.cardPadding,
        vertical: 12,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.titleSmall),
                if (subtitle.isNotEmpty)
                  Text(subtitle, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
