import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';

// dismissible today's nudge alert banner on for you screen
class ForYouNudgeBanner extends StatelessWidget {
  final VoidCallback onDismiss;

  const ForYouNudgeBanner({
    super.key,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF4E8),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: const Color(0xFFF3DDBA)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.auto_awesome,
            color: Color(0xFFD97706),
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Today's Nudge",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 3),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                      height: 1.35,
                    ),
                    children: [
                      TextSpan(text: "You're "),
                      TextSpan(
                        text: '38g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            ' short of today\'s protein goal. These recipes will help you hit it.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onDismiss,
            child: const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Icon(
                Icons.close,
                size: 18,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
