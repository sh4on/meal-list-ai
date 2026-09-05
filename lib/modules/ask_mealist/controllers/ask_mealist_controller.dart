import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

// ask mealist controller
// manages recipe customization prompts, quick suggestions, and AI adaptations
class AskMealistController extends GetxController {
  final TextEditingController promptController = TextEditingController();
  final RxString selectedSuggestion = ''.obs;
  final RxBool isLoading = false.obs;

  // quick suggestions chips matching figma
  final List<Map<String, dynamic>> quickSuggestions = const [
    {'label': 'Make it healthier', 'icon': Icons.add_circle_outline},
    {'label': 'More protein', 'icon': Icons.fitness_center_outlined},
    {'label': 'Under 500 kcal', 'icon': Icons.local_fire_department_outlined},
    {'label': 'Make it vegetarian', 'icon': Icons.eco_outlined},
    {'label': 'Make it dairy-free', 'icon': Icons.water_drop_outlined},
    {'label': 'Make it for 6 people', 'icon': Icons.people_outline},
    {'label': 'Substitute an ingredient', 'icon': Icons.swap_horiz_outlined},
    {'label': 'Make it 20 minutes', 'icon': Icons.timer_outlined},
  ];

  @override
  void onClose() {
    promptController.dispose();
    super.onClose();
  }

  void selectSuggestion(final String label) {
    if (selectedSuggestion.value == label) {
      selectedSuggestion.value = '';
    } else {
      selectedSuggestion.value = label;
      promptController.text = label;
    }
  }

  // trigger adaptation and transition to result screen
  void adaptRecipe() async {
    isLoading.value = true;
    // simulate AI adaptation response
    await Future.delayed(const Duration(milliseconds: 600));
    isLoading.value = false;
    Get.toNamed(
      AppRoutes.askMealistResult,
      arguments: {
        'original': 'Mediterranean Chicken',
        'prompt': promptController.text.isEmpty
            ? 'High-Protein Adaptation'
            : promptController.text,
      },
    );
  }
}
