import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';

// section label helper
class SectionLabel extends StatelessWidget {
  final String label;
  const SectionLabel({required this.label});

  @override
  Widget build(final BuildContext context) {
    return Text(label, style: AppTextStyles.labelSmall);
  }
}