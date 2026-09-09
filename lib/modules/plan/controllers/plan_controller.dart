import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ─── data models ────────────────────────────────────────────────────────────

class MealEntry {
  final String mealType; // BREAKFAST / LUNCH / DINNER / SNACK
  final String time;
  final String name;
  final String description;
  final int kcal;
  final int proteinG;
  final int servings;
  final Color mealTypeColor;
  final String imageAsset; // placeholder network image url
  final bool hasAiInsight;
  final String? aiInsightText;

  const MealEntry({
    required this.mealType,
    required this.time,
    required this.name,
    required this.description,
    required this.kcal,
    required this.proteinG,
    required this.servings,
    required this.mealTypeColor,
    required this.imageAsset,
    this.hasAiInsight = false,
    this.aiInsightText,
  });
}

class DayPlan {
  final int dayNumber;
  final String dayName;
  final String dayLabel; // "Today", "Tomorrow", etc.
  final List<MealEntry> meals;

  const DayPlan({
    required this.dayNumber,
    required this.dayName,
    required this.dayLabel,
    required this.meals,
  });

  int get totalKcal => meals.fold(0, (sum, m) => sum + m.kcal);
}

class PlanController extends GetxController {
  // current selected view mode
  final RxString viewMode = 'Day'.obs;
  final List<String> viewModes = const ['Day', '3 Days', 'Week'];

  // expanded day index for week view
  final RxSet<int> expandedDays = <int>{0}.obs;

  void setViewMode(String mode) => viewMode.value = mode;

  void toggleExpanded(int index) {
    if (expandedDays.contains(index)) {
      expandedDays.remove(index);
    } else {
      expandedDays.add(index);
    }
  }

  // ─── sample data ─────────────────────────────────────────────────────────

  final List<DayPlan> weekPlan = const [
    DayPlan(
      dayNumber: 24,
      dayName: 'Monday',
      dayLabel: 'Today',
      meals: [
        MealEntry(
          mealType: 'BREAKFAST',
          time: '8:30 AM',
          name: 'Avocado Poached Egg Toast',
          description:
              'Artisan sourdough with smashed avocado, a soft poached egg, and red pepper flakes.',
          kcal: 320,
          proteinG: 24,
          servings: 1,
          mealTypeColor: Color(0xFFE8A838),
          imageAsset:
              'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=600&q=80',
        ),
        MealEntry(
          mealType: 'LUNCH',
          time: '1:00 PM',
          name: 'Mediterranean Quinoa Bowl',
          description:
              'Fresh greens, quinoa, grilled chicken, feta, and lemon herb dressing.',
          kcal: 550,
          proteinG: 45,
          servings: 1,
          mealTypeColor: Color(0xFF4A90A4),
          imageAsset:
              'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=600&q=80',
          hasAiInsight: true,
          aiInsightText:
              'Mealist swapped your usual wrap for this bowl to help hit your protein goals today without exceeding carbs.',
        ),
        MealEntry(
          mealType: 'DINNER',
          time: '7:00 PM',
          name: 'Seared Salmon & Asparagus',
          description:
              'Wild-caught salmon with garlic roasted asparagus and wild rice.',
          kcal: 680,
          proteinG: 51,
          servings: 2,
          mealTypeColor: Color(0xFF7B6CF6),
          imageAsset:
              'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=600&q=80',
        ),
      ],
    ),
    DayPlan(
      dayNumber: 25,
      dayName: 'Tuesday',
      dayLabel: 'Tomorrow',
      meals: [
        MealEntry(
          mealType: 'BREAKFAST',
          time: '8:30 AM',
          name: 'Greek Yogurt Parfait',
          description:
              'Layered Greek yogurt, granola, mixed berries and honey drizzle.',
          kcal: 280,
          proteinG: 18,
          servings: 1,
          mealTypeColor: Color(0xFFE8A838),
          imageAsset:
              'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=600&q=80',
        ),
        MealEntry(
          mealType: 'LUNCH',
          time: '12:30 PM',
          name: 'Turkish Lentil Chicken Bowl',
          description:
              'Spiced red lentils, grilled chicken thighs, cucumber, and tahini.',
          kcal: 540,
          proteinG: 42,
          servings: 2,
          mealTypeColor: Color(0xFF4A90A4),
          imageAsset:
              'https://images.unsplash.com/photo-1547592180-85f173990554?w=600&q=80',
        ),
        MealEntry(
          mealType: 'DINNER',
          time: '7:00 PM',
          name: 'Pan-Seared Salmon & Asparagus',
          description:
              'Crispy pan-seared salmon fillet with roasted asparagus and lemon butter.',
          kcal: 480,
          proteinG: 38,
          servings: 2,
          mealTypeColor: Color(0xFF7B6CF6),
          imageAsset:
              'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=600&q=80',
        ),
      ],
    ),
    DayPlan(
      dayNumber: 26,
      dayName: 'Wednesday',
      dayLabel: '3 meals planned',
      meals: [
        MealEntry(
          mealType: 'BREAKFAST',
          time: '8:00 AM',
          name: 'Banana Oat Pancakes',
          description:
              'Fluffy oat-based pancakes with banana, cinnamon and maple syrup.',
          kcal: 310,
          proteinG: 12,
          servings: 1,
          mealTypeColor: Color(0xFFE8A838),
          imageAsset:
              'https://images.unsplash.com/photo-1554520735-0a6b8b6ce8b7?w=600&q=80',
        ),
        MealEntry(
          mealType: 'LUNCH',
          time: '1:00 PM',
          name: 'Chicken Caesar Wrap',
          description:
              'Grilled chicken, romaine, parmesan and caesar dressing in a whole wheat wrap.',
          kcal: 490,
          proteinG: 38,
          servings: 1,
          mealTypeColor: Color(0xFF4A90A4),
          imageAsset:
              'https://images.unsplash.com/photo-1553361371-9b22f78e8b1d?w=600&q=80',
        ),
        MealEntry(
          mealType: 'DINNER',
          time: '7:30 PM',
          name: 'Chicken Rice Bowl',
          description:
              'Teriyaki glazed chicken thigh, steamed jasmine rice, broccoli.',
          kcal: 620,
          proteinG: 48,
          servings: 2,
          mealTypeColor: Color(0xFF7B6CF6),
          imageAsset:
              'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=600&q=80',
        ),
      ],
    ),
    DayPlan(
      dayNumber: 27,
      dayName: 'Thursday',
      dayLabel: '2 meals planned',
      meals: [
        MealEntry(
          mealType: 'BREAKFAST',
          time: '8:30 AM',
          name: 'Smoothie Bowl',
          description:
              'Blended açaí, banana, and almond milk topped with granola and fresh fruit.',
          kcal: 340,
          proteinG: 14,
          servings: 1,
          mealTypeColor: Color(0xFFE8A838),
          imageAsset:
              'https://images.unsplash.com/photo-1546039907-7fa05f864c02?w=600&q=80',
        ),
        MealEntry(
          mealType: 'LUNCH',
          time: '12:30 PM',
          name: 'Shrimp Tacos',
          description:
              'Spiced shrimp, cabbage slaw, avocado crema in corn tortillas.',
          kcal: 520,
          proteinG: 35,
          servings: 2,
          mealTypeColor: Color(0xFF4A90A4),
          imageAsset:
              'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=600&q=80',
        ),
      ],
    ),
  ];

  // nutrition for today
  final int todayCalories = 1850;
  final int todayCaloriesTarget = 2000;
  final int todayProtein = 120;
  final int todayProteinTarget = 140;
  final int todayCarbs = 210;
  final int todayCarbsTarget = 250;
  final int todayFat = 55;
  final int todayFatTarget = 70;
}
