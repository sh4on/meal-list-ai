import 'package:flutter/material.dart';

import '../../../../core/constants/app_text_styles.dart';

// section label helper
class SectionLabel extends StatelessWidget {
  final String label;
  const SectionLabel({super.key, required this.label});

  @override
  Widget build(final BuildContext context) {
    return Text(label, style: AppTextStyles.labelSmall);
  }
}
