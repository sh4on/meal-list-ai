import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';

// empty state — shown when a list or content area has no items
class EmptyStateWidget extends StatelessWidget {
  final String message;
  final String? subMessage;
  final Widget? illustration;

  const EmptyStateWidget({
    super.key,
    required this.message,
    this.subMessage,
    this.illustration,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (illustration != null) ...[
              illustration!,
              const SizedBox(height: AppSpacing.lg),
            ] else ...[
              const Icon(
                Icons.inbox_outlined,
                size: AppSpacing.iconXl * 2,
                color: AppColors.textTertiary,
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
            Text(
              message,
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (subMessage != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                subMessage!,
                style: AppTextStyles.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
