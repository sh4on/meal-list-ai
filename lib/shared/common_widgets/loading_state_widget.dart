import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

// loading state — shown while async data is fetching
// using centered column keeps it visually balanced in any container
class LoadingStateWidget extends StatelessWidget {
  final String loadingMessage;

  const LoadingStateWidget({
    super.key,
    this.loadingMessage = 'Loading...',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 2.5,
          ),
          const SizedBox(height: 16),
          Text(
            loadingMessage,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
