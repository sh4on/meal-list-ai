import 'dart:async';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

// cook mode controller
// controls active step progression, timers, and screen awake state
class CookModeController extends GetxController {
  // active recipe title
  final RxString recipeName = 'Chicken Rice Bowl'.obs;

  // current step index (0-indexed, displayed as 1-based to user)
  final RxInt currentStep = 0.obs;
  final int totalSteps = 4;

  // step details dataset
  final List<Map<String, dynamic>> steps = [
    {
      'title': 'Prepare the ingredients',
      'instruction':
          'Cut the chicken into bite-sized pieces and mince the garlic.',
      'image':
          'https://images.unsplash.com/photo-1544025162-d76694265947?w=800&q=80',
      'ingredients': [
        {'name': 'Chicken', 'amount': '500g'},
        {'name': 'Olive oil', 'amount': '1 tbsp'},
        {'name': 'Garlic', 'amount': '2 cloves'},
      ],
      'timerSeconds': 300,
    },
    {
      'title': 'Sear the chicken',
      'instruction':
          'Heat olive oil in a non-stick pan over medium heat. Add chicken pieces and sauté until golden brown on all sides.',
      'image':
          'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=800&q=80',
      'ingredients': [
        {'name': 'Marinated Chicken', 'amount': '500g'},
        {'name': 'Olive oil', 'amount': '1 tbsp'},
      ],
      'timerSeconds': 420,
    },
    {
      'title': 'Steam the rice',
      'instruction':
          'Combine washed rice and water in a saucepan. Bring to a gentle boil, then cover and simmer on low for 15 minutes.',
      'image':
          'https://images.unsplash.com/photo-1516684732162-798a0062be99?w=800&q=80',
      'ingredients': [
        {'name': 'Jasmine Rice', 'amount': '1 cup'},
        {'name': 'Water', 'amount': '1.5 cups'},
      ],
      'timerSeconds': 900,
    },
    {
      'title': 'Assemble the bowl',
      'instruction':
          'Layer warm rice into bowls, top with seared chicken, garnish with fresh herbs and sesame seeds, then serve hot.',
      'image':
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80',
      'ingredients': [
        {'name': 'Cooked Rice', 'amount': 'All'},
        {'name': 'Seared Chicken', 'amount': 'All'},
        {'name': 'Sesame Seeds', 'amount': '1 tsp'},
      ],
      'timerSeconds': 60,
    },
  ];

  // interactive step countdown timer
  final RxInt remainingSeconds = 300.obs;
  final RxBool isTimerRunning = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _resetTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  // advance to the next step or conclude cooking
  void nextStep() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
      _resetTimer();
    } else {
      Get.offNamed(AppRoutes.cookingComplete);
    }
  }

  // retreat to the preceding step
  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
      _resetTimer();
    }
  }

  // toggle countdown timer
  void toggleTimer() {
    if (isTimerRunning.value) {
      _timer?.cancel();
      isTimerRunning.value = false;
    } else {
      isTimerRunning.value = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (final Timer t) {
        if (remainingSeconds.value > 0) {
          remainingSeconds.value--;
        } else {
          t.cancel();
          isTimerRunning.value = false;
        }
      });
    }
  }

  // reset timer to active step duration
  void _resetTimer() {
    _timer?.cancel();
    isTimerRunning.value = false;
    final int sec = steps[currentStep.value]['timerSeconds'] as int? ?? 300;
    remainingSeconds.value = sec;
  }

  // formatted timer string: mm:ss
  String get timerString {
    final int m = remainingSeconds.value ~/ 60;
    final int s = remainingSeconds.value % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}
