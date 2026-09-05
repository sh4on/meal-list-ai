import 'package:get/get.dart';

// recipes controller — manages recipe library and search
class RecipesController extends GetxController {
  final RxString searchQuery = ''.obs;

  // mock recipe list
  final RxList<Map<String, String>> recipes = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockData();
  }

  void _loadMockData() {
    recipes.assignAll([
      {
        'name': 'Greek Yogurt Berry Bowl',
        'time': '5m',
        'kcal': '380 kcal',
        'tag': 'Breakfast',
        'image':
            'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=400&q=80',
      },
      {
        'name': 'Grilled Chicken Rice Bowl',
        'time': '30m',
        'kcal': '520 kcal',
        'tag': 'Lunch',
        'image':
            'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=400&q=80',
      },
      {
        'name': 'Creamy Tomato Pasta',
        'time': '25m',
        'kcal': '610 kcal',
        'tag': 'Dinner',
        'image':
            'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=400&q=80',
      },
      {
        'name': 'High-Protein Chicken Shawarma Bowl',
        'time': '35m',
        'kcal': '620 kcal',
        'tag': 'Dinner',
        'image':
            'https://images.unsplash.com/photo-1529006557810-274b9b2fc783?w=400&q=80',
      },
    ]);
  }
}
