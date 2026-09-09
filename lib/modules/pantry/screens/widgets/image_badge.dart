import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_text_styles.dart';

// badge overlaid on recipe image
class ImageBadge extends StatelessWidget {
  final String label;
  final bool isDark;
  final bool isWarning;

  const ImageBadge({
    super.key,
    required this.label,
    required this.isDark,
    this.isWarning = false,
  });

  @override
  Widget build(final BuildContext context) {
    Color bg;
    Color fg;

    if (isWarning) {
      bg = AppColors.accentSurface;
      fg = AppColors.warning;
    } else if (isDark) {
      bg = AppColors.primary;
      fg = AppColors.white;
    } else {
      bg = AppColors.white.withValues(alpha: 0.9);
      fg = AppColors.textPrimary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.xs),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isWarning) ...[
            Icon(Icons.inventory_2_outlined, size: 11, color: fg),
            const SizedBox(width: 3),
          ] else if (isDark) ...[
            Icon(Icons.inventory_2_outlined, size: 11, color: fg),
            const SizedBox(width: 3),
          ],
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: fg,
              fontWeight: FontWeight.w700,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
