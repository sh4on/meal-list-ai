import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import 'widgets/search_results/search_result_card.dart';
import 'widgets/search_results/search_variety_card.dart';

// search results screen
// shows semantic AI understood filters, diet restrictions, recipe results, and suggestions
class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final TextEditingController _searchController = TextEditingController(
    text: 'High-protein chicken under 30 minutes',
  );

  final List<String> _understoodChips = const [
    'High-Protein (>35g)',
    'Chicken',
    '< 30 mins',
  ];

  final List<Map<String, dynamic>> _results = const [
    {
      'title': 'Crispy Skillet Lemon Chicken',
      'match': '96% Match',
      'time': '25 min',
      'kcal': '420 kcal',
      'protein': '44g protein',
      'insight':
          'Chicken breast hits your 40g+ protein target while keeping total prep under 25 minutes.',
      'image':
          'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?w=800&q=80',
    },
    {
      'title': 'One-Pan Harissa Chicken & Peppers',
      'match': '92% Match',
      'time': '20 min',
      'kcal': '390 kcal',
      'protein': '38g protein',
      'insight':
          'High heat gives crispy skin in just 20 minutes without extra dishes.',
      'image':
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80',
    },
    {
      'title': 'Greek Marinated Chicken Breast',
      'match': '89% Match',
      'time': '15 min',
      'kcal': '350 kcal',
      'protein': '41g protein',
      'insight':
          'Fastest option: 15-minute sear. Uses olive oil and herbs from your pantry.',
      'image':
          'https://images.unsplash.com/photo-1532550907401-a500c9a57435?w=800&q=80',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: Get.back,
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.border),
          ),
          child: TextField(
            controller: _searchController,
            style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
            decoration: const InputDecoration(
              hintText: 'Search recipes...',
              prefixIcon: Icon(
                Icons.search,
                size: 18,
                color: AppColors.textSecondary,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.screenH.w,
          vertical: AppSpacing.sm.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // mealist understood section
            const Row(
              children: [
                Icon(Icons.auto_awesome, size: 16, color: Color(0xFFEA580C)),
                SizedBox(width: 6),
                Text(
                  'Mealist understood:',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // understood chips
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _understoodChips.map((String chip) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7ED),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    border: Border.all(color: const Color(0xFFFFEDD5)),
                  ),
                  child: Text(
                    chip,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFC2410C),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 12),

            // auto-applied restriction notice
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(color: const Color(0xFFBFDBFE)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: Color(0xFF2563EB)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Filtered for: Dairy-free (auto-applied from profile)',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF1E40AF),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.md.h),

            // results count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '24 recipes found',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Row(
                    children: [
                      Text(
                        'Sort by match',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF3B6E59),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                        color: Color(0xFF3B6E59),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // recipe list
            ..._results.map(
              (Map<String, dynamic> recipe) => SearchResultCard(recipe: recipe),
            ),

            SizedBox(height: AppSpacing.md.h),

            // want more variety card
            SearchVarietyCard(
              onExpandFilter: () {
                Get.snackbar(
                  'Filter Expanded',
                  'Showing meals up to 45 mins. Found 150+ recipes.',
                  backgroundColor: AppColors.white,
                  colorText: AppColors.textPrimary,
                );
              },
            ),

            SizedBox(height: AppSpacing.xxxl.h),
          ],
        ),
      ),
    );
  }
}
