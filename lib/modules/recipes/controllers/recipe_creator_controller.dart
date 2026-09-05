import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

// recipe creator controller
// manages multi-step wizard state for importing and authoring custom recipes
class RecipeCreatorController extends GetxController {
  // current wizard step: 0: Basics, 1: Ingredients, 2: Instructions, 3: Nutrition, 4: Review
  final RxInt wizardStep = 0.obs;

  // step 1: basics
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController prepTimeController =
      TextEditingController(text: '15');
  final TextEditingController cookTimeController =
      TextEditingController(text: '20');
  final TextEditingController servingsController =
      TextEditingController(text: '2');
  final RxString selectedCategory = 'Dinner'.obs;

  // step 2: ingredients
  final RxList<Map<String, String>> ingredients = <Map<String, String>>[
    {'name': 'Chicken Breast', 'qty': '500g'},
    {'name': 'Olive Oil', 'qty': '2 tbsp'},
    {'name': 'Garlic', 'qty': '3 cloves'},
  ].obs;

  // step 3: instructions
  final RxList<String> instructions = <String>[
    'Preheat oven to 200°C (400°F).',
    'Dice the chicken breast into even bite-sized pieces.',
    'Sauté garlic in olive oil, add chicken, and roast until golden.',
  ].obs;

  // step 4: nutrition
  final TextEditingController caloriesController =
      TextEditingController(text: '450');
  final TextEditingController proteinController =
      TextEditingController(text: '48');
  final TextEditingController carbsController =
      TextEditingController(text: '12');
  final TextEditingController fatController = TextEditingController(text: '18');

  // url import controller
  final TextEditingController urlController = TextEditingController();
  final RxBool isImporting = false.obs;

  @override
  void onClose() {
    titleController.dispose();
    descController.dispose();
    prepTimeController.dispose();
    cookTimeController.dispose();
    servingsController.dispose();
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

  void addIngredient(final String name, final String qty) {
    if (name.isNotEmpty) {
      ingredients.add({'name': name, 'qty': qty.isEmpty ? '1 item' : qty});
    }
  }

  void removeIngredient(final int index) {
    if (index >= 0 && index < ingredients.length) {
      ingredients.removeAt(index);
    }
  }

  void addInstruction(final String step) {
    if (step.isNotEmpty) {
      instructions.add(step);
    }
  }

  void removeInstruction(final int index) {
    if (index >= 0 && index < instructions.length) {
      instructions.removeAt(index);
    }
  }

  void importUrl() async {
    final String url = urlController.text.trim();
    if (url.isNotEmpty) {
      isImporting.value = true;
      await Future.delayed(const Duration(milliseconds: 700));
      isImporting.value = false;
      titleController.text = 'Imported Pasta Primavera';
      descController.text = 'Extracted from $url';
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
