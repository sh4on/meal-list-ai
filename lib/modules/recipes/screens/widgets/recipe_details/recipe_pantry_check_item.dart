import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

// checklist item showing pantry availability with green check or orange warning
class RecipePantryCheckItem extends StatelessWidget {
  final String text;
  final bool inPantry;

  const RecipePantryCheckItem({
    super.key,
    required this.text,
    required this.inPantry,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          inPantry ? Icons.check_circle : Icons.error_outline,
          size: 16,
          color: inPantry ? const Color(0xFF2E7D32) : const Color(0xFFE65100),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: inPantry ? FontWeight.w500 : FontWeight.w600,
              color: inPantry ? AppColors.textPrimary : const Color(0xFFE65100),
            ),
          ),
        ),
      ],
    );
  }
}
