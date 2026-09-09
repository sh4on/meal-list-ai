import 'package:flutter/material.dart';

import 'goal_card.dart';

class GoalGrid extends StatelessWidget {
  final List<Map<String, dynamic>> goals;
  final String selectedGoal;
  final void Function(String) onSelect;

  const GoalGrid({
    super.key,
    required this.goals,
    required this.selectedGoal,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: goals.length,
      itemBuilder: (_, int index) {
        final Map<String, dynamic> goal = goals[index];
        final bool isSelected = selectedGoal == goal['title'];
        return GoalCard(
          title: goal['title'] as String,
          subtitle: goal['subtitle'] as String,
          icon: goal['icon'] as IconData,
          isSelected: isSelected,
          onTap: () => onSelect(goal['title'] as String),
        );
      },
    );
  }
}
