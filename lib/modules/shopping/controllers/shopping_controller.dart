import 'package:get/get.dart';

// shopping controller — manages list items and checked state
class ShoppingController extends GetxController {
  // toggle between By Aisle and By Recipe views
  final RxInt selectedTab = 0.obs;
  final List<String> tabs = const ['By Aisle', 'By Recipe'];

  // mock shopping list data grouped by category
  final RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockData();
  }

  void _loadMockData() {
    categories.assignAll([
      {
        'category': 'PRODUCE',
        'icon': '🌿',
        'items': [
          {'name': 'Tomatoes', 'qty': '6 items', 'checked': false},
          {'name': 'Spinach', 'qty': '250 g', 'checked': false},
        ],
      },
      {
        'category': 'DAIRY',
        'icon': '🥛',
        'items': [
          {'name': 'Milk', 'qty': '1 L', 'checked': false},
          {
            'name': 'Greek Yogurt',
            'qty': '1kg',
            'buy': '600g',
            'pantry': '400g',
            'checked': false,
          },
        ],
      },
      {
        'category': 'MEAT & SEAFOOD',
        'icon': '🥩',
        'items': [
          {
            'name': 'Chicken',
            'qty': '1.2 kg • Consolidated from 3 recipes',
            'checked': false,
          },
        ],
      },
    ]);

    // collected items that are already checked
    collectedItems.assignAll([
      'Olive Oil',
      'Garlic',
    ]);
  }

  final RxList<String> collectedItems = <String>[].obs;

  void switchTab(int index) => selectedTab.value = index;

  void toggleItem(int catIndex, int itemIndex) {
    final List<Map<String, dynamic>> cats =
        List<Map<String, dynamic>>.from(categories);
    final List<dynamic> items = List<dynamic>.from(
      cats[catIndex]['items'] as List<dynamic>,
    );
    final Map<String, dynamic> item =
        Map<String, dynamic>.from(items[itemIndex] as Map<String, dynamic>);
    item['checked'] = !(item['checked'] as bool);
    items[itemIndex] = item;
    cats[catIndex] = Map<String, dynamic>.from(cats[catIndex])
      ..['items'] = items;
    categories.assignAll(cats);
  }
}
