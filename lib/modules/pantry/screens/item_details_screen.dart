import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mealist_ai/modules/pantry/screens/widgets/date_row.dart';
import 'package:mealist_ai/modules/pantry/screens/widgets/quantity_row.dart';
import 'package:mealist_ai/modules/pantry/screens/widgets/remove_confirmation_sheet.dart';
import 'package:mealist_ai/modules/pantry/screens/widgets/section_label.dart';
import 'package:mealist_ai/modules/pantry/screens/widgets/storage_toggle_chip.dart';
import 'package:mealist_ai/modules/pantry/screens/widgets/urgency_pill.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';
import '../controllers/pantry_controller.dart';

// item details screen
// shows the full details for a pantry item with quantity, storage, dates,
// and options to save changes or remove from pantry
class ItemDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const ItemDetailsScreen({super.key, required this.item});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  late TextEditingController _qtyController;
  late String _selectedStorage;
  late String _unit;
  DateTime? _useByDate;

  final List<String> _storageOptions = ['Fridge', 'Freezer', 'Pantry'];

  @override
  void initState() {
    super.initState();
    _qtyController =
        TextEditingController(text: widget.item['qty']?.toString() ?? '1');
    _selectedStorage = (widget.item['storedIn'] as String?) ?? 'Pantry';
    _unit = (widget.item['unit'] as String?) ?? 'g';
    final String? useByStr = widget.item['useBy'] as String?;
    if (useByStr != null) {
      _useByDate = DateTime.tryParse(useByStr);
    }
  }

  @override
  void dispose() {
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

  String _displayDate(final String? raw) {
    if (raw == null || raw.isEmpty) return '—';
    final DateTime? dt = DateTime.tryParse(raw);
    if (dt == null) return raw;
    const List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
  }

  String _formatDate(final DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }

  Future<void> _pickUseByDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _useByDate ?? DateTime.now().add(const Duration(days: 7)),
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
      setState(() => _useByDate = picked);
    }
  }

  void _showRemoveSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => RemoveConfirmationSheet(
        itemName: widget.item['name'] as String,
        onConfirm: () {
          final PantryController controller = Get.find<PantryController>();
          controller.removeItem(widget.item);
          Get.back(); // close sheet
          Get.back(); // pop details screen
          Get.snackbar(
            'Removed',
            '${widget.item['name']} removed from your pantry.',
            backgroundColor: AppColors.white,
            colorText: AppColors.textPrimary,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(AppSpacing.md),
          );
        },
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    final String name = widget.item['name'] as String? ?? '';
    final String? imageUrl = widget.item['image'] as String?;
    final String? urgency = widget.item['urgency'] as String?;
    final String? addedOn = widget.item['addedOn'] as String?;
    final String? useByRaw = widget.item['useBy'] as String?;
    final bool hasUseBy = useByRaw != null && useByRaw.isNotEmpty;

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
          'Item Details',
          style: AppTextStyles.headlineSmall.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.screenH.w,
                vertical: AppSpacing.md.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // item hero image
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      child: imageUrl != null
                          ? CachedNetworkImage(
                              imageUrl: imageUrl,
                              width: 140.w,
                              height: 140.w,
                              fit: BoxFit.cover,
                              placeholder: (_, __) =>
                                  Container(color: AppColors.shimmerBase),
                              errorWidget: (_, __, ___) => _fallbackHero(),
                            )
                          : _fallbackHero(),
                    ),
                  ),

                  SizedBox(height: AppSpacing.md.h),

                  // item name
                  Center(
                    child: Text(
                      name,
                      style: AppTextStyles.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // urgency badge
                  if (urgency != null) ...[
                    SizedBox(height: AppSpacing.xs.h),
                    Center(child: UrgencyPill(text: urgency)),
                  ],

                  SizedBox(height: AppSpacing.lg.h),

                  // quantity section
                  const SectionLabel(label: 'QUANTITY'),
                  SizedBox(height: AppSpacing.xs.h),
                  QuantityRow(
                    controller: _qtyController,
                    unit: _unit,
                    onDecrement: _decrementQty,
                    onIncrement: _incrementQty,
                  ),

                  SizedBox(height: AppSpacing.lg.h),

                  // stored in section
                  const SectionLabel(label: 'STORED IN'),
                  SizedBox(height: AppSpacing.xs.h),
                  Row(
                    children: _storageOptions.map((final s) {
                      final bool isSel = _selectedStorage == s;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: StorageToggleChip(
                          label: s,
                          isSelected: isSel,
                          onTap: () => setState(() => _selectedStorage = s),
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: AppSpacing.lg.h),

                  // dates section
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        DateRow(
                          label: 'ADDED ON',
                          value: _displayDate(addedOn),
                          hasWarning: false,
                        ),
                        const Divider(height: 1, color: AppColors.divider),
                        DateRow(
                          label: 'USE BY',
                          value: _useByDate != null
                              ? _displayDate(_formatDate(_useByDate!))
                              : _displayDate(useByRaw),
                          hasWarning: hasUseBy,
                          onTap: _pickUseByDate,
                          isEditable: true,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: AppSpacing.lg.h),

                  // remove link
                  Center(
                    child: GestureDetector(
                      onTap: _showRemoveSheet,
                      child: Text(
                        'Remove from Pantry',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.error,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: AppSpacing.lg.h),
                ],
              ),
            ),
          ),

          // save changes button pinned at bottom
          Container(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.screenH.w,
              AppSpacing.sm.h,
              AppSpacing.screenH.w,
              AppSpacing.xl.h,
            ),
            decoration: const BoxDecoration(
              color: AppColors.bg,
              border: Border(top: BorderSide(color: AppColors.divider)),
            ),
            child: PrimaryButtonWidget(
              label: 'Save Changes',
              onTap: () {
                final PantryController controller =
                    Get.find<PantryController>();
                final Map<String, dynamic> updated = {
                  ...widget.item,
                  'qty': _qtyController.text.trim(),
                  'storedIn': _selectedStorage,
                  'useBy':
                      _useByDate != null ? _formatDate(_useByDate!) : useByRaw,
                };
                controller.updateItem(widget.item, updated);
                Get.back();
                Get.snackbar(
                  'Saved',
                  '$name updated successfully.',
                  backgroundColor: AppColors.white,
                  colorText: AppColors.textPrimary,
                  snackPosition: SnackPosition.BOTTOM,
                  margin: const EdgeInsets.all(AppSpacing.md),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _fallbackHero() {
    return Container(
      width: 140.w,
      height: 140.w,
      decoration: BoxDecoration(
        color: AppColors.cardBgSecondary,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: const Icon(
        Icons.restaurant,
        size: 48,
        color: AppColors.textTertiary,
      ),
    );
  }
}
