import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mealist_ai/modules/pantry/screens/widgets/urgency_badge.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../controllers/pantry_controller.dart';

// search pantry screen
// lets users search across all stored ingredients and tap one for item details
class SearchPantryScreen extends StatefulWidget {
  const SearchPantryScreen({super.key});

  @override
  State<SearchPantryScreen> createState() => _SearchPantryScreenState();
}

class _SearchPantryScreenState extends State<SearchPantryScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _results = [];

  late final PantryController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<PantryController>();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(final String query) {
    setState(() {
      _results = _controller.searchItems(query);
    });
  }

  @override
  Widget build(final BuildContext context) {
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
          'Search',
          style: AppTextStyles.headlineSmall.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // search field
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.screenH.w,
              vertical: AppSpacing.xs.h,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      style: AppTextStyles.inputText,
                      onChanged: _onSearch,
                      decoration: const InputDecoration(
                        hintText: 'Chicken',
                        hintStyle: AppTextStyles.inputHint,
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.textTertiary,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  if (_searchController.text.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        _searchController.clear();
                        _onSearch('');
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: AppSpacing.sm.w),
                        child: const Icon(
                          Icons.close,
                          color: AppColors.textTertiary,
                          size: 18,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // results section
          if (_results.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.screenH.w,
                vertical: AppSpacing.xs.h,
              ),
              child: const Text(
                'SEARCH RESULTS',
                style: AppTextStyles.sectionHeader,
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenH.w,
                  vertical: 0,
                ),
                itemCount: _results.length,
                separatorBuilder: (_, __) =>
                    const Divider(height: 1, color: AppColors.divider),
                itemBuilder: (final context, final index) {
                  final Map<String, dynamic> item = _results[index];
                  final String? urgency = item['urgency'] as String?;
                  final String? imageUrl = item['image'] as String?;
                  final String storedIn =
                      (item['storedIn'] as String?) ?? 'Pantry';
                  final String qty = (item['qty'] as String?) ?? '';
                  final String unit = (item['unit'] as String?) ?? '';

                  return InkWell(
                    onTap: () => Get.back(result: item),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: AppSpacing.md.h),
                      child: Row(
                        children: [
                          // item thumbnail
                          ClipRRect(
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                            child: imageUrl != null
                                ? CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    width: 52.w,
                                    height: 52.w,
                                    fit: BoxFit.cover,
                                    placeholder: (_, __) => Container(
                                        color: AppColors.shimmerBase),
                                    errorWidget: (_, __, ___) => _fallbackIcon(),
                                  )
                                : _fallbackIcon(),
                          ),
                          SizedBox(width: AppSpacing.md.w),

                          // name, location, expiry
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'] as String,
                                  style: AppTextStyles.titleSmall,
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  children: [
                                    Icon(
                                      _storageIcon(storedIn),
                                      size: 13,
                                      color: AppColors.textTertiary,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      storedIn,
                                      style: AppTextStyles.bodySmall,
                                    ),
                                    const SizedBox(width: 8),
                                    if (urgency != null) ...[
                                      UrgencyBadge(text: urgency),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // quantity
                          Text(
                            '$qty $unit',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ] else if (_searchController.text.isNotEmpty &&
              _results.isEmpty) ...[
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.search_off_rounded,
                      size: 56,
                      color: AppColors.textTertiary,
                    ),
                    SizedBox(height: AppSpacing.md.h),
                    Text(
                      'No results found',
                      style: AppTextStyles.titleSmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: AppSpacing.xs.h),
                    const Text(
                      'Try a different ingredient name',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.search,
                      size: 56,
                      color: AppColors.textTertiary,
                    ),
                    SizedBox(height: AppSpacing.md.h),
                    Text(
                      'Search your pantry',
                      style: AppTextStyles.titleSmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _fallbackIcon() {
    return Container(
      width: 52.w,
      height: 52.w,
      decoration: BoxDecoration(
        color: AppColors.cardBgSecondary,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: const Icon(
        Icons.restaurant,
        size: 22,
        color: AppColors.textTertiary,
      ),
    );
  }

  IconData _storageIcon(final String location) {
    switch (location.toLowerCase()) {
      case 'fridge':
        return Icons.kitchen_outlined;
      case 'freezer':
        return Icons.ac_unit_outlined;
      case 'pantry':
      default:
        return Icons.table_restaurant_outlined;
    }
  }
}


