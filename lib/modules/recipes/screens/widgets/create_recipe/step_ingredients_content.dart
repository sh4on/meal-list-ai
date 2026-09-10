import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../controllers/recipe_creator_controller.dart';

// step 2 — ingredients
// each row is divided into three sections by vertical lines: name | qty | unit
// this exactly matches the Figma design with consistent fixed row height
class StepIngredientsContent extends StatelessWidget {
  final RecipeCreatorController ctrl;

  const StepIngredientsContent({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSpacing.lg.h),

        // existing ingredient rows — reactive to controller list changes
        Obx(
          () => Column(
            children: ctrl.ingredients.asMap().entries.map((final entry) {
              return _IngredientRow(
                ingredient: entry.value,
                onRemove: () => ctrl.removeIngredient(entry.key),
                // ingredient unit is mutable per-row so we need index for updates
                onUnitChanged: (final String unit) {
                  final Map<String, String> updated = {
                    ...entry.value,
                    'unit': unit,
                  };
                  ctrl.ingredients[entry.key] = updated;
                },
              );
            }).toList(),
          ),
        ),

        // empty "add new ingredient" row — always visible below existing list
        _NewIngredientRow(ctrl: ctrl),

        SizedBox(height: AppSpacing.sm.h),

        // dashed "+ Add ingredient" button matching Figma
        _AddIngredientButton(ctrl: ctrl),

        SizedBox(height: AppSpacing.lg.h),

        // smart suggestion AI card
        const _SmartSuggestionCard(),

        SizedBox(height: AppSpacing.xxl.h),
      ],
    );
  }
}

// a single ingredient row with three sections divided by vertical lines:
// [🔍 name] | [bold qty] | [unit ▾] [×]
class _IngredientRow extends StatelessWidget {
  final Map<String, String> ingredient;
  final VoidCallback onRemove;
  final ValueChanged<String> onUnitChanged;

  const _IngredientRow({
    required this.ingredient,
    required this.onRemove,
    required this.onUnitChanged,
  });

  @override
  Widget build(BuildContext context) {
    final String currentUnit =
        RecipeCreatorController.units.contains(ingredient['unit'])
            ? ingredient['unit']!
            : 'g';

    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.xs.h),
      height: 52.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // section 1: search icon + ingredient name (takes most space)
          SizedBox(width: AppSpacing.sm.w),
          const Icon(Icons.search, color: AppColors.textTertiary, size: 16),
          SizedBox(width: AppSpacing.xs.w),
          Expanded(
            child: Text(
              ingredient['name'] ?? '',
              style: AppTextStyles.titleSmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // vertical divider between name and qty
          const _VerticalDivider(),

          // section 2: quantity — bold, centered, fixed width
          SizedBox(
            width: 64.w,
            child: Center(
              child: Text(
                ingredient['qty'] ?? '',
                style: AppTextStyles.titleSmall.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          // vertical divider between qty and unit
          const _VerticalDivider(),

          // section 3: unit dropdown + remove icon
          SizedBox(
            width: 80.w,
            child: Row(
              children: [
                SizedBox(width: AppSpacing.xs.w),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: currentUnit,
                      isDense: true,
                      isExpanded: true,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      items: RecipeCreatorController.units
                          .map(
                            (final String u) => DropdownMenuItem<String>(
                              value: u,
                              child: Text(u),
                            ),
                          )
                          .toList(),
                      onChanged: (final String? val) {
                        if (val != null) onUnitChanged(val);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // remove × icon outside the unit section
          GestureDetector(
            onTap: onRemove,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs.w),
              child: const Icon(
                Icons.close,
                size: 16,
                color: AppColors.textTertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// the empty new-ingredient row shown below existing ingredients
// layout mirrors _IngredientRow but uses placeholder text and no × button
class _NewIngredientRow extends StatefulWidget {
  final RecipeCreatorController ctrl;

  const _NewIngredientRow({required this.ctrl});

  @override
  State<_NewIngredientRow> createState() => _NewIngredientRowState();
}

class _NewIngredientRowState extends State<_NewIngredientRow> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _qtyCtrl = TextEditingController();
  String _selectedUnit = 'g';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _qtyCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final String name = _nameCtrl.text.trim();
    if (name.isEmpty) return;
    widget.ctrl.addIngredient(name, _qtyCtrl.text.trim(), _selectedUnit);
    _nameCtrl.clear();
    _qtyCtrl.clear();
    setState(() => _selectedUnit = 'g');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // section 1: search icon + name input
          SizedBox(width: AppSpacing.sm.w),
          const Icon(Icons.search, color: AppColors.textTertiary, size: 16),
          SizedBox(width: AppSpacing.xs.w),
          Expanded(
            child: TextField(
              controller: _nameCtrl,
              style: AppTextStyles.titleSmall,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
              decoration: const InputDecoration(
                hintText: 'e.g., Garlic',
                hintStyle: AppTextStyles.inputHint,
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),

          // vertical divider
          const _VerticalDivider(),

          // section 2: qty input — bold placeholder "Qty"
          SizedBox(
            width: 64.w,
            child: TextField(
              controller: _qtyCtrl,
              style: AppTextStyles.titleSmall.copyWith(
                fontWeight: FontWeight.w700,
              ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                hintText: 'Qty',
                hintStyle: AppTextStyles.titleSmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textTertiary,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),

          // vertical divider
          const _VerticalDivider(),

          // section 3: unit dropdown — shows "Unit" as hint when no selection
          SizedBox(
            width: 90.w,
            child: Padding(
              padding: EdgeInsets.only(left: AppSpacing.xs.w),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedUnit,
                  isDense: true,
                  isExpanded: true,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  items: RecipeCreatorController.units
                      .map(
                        (final String u) => DropdownMenuItem<String>(
                          value: u,
                          child: Text(u),
                        ),
                      )
                      .toList(),
                  onChanged: (final String? val) {
                    if (val != null) setState(() => _selectedUnit = val);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// dashed-border "+ Add ingredient" button matching the Figma design
class _AddIngredientButton extends StatelessWidget {
  final RecipeCreatorController ctrl;

  const _AddIngredientButton({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // adds an empty row that the user can fill in
      onTap: () => ctrl.addIngredient('New Ingredient', '100', 'g'),
      child: Container(
        width: double.infinity,
        height: 52.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.md),
          // dashed border drawn via a CustomPaint overlay
          color: Colors.transparent,
        ),
        child: CustomPaint(
          painter: const _DashedBorderPainter(
            color: AppColors.border,
            radius: AppRadius.md,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add,
                color: AppColors.primary,
                size: AppSpacing.iconSm,
              ),
              // responsive horizontal spacing between icon and text label
              SizedBox(width: AppSpacing.xs.w),
              Text(
                'Add ingredient',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// thin vertical line used as a column separator inside each ingredient row
class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 24.h,
      color: AppColors.border,
    );
  }
}

// smart suggestion AI card — accent surface with sparkle icon and suggestion text
class _SmartSuggestionCard extends StatelessWidget {
  const _SmartSuggestionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.accentSurface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.accent),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header: sparkle icon + "SMART SUGGESTION" uppercase label
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: AppColors.accent, size: 14),
              SizedBox(width: AppSpacing.xs.w),
              Text(
                'SMART SUGGESTION',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),

          SizedBox(height: AppSpacing.xs.h),

          // suggestion body text
          const Text(
            'Adding a splash of lemon juice or zest can elevate the flavor profile of chicken and brown rice.',
            style: AppTextStyles.bodySmall,
          ),

          SizedBox(height: AppSpacing.sm.h),

          // "Add Lemon ⊕" action — accent colored
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  'Add Lemon',
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.add_circle_outline,
                  color: AppColors.accent,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// custom painter that draws a dashed rounded rectangle border
// used for the "+ Add ingredient" button to match the Figma dashed outline
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;

  const _DashedBorderPainter({required this.color, required this.radius});

  @override
  void paint(final Canvas canvas, final Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    const double dashWidth = 6;
    const double dashSpace = 4;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final Path path = Path()..addRRect(rrect);
    final ui.PathMetrics metrics = path.computeMetrics();

    for (final ui.PathMetric metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(
            distance,
            distance + dashWidth,
          ),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
