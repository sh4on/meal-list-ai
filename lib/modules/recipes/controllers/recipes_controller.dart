import 'package:get/get.dart';

// recipes controller — manages recipe library state including search, filter, sort and favourites
class RecipesController extends GetxController {
  final RxString searchQuery = ''.obs;

  // active category chip selection — 'All' shows every recipe
  final RxString selectedCategory = 'All'.obs;

  // sort mode — 'Most Cooked' | 'Newest' | 'Quickest'
  final RxString sortBy = 'Most Cooked'.obs;

  // full recipe list with rich mock data matching the Figma design
  final RxList<Map<String, dynamic>> recipes = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockData();
  }

  void _loadMockData() {
    recipes.assignAll([
      {
        'name': 'Turkish Lentil Chicken Bowl',
        'time': '25m',
        'kcal': 540,
        'protein': 42,
        'category': 'Lunch',
        'isFavorite': true,
        'cookedCount': 12,
        'image':
            'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=800&q=80',
      },
      {
        'name': 'Mediterranean Salmon',
        'time': '30m',
        'kcal': 480,
        'protein': 38,
        'category': 'Dinner',
        'isFavorite': false,
        'cookedCount': 8,
        'image':
            'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=800&q=80',
      },
      {
        'name': 'Overnight Oats',
        'time': '5m',
        'kcal': 320,
        'protein': 15,
        'category': 'Breakfast',
        'isFavorite': true,
        'cookedCount': 24,
        'image':
            'https://images.unsplash.com/photo-1517673400267-0251440c45dc?w=800&q=80',
      },
      {
        'name': 'Grilled Chicken Wrap',
        'time': '20m',
        'kcal': 410,
        'protein': 35,
        'category': 'Lunch',
        'isFavorite': false,
        'cookedCount': 5,
        'image':
            'https://images.unsplash.com/photo-1565299507177-b0ac66763828?w=800&q=80',
      },
      {
        'name': 'Avocado Egg Toast',
        'time': '10m',
        'kcal': 280,
        'protein': 12,
        'category': 'Breakfast',
        'isFavorite': false,
        'cookedCount': 18,
        'image':
            'https://images.unsplash.com/photo-1588137378633-dea1336ce1e2?w=800&q=80',
      },
      {
        'name': 'Creamy Tomato Pasta',
        'time': '25m',
        'kcal': 610,
        'protein': 18,
        'category': 'Dinner',
        'isFavorite': false,
        'cookedCount': 3,
        'image':
            'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=800&q=80',
      },
      {
        'name': 'Trail Mix Energy Bites',
        'time': '15m',
        'kcal': 180,
        'protein': 6,
        'category': 'Snacks',
        'isFavorite': false,
        'cookedCount': 7,
        'image':
            'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=800&q=80',
      },
    ]);
  }

  // filtered + sorted list used by the UI — reacts to search, category and sort changes
  List<Map<String, dynamic>> get filteredRecipes {
    List<Map<String, dynamic>> result = List.from(recipes);

    // apply category filter
    if (selectedCategory.value != 'All') {
      result = result
          .where((final r) => r['category'] == selectedCategory.value)
          .toList();
    }

    // apply search query
    if (searchQuery.value.isNotEmpty) {
      final String q = searchQuery.value.toLowerCase();
      result = result
          .where(
            (final r) => (r['name'] as String).toLowerCase().contains(q),
          )
          .toList();
    }

    // apply sort — most cooked and quickest have explicit ordering
    switch (sortBy.value) {
      case 'Most Cooked':
        result.sort(
          (final a, final b) =>
              (b['cookedCount'] as int).compareTo(a['cookedCount'] as int),
        );
      case 'Quickest':
        result.sort((final a, final b) {
          final int aMin =
              int.tryParse((a['time'] as String).replaceAll('m', '')) ?? 0;
          final int bMin =
              int.tryParse((b['time'] as String).replaceAll('m', '')) ?? 0;
          return aMin.compareTo(bMin);
        });
      // 'Newest' keeps insertion order as default
    }

    return result;
  }

  // toggles the heart/favourite state for a recipe at the given index in the master list
  void toggleFavorite(final int masterIndex) {
    final Map<String, dynamic> recipe = recipes[masterIndex];
    recipes[masterIndex] = {
      ...recipe,
      'isFavorite': !(recipe['isFavorite'] as bool),
    };
    recipes.refresh();
  }

  // finds the master-list index of a recipe by name and toggles its favourite
  void toggleFavoriteByName(final String name) {
    final int idx = recipes.indexWhere((final r) => r['name'] == name);
    if (idx != -1) toggleFavorite(idx);
  }
}
