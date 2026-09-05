import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

// onboarding controller — tracks selections across all 5 onboarding steps
// flow: your goals (1) → dietary prefs (2) → cuisines (3) → allergies (4) → kitchen (5)
class OnboardingController extends GetxController {
  // ─── step 1: goals ────────────────────────────────────────────────────────
  final RxString selectedGoal = ''.obs;

  // ─── step 2: dietary preferences ─────────────────────────────────────────
  final RxString selectedDiet = 'No preference'.obs;
  final RxList<String> selectedNutritionFocuses = <String>[].obs;

  // ─── step 3: cuisines ─────────────────────────────────────────────────────
  final RxList<String> selectedCuisines = <String>[].obs;

  // ─── step 4: allergies & restrictions ────────────────────────────────────
  final RxBool hasNoRestrictions = false.obs;
  final RxList<String> selectedAllergies = <String>[].obs;
  final RxList<String> selectedDietaryRestrictions = <String>[].obs;
  final RxList<String> specificIngredients = <String>[].obs;
  final RxString allergySearchQuery = ''.obs;
  final RxString restrictionSearchQuery = ''.obs;
  final RxString specificIngredientInput = ''.obs;

  // ─── step 5: kitchen / household ─────────────────────────────────────────
  final RxString selectedCookingTime = '15–30 min'.obs;
  final RxString cookingSkill = 'Comfortable'.obs;
  final RxString householdType = 'Couple'.obs;
  final RxInt adultsCount = 2.obs;
  final RxInt childrenCount = 0.obs;

  // ─── goal options from figma ──────────────────────────────────────────────
  final List<Map<String, dynamic>> goalOptions = const [
    {
      'title': 'Eat healthier',
      'subtitle': 'Balanced, whole-food approach.',
      'icon': Icons.favorite_outline,
    },
    {
      'title': 'Lose weight',
      'subtitle': 'Sustainable, chef-crafted plans.',
      'icon': Icons.monitor_weight_outlined,
    },
    {
      'title': 'Build muscle',
      'subtitle': 'High-protein culinary focus.',
      'icon': Icons.fitness_center_outlined,
    },
    {
      'title': 'Save money',
      'subtitle': 'Budget-friendly, minimal waste.',
      'icon': Icons.savings_outlined,
    },
    {
      'title': 'Reduce food waste',
      'subtitle': 'Smart shopping & pantry use.',
      'icon': Icons.recycling_outlined,
    },
    {
      'title': 'Cook more often',
      'subtitle': 'Simple, delicious recipes.',
      'icon': Icons.restaurant_outlined,
    },
    {
      'title': 'Eat more protein',
      'subtitle': 'Targeted macros, amazing flavor.',
      'icon': Icons.egg_outlined,
    },
    {
      'title': 'Plan family meals',
      'subtitle': 'Kid-friendly, bulk-prep ideas.',
      'icon': Icons.people_outline,
    },
    {
      'title': 'Improve energy',
      'subtitle': 'Fuel your body for peak performance.',
      'icon': Icons.bolt_outlined,
    },
    {
      'title': 'Better sleep',
      'subtitle': 'Optimize nutrition for restful nights.',
      'icon': Icons.nightlight_outlined,
    },
    {
      'title': 'Save time',
      'subtitle': 'Quick, 15-minute meal solutions.',
      'icon': Icons.timer_outlined,
    },
  ];

  // ─── diet options from figma ──────────────────────────────────────────────
  final List<String> dietOptions = const [
    'No preference',
    'Vegetarian',
    'Vegan',
    'Pescatarian',
    'Keto',
    'Paleo',
  ];

  // ─── nutrition focus chips ────────────────────────────────────────────────
  final List<String> nutritionFocuses = const [
    'High Protein',
    'High Fibre',
    'Low Carb',
    'Balanced',
    'Low Sodium',
    'Low Sugar',
  ];

  // ─── cuisine groups from figma ────────────────────────────────────────────
  final List<Map<String, dynamic>> cuisineGroups = const [
    {
      'group': 'Mediterranean',
      'cuisines': [
        {'name': 'Italian', 'emoji': '🍝'},
        {'name': 'Greek', 'emoji': '🫒'},
        {'name': 'Spanish', 'emoji': '🥘'},
        {'name': 'Moroccan', 'emoji': '🍲'},
      ],
    },
    {
      'group': 'Asian',
      'cuisines': [
        {'name': 'Japanese', 'emoji': '🍣'},
        {'name': 'Thai', 'emoji': '🍜'},
        {'name': 'Indian', 'emoji': '🍛'},
        {'name': 'Chinese', 'emoji': '🥟'},
      ],
    },
    {
      'group': 'Americas',
      'cuisines': [
        {'name': 'Mexican', 'emoji': '🌮'},
        {'name': 'American', 'emoji': '🍔'},
        {'name': 'Brazilian', 'emoji': '🥩'},
        {'name': 'Peruvian', 'emoji': '🫑'},
      ],
    },
  ];

  // ─── allergy chips ────────────────────────────────────────────────────────
  final List<String> allergyOptions = const [
    'Dairy',
    'Peanuts',
    'Tree Nuts',
    'Gluten',
    'Eggs',
    'Shellfish',
    'Fish',
    'Soy',
    'Sesame',
    'Sulfites',
  ];

  // ─── dietary & religious restrictions ────────────────────────────────────
  final List<String> dietaryRestrictionOptions = const [
    'Halal',
    'Kosher',
    'No Alcohol',
    'Vegetarian',
    'Vegan',
    'Jain',
  ];

  // ─── cooking times ────────────────────────────────────────────────────────
  final List<String> cookingTimes = const [
    'Under 15 min',
    '15–30 min',
    '30–45 min',
    '45–60 min',
    '60+ min',
  ];

  // ─── cooking skills ───────────────────────────────────────────────────────
  final List<String> cookingSkills = const [
    'Beginner',
    'Comfortable',
    'Advanced',
  ];

  // ─── household types ──────────────────────────────────────────────────────
  final List<Map<String, dynamic>> householdTypes = const [
    {'label': 'Just me', 'icon': Icons.person_outline},
    {'label': 'Couple', 'icon': Icons.people_alt_outlined},
    {'label': 'Family', 'icon': Icons.family_restroom_outlined},
    {'label': 'Custom', 'icon': Icons.tune_outlined},
  ];

  // ─── actions ─────────────────────────────────────────────────────────────
  void selectGoal(String goal) => selectedGoal.value = goal;

  void selectDiet(String diet) => selectedDiet.value = diet;

  void toggleNutritionFocus(String focus) {
    if (selectedNutritionFocuses.contains(focus)) {
      selectedNutritionFocuses.remove(focus);
    } else {
      selectedNutritionFocuses.add(focus);
    }
  }

  void toggleCuisine(String cuisine) {
    if (selectedCuisines.contains(cuisine)) {
      selectedCuisines.remove(cuisine);
    } else {
      selectedCuisines.add(cuisine);
    }
  }

  void toggleAllGroup(List<Map<String, dynamic>> groupCuisines) {
    final List<String> names =
        groupCuisines.map((Map<String, dynamic> c) => c['name'] as String).toList();
    final bool allSelected =
        names.every((String n) => selectedCuisines.contains(n));
    if (allSelected) {
      selectedCuisines.removeWhere((String c) => names.contains(c));
    } else {
      for (final String n in names) {
        if (!selectedCuisines.contains(n)) selectedCuisines.add(n);
      }
    }
  }

  void toggleNoRestrictions(bool val) {
    hasNoRestrictions.value = val;
    if (val) {
      selectedAllergies.clear();
      selectedDietaryRestrictions.clear();
      specificIngredients.clear();
    }
  }

  void toggleAllergy(String allergy) {
    hasNoRestrictions.value = false;
    if (selectedAllergies.contains(allergy)) {
      selectedAllergies.remove(allergy);
    } else {
      selectedAllergies.add(allergy);
    }
  }

  void toggleDietaryRestriction(String r) {
    hasNoRestrictions.value = false;
    if (selectedDietaryRestrictions.contains(r)) {
      selectedDietaryRestrictions.remove(r);
    } else {
      selectedDietaryRestrictions.add(r);
    }
  }

  void addSpecificIngredient(String ingredient) {
    if (ingredient.trim().isNotEmpty &&
        !specificIngredients.contains(ingredient.trim())) {
      specificIngredients.add(ingredient.trim());
      specificIngredientInput.value = '';
    }
  }

  void removeSpecificIngredient(String ingredient) =>
      specificIngredients.remove(ingredient);

  void selectCookingTime(String time) => selectedCookingTime.value = time;
  void setCookingSkill(String skill) => cookingSkill.value = skill;
  void selectHouseholdType(String type) => householdType.value = type;

  // ─── navigation — corrected figma order ──────────────────────────────────
  // step 1 → 2
  void goToDietaryPreferences() =>
      Get.toNamed(AppRoutes.dietaryPreferences);
  // step 2 → 3
  void goToFavouriteCuisines() =>
      Get.toNamed(AppRoutes.favouriteCuisines);
  // step 3 → 4
  void goToAllergies() => Get.toNamed(AppRoutes.allergies);
  // step 4 → 5
  void goToCookingHousehold() =>
      Get.toNamed(AppRoutes.cookingHousehold);
  // step 5: finish
  void finishOnboarding() => Get.offAllNamed(AppRoutes.main);
}
