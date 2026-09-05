import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

// divider with centered OR label — used between primary and SSO buttons
class SsoDividerWidget extends StatelessWidget {
  const SsoDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.border)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'OR',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.textTertiary,
              letterSpacing: 1.0,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.border)),
      ],
    );
  }
}
