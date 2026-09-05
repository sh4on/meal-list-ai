import 'package:get/get.dart';

// home controller
// manages today's meal plan and macro summary data
class HomeController extends GetxController {
  final Rx<RxStatus> status = Rx<RxStatus>(RxStatus.success());

  // user greeting data
  final RxString userName = 'Alex'.obs;
  final RxString greeting = 'Good morning'.obs;
  final RxString dateLabel = 'Monday, August 24'.obs;

  // calorie ring data
  final RxInt totalCalories = 1900.obs;
  final RxInt consumedCalories = 1420.obs;
  final RxDouble proteinConsumed = 92.0.obs;
  final RxDouble proteinTotal = 130.0.obs;
  final RxDouble carbsConsumed = 145.0.obs;
  final RxDouble carbsTotal = 210.0.obs;
  final RxDouble fatConsumed = 48.0.obs;
  final RxDouble fatTotal = 65.0.obs;

  // today's meals mock data
  final RxList<Map<String, dynamic>> todaysMeals = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockData();
  }

  // mock data population
  // provides initial ui representation corresponding to figma specifications
  void _loadMockData() {
    todaysMeals.assignAll([
      {
        'type': 'BREAKFAST',
        'time': '7:30 AM',
        'name': 'Greek Yogurt Berry Bowl',
        'calories': 380,
        'isCooked': true,
        'image':
            'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=200&q=80',
      },
      {
        'type': 'LUNCH',
        'time': '12:30 PM',
        'name': 'Grilled Chicken Rice Bowl',
        'calories': 520,
        'protein': '42g',
        'isCooked': false,
        'image':
            'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=200&q=80',
      },
      {
        'type': 'DINNER',
        'time': '7:30 PM',
        'name': 'Creamy Tomato Pasta',
        'calories': 610,
        'protein': '24g',
        'isCooked': false,
        'image':
            'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=200&q=80',
      },
    ]);
  }
}
