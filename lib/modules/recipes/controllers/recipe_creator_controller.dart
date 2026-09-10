import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

// recipe creator controller
// manages multi-step wizard state for importing and authoring custom recipes
class RecipeCreatorController extends GetxController {
  // current wizard step: 0: Basics, 1: Ingredients, 2: Steps, 3: Nutrition, 4: Review
  final RxInt wizardStep = 0.obs;

  // step 1: basics
  // prefilled with the imported sample recipe data to match the review design
  final TextEditingController titleController =
      TextEditingController(text: 'Mediterranean Lentil & Chicken Bowl');
  final TextEditingController descController = TextEditingController(
    text: 'A hearty, protein-packed bowl perfect for meal prep.',
  );
  final RxString selectedCuisine = 'Mediterranean'.obs;
  // remote image displayed in the review hero section
  final RxString recipeImageUrl =
      'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=800&auto=format&fit=crop&q=80'
          .obs;
  final RxBool isImported = true.obs;
  final RxBool hasAllergenWarning = true.obs;

  // available cuisine types for the dropdown
  static const List<String> cuisineTypes = [
    'Mediterranean',
    'Asian',
    'American',
    'Italian',
    'Mexican',
    'Indian',
    'Middle Eastern',
    'French',
    'Japanese',
    'Greek',
  ];

  // step 2: ingredients — each map holds name, qty, unit, and optional warning
  final RxList<Map<String, String>> ingredients = <Map<String, String>>[
    {'name': 'Cooked Lentils', 'qty': '1', 'unit': 'cup'},
    {
      'name': 'Shredded Chicken',
      'qty': '-',
      'unit': 'unit',
      'warning': 'Quantity unclear from text',
    },
    {'name': 'Greek Yogurt', 'qty': '0.5', 'unit': 'cup'},
    {'name': 'Pomegranate Seeds', 'qty': '2', 'unit': 'tbsp'},
  ].obs;

  // supported measurement units shown in the ingredient unit dropdown
  static const List<String> units = [
    'g',
    'kg',
    'ml',
    'L',
    'cup',
    'tbsp',
    'tsp',
    'oz',
    'lb',
    'piece',
    'clove',
    'slice',
    'unit',
  ];

  // step 3: instructions — ordered list of step text strings
  final RxList<String> instructions = <String>[
    'Layer the cooked lentils at the bottom of the bowl.',
    'Top with shredded chicken.',
    'Add a dollop of Greek yogurt.',
    'Sprinkle pomegranate seeds and fresh herbs over the top.',
  ].obs;

  // step 4: nutrition values matching the figma design
  final TextEditingController caloriesController =
      TextEditingController(text: '420');
  final TextEditingController proteinController =
      TextEditingController(text: '32');
  final TextEditingController carbsController =
      TextEditingController(text: '45');
  final TextEditingController fatController = TextEditingController(text: '12');

  // when true the UI shows AI-estimated badges and disables manual editing
  final RxBool autoEstimateNutrition = true.obs;
  final RxBool isAutoEstimating = false.obs;

  // url import controller
  final TextEditingController urlController = TextEditingController();
  final RxBool isImporting = false.obs;

  @override
  void onClose() {
    titleController.dispose();
    descController.dispose();
    caloriesController.dispose();
    proteinController.dispose();
    carbsController.dispose();
    fatController.dispose();
    urlController.dispose();
    super.onClose();
  }

  void nextWizardStep() {
    if (wizardStep.value < 4) {
      wizardStep.value++;
    } else {
      saveRecipe();
    }
  }

  void prevWizardStep() {
    if (wizardStep.value > 0) {
      wizardStep.value--;
    }
  }

  void addIngredient(
    final String name,
    final String qty,
    final String unit,
  ) {
    if (name.isNotEmpty) {
      ingredients.add({
        'name': name,
        'qty': qty.isEmpty ? '1' : qty,
        'unit': unit.isEmpty ? 'g' : unit,
      });
    }
  }

  void removeIngredient(final int index) {
    if (index >= 0 && index < ingredients.length) {
      ingredients.removeAt(index);
    }
  }

  void addInstruction() {
    // adds a blank step that the user can type into
    instructions.add('');
  }

  void updateInstruction(final int index, final String value) {
    if (index >= 0 && index < instructions.length) {
      instructions[index] = value;
    }
  }

  void removeInstruction(final int index) {
    if (index >= 0 && index < instructions.length) {
      instructions.removeAt(index);
    }
  }

  // simulates toggling AI auto-estimate and running estimation
  Future<void> toggleAutoEstimate() async {
    autoEstimateNutrition.value = !autoEstimateNutrition.value;
    if (autoEstimateNutrition.value) {
      // simulate AI computation delay
      isAutoEstimating.value = true;
      await Future.delayed(const Duration(milliseconds: 800));
      caloriesController.text = '485';
      proteinController.text = '32';
      carbsController.text = '45';
      fatController.text = '18';
      isAutoEstimating.value = false;
    }
  }

  // simulate url import that navigates to wizard on completion
  Future<void> importUrl() async {
    final String url = urlController.text.trim();
    if (url.isNotEmpty) {
      isImporting.value = true;
      await Future.delayed(const Duration(milliseconds: 1200));
      isImporting.value = false;
      titleController.text = 'Mediterranean Lentil & Chicken Bowl';
      descController.text =
          'A hearty, protein-packed bowl perfect for meal prep.';
      Get.offNamed(AppRoutes.createRecipeWizard);
    }
  }

  void saveRecipe() {
    Get.offAllNamed(AppRoutes.main);
    Get.snackbar(
      'Recipe Saved!',
      '${titleController.text.isEmpty ? 'Custom Recipe' : titleController.text} added to My Recipes.',
      backgroundColor: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }
}
