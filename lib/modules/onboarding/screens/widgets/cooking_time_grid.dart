// cooking time grid — 2-col for first 4, full-width for last one
import 'package:flutter/material.dart';

import 'cooking_time_card.dart';

class CookingTimeGrid extends StatelessWidget {
  final List<String> times;
  final String selected;
  final void Function(String) onSelect;

  const CookingTimeGrid({
    super.key,
    required this.times,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    // first 4 in 2-col grid, last one full-width
    final List<String> gridItems = times.take(4).toList();
    final String? fullWidthItem = times.length > 4 ? times[4] : null;

    return Column(
      children: [
        GridView.count(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 2.2,
          children: gridItems.map((String t) {
            final bool isSelected = selected == t;
            return CookingTimeCard(
              label: t,
              isSelected: isSelected,
              onTap: () => onSelect(t),
            );
          }).toList(),
        ),
        if (fullWidthItem != null) ...[
          const SizedBox(height: 12),
          CookingTimeCard(
            label: fullWidthItem,
            isSelected: selected == fullWidthItem,
            onTap: () => onSelect(fullWidthItem),
            fullWidth: true,
          ),
        ],
      ],
    );
  }
}
