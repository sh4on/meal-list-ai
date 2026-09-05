import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_text_styles.dart';

class CookingTimeCard extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool fullWidth;

  const CookingTimeCard({super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: fullWidth ? double.infinity : null,
        // Removed internal horizontal padding so the dot positions cleanly at the top-right edge
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primarySurface : AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        // Stack allows layering the indicator dot over the card content
        child: Stack(
          children: [
            // Main card content centered/aligned properly
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                mainAxisAlignment: fullWidth
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 20,
                    color: isSelected ? AppColors.primary : AppColors.textTertiary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: isSelected ? AppColors.primary : AppColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            // Indicator dot appears at the top-right corner when selected
            if (isSelected)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}