import 'package:flutter/material.dart';

// stepper counter button for adjusting servings
class RecipeStepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const RecipeStepperButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F4F2),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: 16,
          color: const Color(0xFF3B6E59),
        ),
      ),
    );
  }
}
