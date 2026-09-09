import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mealist_ai/modules/pantry/screens/widgets/quantity_stepper.dart';
import 'package:mealist_ai/modules/pantry/screens/widgets/storage_chip.dart';
import 'package:mealist_ai/modules/pantry/screens/widgets/unit_dropdown.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';
import '../controllers/pantry_controller.dart';
import 'search_pantry_screen.dart';

// add to pantry screen
// allows users to record new ingredients into fridge, freezer, or pantry
class AddToPantryScreen extends StatefulWidget {
  const AddToPantryScreen({super.key});

  @override
  State<AddToPantryScreen> createState() => _AddToPantryScreenState();
}

class _AddToPantryScreenState extends State<AddToPantryScreen> {
  final TextEditingController _ingredientController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController(text: '1');
  String _selectedUnit = 'pcs';
  String _selectedCategory = 'Pantry';
  DateTime? _useByDate;
  bool _showUseByDate = false;

  final List<String> _units = [
    'pcs',
    'g',
    'kg',
    'ml',
    'L',
    'bag',
    'bottle',
    'cup',
    'oz',
    'lb',
  ];
  final List<String> _categories = ['Pantry', 'Fridge', 'Freezer'];

  @override
  void dispose() {
    _ingredientController.dispose();
    _qtyController.dispose();
    super.dispose();
  }

  void _incrementQty() {
    final int current = int.tryParse(_qtyController.text) ?? 1;
    _qtyController.text = (current + 1).toString();
  }

  void _decrementQty() {
    final int current = int.tryParse(_qtyController.text) ?? 1;
    if (current > 1) {
      _qtyController.text = (current - 1).toString();
    }
  }

  Future<void> _pickUseByDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (final ctx, final child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primary,
            onPrimary: AppColors.white,
            surface: AppColors.white,
            onSurface: AppColors.textPrimary,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _useByDate = picked;
        _showUseByDate = true;
      });
    }
  }

  String _formatDate(final DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(final BuildContext context) {
    final PantryController controller = Get.find<PantryController>();

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: Get.back,
        ),
        title: Text(
          'Add to Pantry',
          style: AppTextStyles.headlineSmall.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.screenH.w,
          vertical: AppSpacing.md.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // subtitle
            Text(
              'What would you like to add?',
              style: AppTextStyles.bodyLarge.copyWith(
                //color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: AppSpacing.md.h),

            // search ingredient shortcut
            GestureDetector(
              onTap: () async {
                final result = await Get.to<Map<String, dynamic>?>(
                  () => const SearchPantryScreen(),
                );
                if (result != null && result['name'] != null) {
                  setState(() {
                    _ingredientController.text = result['name'] as String;
                  });
                }
              },
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.border),
                ),
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: AppColors.textTertiary,
                      size: 20,
                    ),
                    SizedBox(width: AppSpacing.xs.w),
                    const Text(
                      'Search for an ingredient',
                      style: AppTextStyles.inputHint,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: AppSpacing.lg.h),

            // --- Add an item section ---
            Text(
              'Add an item',
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: AppSpacing.md.h),

            // ingredient label
            const Text('INGREDIENT', style: AppTextStyles.labelSmall),
            SizedBox(height: AppSpacing.xs.h),

            // ingredient text input
            TextField(
              controller: _ingredientController,
              style: AppTextStyles.inputText,
              decoration: InputDecoration(
                hintText: 'e.g. Olive Oil',
                hintStyle: AppTextStyles.inputHint,
                filled: true,
                fillColor: AppColors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md.w,
                  vertical: AppSpacing.sm.h,
                ),
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
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
              ),
            ),

            SizedBox(height: AppSpacing.md.h),

            // quantity + unit row
            Row(
              children: [
                // QUANTITY label + stepper
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('QUANTITY', style: AppTextStyles.labelSmall),
                      SizedBox(height: AppSpacing.xs.h),
                      QuantityStepper(
                        controller: _qtyController,
                        onDecrement: _decrementQty,
                        onIncrement: _incrementQty,
                      ),
                    ],
                  ),
                ),

                SizedBox(width: AppSpacing.md.w),

                // UNIT label + dropdown
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('UNIT', style: AppTextStyles.labelSmall),
                      SizedBox(height: AppSpacing.xs.h),
                      UnitDropdown(
                        units: _units,
                        selectedUnit: _selectedUnit,
                        onChanged: (final val) {
                          if (val != null) {
                            setState(() => _selectedUnit = val);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSpacing.md.h),

            // storage location label
            const Text('STORAGE LOCATION', style: AppTextStyles.labelSmall),
            SizedBox(height: AppSpacing.xs.h),

            // location chips
            Row(
              children: _categories.map((final cat) {
                final bool isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: StorageChip(
                    label: cat,
                    isSelected: isSelected,
                    onTap: () => setState(() => _selectedCategory = cat),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: AppSpacing.md.h),

            // use-by date toggle row
            GestureDetector(
              onTap: () {
                if (_showUseByDate) {
                  setState(() {
                    _showUseByDate = false;
                    _useByDate = null;
                  });
                } else {
                  _pickUseByDate();
                }
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: AppSpacing.xxs.w),
                  Text(
                    _showUseByDate && _useByDate != null
                        ? 'Use by: ${_formatDate(_useByDate!)}'
                        : 'Add use-by date',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.xxxl.h),

            // submit button
            PrimaryButtonWidget(
              label: '+ Add to Pantry',
              onTap: () {
                final String name = _ingredientController.text.trim();
                final String qty = _qtyController.text.trim();
                if (name.isNotEmpty) {
                  controller.addItem(
                    name: name,
                    category: _selectedCategory,
                    qty: qty.isEmpty ? '1' : qty,
                    unit: _selectedUnit,
                    useBy: _useByDate != null ? _formatDate(_useByDate!) : null,
                  );
                  Get.back();
                  Get.snackbar(
                    'Added!',
                    '$name added to $_selectedCategory.',
                    backgroundColor: AppColors.white,
                    colorText: AppColors.textPrimary,
                    snackPosition: SnackPosition.BOTTOM,
                    margin: const EdgeInsets.all(AppSpacing.md),
                  );
                }
              },
            ),

            SizedBox(height: AppSpacing.md.h),
          ],
        ),
      ),
    );
  }
}
