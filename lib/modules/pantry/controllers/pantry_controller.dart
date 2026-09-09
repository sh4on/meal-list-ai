import 'package:get/get.dart';

// pantry controller
// manages inventory categories, item filtering, and what-can-i-cook discovery
class PantryController extends GetxController {
  // active storage section filter tab: All, Fridge, Freezer, Pantry
  final RxString selectedTab = 'All'.obs;
  final List<String> tabs = const ['All', 'Fridge', 'Freezer', 'Pantry'];

  // search query observable for filtering items by name
  final RxString searchQuery = ''.obs;

  // storage categories and their associated ingredients
  final RxList<Map<String, dynamic>> fridgeItems = <Map<String, dynamic>>[
    {
      'name': 'Baby Spinach',
      'urgency': 'Use in 2 days',
      'qty': '1',
      'unit': 'bag',
      'storedIn': 'Fridge',
      'image':
          'https://images.unsplash.com/photo-1576045057995-568f588f82fb?w=200&q=80',
      'addedOn': '2023-10-08',
      'useBy': '2023-10-10',
    },
    {
      'name': 'Feta Cheese',
      'urgency': 'Use in 3 days',
      'qty': '200',
      'unit': 'g',
      'storedIn': 'Fridge',
      'image':
          'https://images.unsplash.com/photo-1559561853-08451507cbe7?w=200&q=80',
      'addedOn': '2023-10-07',
      'useBy': '2023-10-11',
    },
    {
      'name': 'Greek Yogurt',
      'urgency': 'Use within 4 days',
      'qty': '500',
      'unit': 'g',
      'storedIn': 'Fridge',
      'image':
          'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=200&q=80',
      'addedOn': '2023-10-12',
      'useBy': '2023-10-20',
    },
    {
      'name': 'Red Bell Pepper',
      'urgency': null,
      'qty': '2',
      'unit': 'items',
      'storedIn': 'Fridge',
      'image':
          'https://images.unsplash.com/photo-1563565375-f3fdfdbefa83?w=200&q=80',
      'addedOn': '2023-10-06',
      'useBy': null,
    },
  ].obs;

  final RxList<Map<String, dynamic>> pantryItems = <Map<String, dynamic>>[
    {
      'name': 'Quinoa',
      'urgency': null,
      'qty': '500',
      'unit': 'g',
      'storedIn': 'Pantry',
      'image': null,
      'addedOn': '2023-10-01',
      'useBy': null,
    },
    {
      'name': 'Olive Oil',
      'urgency': null,
      'qty': '1',
      'unit': 'bottle',
      'storedIn': 'Pantry',
      'image':
          'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=200&q=80',
      'addedOn': '2023-09-28',
      'useBy': null,
    },
  ].obs;

  final RxList<Map<String, dynamic>> freezerItems = <Map<String, dynamic>>[
    {
      'name': 'Chicken breast',
      'urgency': null,
      'qty': '600',
      'unit': 'g',
      'storedIn': 'Freezer',
      'image':
          'https://images.unsplash.com/photo-1604503468506-a8da13d82791?w=200&q=80',
      'addedOn': '2023-10-05',
      'useBy': null,
    },
    {
      'name': 'Cooked chicken',
      'urgency': 'Use in 1 day',
      'qty': '250',
      'unit': 'g',
      'storedIn': 'Fridge',
      'image':
          'https://images.unsplash.com/photo-1598103442097-8b74394b95c6?w=200&q=80',
      'addedOn': '2023-10-11',
      'useBy': '2023-10-12',
    },
    {
      'name': 'Mixed Berries',
      'urgency': null,
      'qty': '1',
      'unit': 'bag',
      'storedIn': 'Freezer',
      'image':
          'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=200&q=80',
      'addedOn': '2023-09-30',
      'useBy': null,
    },
  ].obs;

  // update active category tab
  void selectTab(final String tab) {
    selectedTab.value = tab;
  }

  // update search query string
  void updateSearch(final String query) {
    searchQuery.value = query;
  }

  // get all items combined
  List<Map<String, dynamic>> get allItems => [
        ...fridgeItems,
        ...pantryItems,
        ...freezerItems,
      ];

  // search across all items
  List<Map<String, dynamic>> searchItems(final String query) {
    if (query.isEmpty) return [];
    final String q = query.toLowerCase();
    return allItems.where((final item) {
      final String name = (item['name'] as String).toLowerCase();
      return name.contains(q);
    }).toList();
  }

  // add an item to the designated storage category
  void addItem({
    required final String name,
    required final String category,
    required final String qty,
    final String unit = 'pcs',
    final String? useBy,
  }) {
    final String now = _formatDate(DateTime.now());
    final Map<String, dynamic> item = {
      'name': name,
      'urgency': null,
      'qty': qty,
      'unit': unit,
      'storedIn': category,
      'image': null,
      'addedOn': now,
      'useBy': useBy,
    };

    switch (category.toLowerCase()) {
      case 'fridge':
        fridgeItems.add(item);
        break;
      case 'freezer':
        freezerItems.add(item);
        break;
      case 'pantry':
      default:
        pantryItems.add(item);
        break;
    }
  }

  // remove an item by name and stored location
  void removeItem(final Map<String, dynamic> item) {
    final String storedIn = ((item['storedIn'] as String?) ?? '').toLowerCase();
    switch (storedIn) {
      case 'fridge':
        fridgeItems.removeWhere((final i) => i['name'] == item['name']);
        break;
      case 'freezer':
        freezerItems.removeWhere((final i) => i['name'] == item['name']);
        break;
      case 'pantry':
      default:
        pantryItems.removeWhere((final i) => i['name'] == item['name']);
        break;
    }
  }

  // update an existing item
  void updateItem(
    final Map<String, dynamic> original,
    final Map<String, dynamic> updated,
  ) {
    final String storedIn =
        ((original['storedIn'] as String?) ?? '').toLowerCase();
    void update(final RxList<Map<String, dynamic>> list) {
      final int idx =
          list.indexWhere((final i) => i['name'] == original['name']);
      if (idx != -1) {
        list[idx] = updated;
        list.refresh();
      }
    }

    switch (storedIn) {
      case 'fridge':
        update(fridgeItems);
        break;
      case 'freezer':
        update(freezerItems);
        break;
      case 'pantry':
      default:
        update(pantryItems);
        break;
    }
  }

  String _formatDate(final DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }
}
