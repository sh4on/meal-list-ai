import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../gen/assets.gen.dart';

// mealist brand logo — shared across all auth screens
// extracted to widget to avoid duplication across splash, welcome, sign-in, etc.
class MealistLogoWidget extends StatelessWidget {
  final double? iconSize;

  const MealistLogoWidget({super.key, this.iconSize});

  @override
  Widget build(BuildContext context) {
    final double resolvedSize = iconSize ?? AppSpacing.iconLg;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          Assets.images.appIcon,
          height: 20,
          width: 20,
        ),
        const SizedBox(width: 6),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Mealist',
                style: AppTextStyles.logoMark.copyWith(
                  fontSize: 22,
                ),
              ),
              TextSpan(
                text: '.ai',
                style: AppTextStyles.logoMark.copyWith(
                  color: AppColors.accent,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
