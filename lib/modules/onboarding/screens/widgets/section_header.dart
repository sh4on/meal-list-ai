// section label row with icon
import 'package:flutter/material.dart';

import '../../../../core/constants/app_text_styles.dart';

class SectionHeader extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;

  const SectionHeader({
    super.key,
    required this.label,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.sectionHeader,
          ),
        ),
        Icon(icon, color: iconColor, size: 18),
      ],
    );
  }
}
