import 'package:get/get.dart';

// profile controller — user info and settings state
class ProfileController extends GetxController {
  final RxString userName = 'Alex'.obs;
  final RxString userEmail = 'alex@email.com'.obs;
  final RxDouble profileCompletion = 0.85.obs;

  final List<Map<String, String>> settingsItems = const [
    {'icon': 'flag', 'label': 'MY GOALS'},
    {'icon': 'nutrition', 'label': 'NUTRITION TARGETS'},
    {'icon': 'restaurant', 'label': 'FOOD PREFERENCES'},
    {'icon': 'block', 'label': 'ALLERGIES & RESTRICTIONS'},
    {'icon': 'person', 'label': 'PERSONAL INFO'},
  ];

  final List<Map<String, String>> accountItems = const [
    {'icon': 'insights', 'label': 'PROGRESS & INSIGHTS'},
    {'icon': 'star', 'label': 'SUBSCRIPTION'},
    {'icon': 'settings', 'label': 'APP SETTINGS'},
  ];
}
