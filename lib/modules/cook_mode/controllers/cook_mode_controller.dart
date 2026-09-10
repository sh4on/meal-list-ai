import 'dart:async';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

// cook mode controller
// manages 6-step guided cooking workflow, interactive timers, and completion navigation
class CookModeController extends GetxController {
  // active recipe title
  final RxString recipeName = 'Chicken Rice Bowl'.obs;

  // current step index (0-indexed, 6 total steps matching figma)
  final RxInt currentStep = 0.obs;
  final int totalSteps = 6;

  // 6 guided steps matching the figma cook mode sequence
  final List<Map<String, dynamic>> steps = [
    {
      'title': 'Prepare the ingredients',
      'instruction':
          'Cut the chicken into bite-sized pieces and mince the garlic.',
      'image':
          'https://images.unsplash.com/photo-1544025162-d76694265947?w=800&q=80',
      'ingredients': [
        {'name': 'Chicken', 'amount': '500g', 'icon': 'meat'},
        {'name': 'Olive oil', 'amount': '1 tbsp', 'icon': 'oil'},
        {'name': 'Garlic', 'amount': '2 cloves', 'icon': 'garlic'},
      ],
      'timerSeconds': 300,
      'hint': null,
    },
    {
      'category': 'Prepare the sauce',
      'title': 'Mix the sauce ingredients in a small bowl.',
      'instruction':
          'Whisk yogurt, tahini, lemon juice, and a pinch of salt until smooth. Set aside.',
      'image':
          'https://images.unsplash.com/photo-1472476443507-c7a5948772fc?w=800&q=80',
      'ingredients': [
        {'name': 'Soy sauce', 'amount': '2 tbsp', 'icon': 'drop'},
        {'name': 'Honey', 'amount': '1 tsp', 'icon': 'honey'},
        {'name': 'Pepper', 'amount': '½ tsp', 'icon': 'pepper'},
      ],
      'timerSeconds': 120,
      'hint': 'Optional: Let sit for 2 minutes to meld flavors.',
    },
    {
      'category': 'Cook chicken',
      'title': 'Sear the chicken in a hot skillet.',
      'instruction':
          'Heat olive oil in a non-stick pan over medium heat. Add chicken pieces and sauté for 6–7 minutes until golden brown.',
      'image':
          'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=800&q=80',
      'ingredients': [
        {'name': 'Diced Chicken', 'amount': '500g', 'icon': 'meat'},
        {'name': 'Olive oil', 'amount': '1 tbsp', 'icon': 'oil'},
      ],
      'timerSeconds': 420,
      'hint': null,
    },
    {
      'category': 'Prepare base',
      'title': 'Heat or prepare the cooked rice.',
      'instruction':
          'Fluff warm rice or steam according to instructions until tender and fragrant.',
      'image':
          'https://images.unsplash.com/photo-1516684732162-798a0062be99?w=800&q=80',
      'ingredients': [
        {'name': 'Cooked Rice', 'amount': '2 cups', 'icon': 'rice'},
      ],
      'timerSeconds': 180,
      'hint': null,
    },
    {
      'category': 'Assembly',
      'title': 'Layer bowl ingredients evenly.',
      'instruction':
          'Divide rice into bowls, top with cooked chicken, and add a generous dollop of sauce.',
      'image':
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80',
      'ingredients': [
        {'name': 'Prepared Sauce', 'amount': 'All', 'icon': 'drop'},
        {'name': 'Pomegranate Seeds', 'amount': '2 tbsp', 'icon': 'fruit'},
      ],
      'timerSeconds': 60,
      'hint': null,
    },
    {
      'title': 'Serve immediately and garnish with fresh herbs.',
      'instruction':
          'Your Chicken Rice Bowl is ready! Enjoy the perfectly balanced flavors of the seared chicken and fresh garnishes.',
      'image':
          'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=800&auto=format&fit=crop&q=80',
      'ingredients': [],
      'timerSeconds': 0,
      'hint': null,
    },
  ];

  // interactive countdown timer
  final RxInt remainingSeconds = 300.obs;
  final RxBool isTimerRunning = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is Map && (Get.arguments as Map).containsKey('recipe')) {
      recipeName.value = (Get.arguments as Map)['recipe'] as String;
    }
    _resetTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  // format seconds as MM:SS for the timer capsule
  String get timerString {
    final int minutes = remainingSeconds.value ~/ 60;
    final int seconds = remainingSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void toggleTimer() {
    if (isTimerRunning.value) {
      _pauseTimer();
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    isTimerRunning.value = true;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (final timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        _timer?.cancel();
        isTimerRunning.value = false;
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    isTimerRunning.value = false;
  }

  void _resetTimer() {
    _timer?.cancel();
    isTimerRunning.value = false;
    final int seconds = steps[currentStep.value]['timerSeconds'] as int? ?? 300;
    remainingSeconds.value = seconds;
  }

  void nextStep() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
      _resetTimer();
    } else {
      Get.offNamed(AppRoutes.cookingComplete);
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
      _resetTimer();
    }
  }
}
