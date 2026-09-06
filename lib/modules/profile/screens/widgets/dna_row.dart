// individual DNA info row
import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';

class DnaRow extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? customWidget;

  const DnaRow({required this.label, this.value, this.customWidget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.inputLabel),
          const SizedBox(height: 2),
          if (value != null)
            Text(value!, style: AppTextStyles.bodyMedium)
          else
            customWidget ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}