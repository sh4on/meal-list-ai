// a single region group with header + 2-col grid
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../controllers/onboarding_controller.dart';
import 'cuisine_card.dart';

class CuisineGroup extends StatelessWidget {
  final String groupName;
  final List<Map<String, dynamic>> cuisines;
  final Map<String, String> cuisineImages;
  final OnboardingController controller;

  const CuisineGroup({super.key,
    required this.groupName,
    required this.cuisines,
    required this.cuisineImages,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // group header row: name + SELECT ALL
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(groupName, style: AppTextStyles.headlineSmall),
            Obx(
                  () {
                final List<String> names = cuisines
                    .map((Map<String, dynamic> c) => c['name'] as String)
                    .toList();
                final bool allSelected =
                names.every(controller.selectedCuisines.contains);
                return GestureDetector(
                  onTap: () => controller.toggleAllGroup(cuisines),
                  child: Text(
                    allSelected ? 'DESELECT ALL' : 'SELECT ALL',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        SizedBox(height: 12.h),

        // 2-col grid of cuisine photo cards
        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.9,
          ),
          itemCount: cuisines.length,
          itemBuilder: (_, int i) {
            final String name = cuisines[i]['name'] as String;
            return Obx(
                  () => CuisineCard(
                name: name,
                imageUrl: cuisineImages[name] ?? '',
                isSelected: controller.selectedCuisines.contains(name),
                onTap: () => controller.toggleCuisine(name),
              ),
            );
          },
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}