import 'package:get/get.dart';

// explore controller — search state and content data
class ExploreController extends GetxController {
  final RxString searchQuery = ''.obs;
  final RxBool isSearching = false.obs;

  // browse cuisines list for the grid section
  final List<Map<String, String>> cuisines = const [
    {
      'name': 'Italian',
      'image':
          'https://images.unsplash.com/photo-1595295333158-4742f28fbd85?w=400&q=80',
    },
    {
      'name': 'Mexican',
      'image':
          'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=400&q=80',
    },
    {
      'name': 'Japanese',
      'image':
          'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=400&q=80',
    },
    {
      'name': 'Mediterranean',
      'image':
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400&q=80',
    },
    {
      'name': 'Indian',
      'image':
          'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=400&q=80',
    },
    {
      'name': 'Turkish',
      'image':
          'https://images.unsplash.com/photo-1529006557810-274b9b2fc783?w=400&q=80',
    },
  ];

  // fresh this week collections
  final List<Map<String, String>> freshThisWeek = const [
    {
      'title': 'Vibrant Spring Soups',
      'subtitle': 'Light, fresh, and perfect for the season.',
      'image':
          'https://images.unsplash.com/photo-1476718406336-bb5a9690ee2a?w=200&q=80',
    },
    {
      'title': 'One-Pan Wonders',
      'subtitle': 'Minimal cleanup, maximum flavor.',
      'image':
          'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=200&q=80',
    },
  ];

  // made for you recipe cards
  final List<Map<String, String>> madeForYou = const [
    {
      'name': 'Crispy Skin Salmon with Quinoa & Asparagus',
      'time': '25m',
      'kcal': '450 kcal',
      'match': '92%',
      'tag': 'High protein · fits your 30-minute preference',
      'image':
          'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=400&q=80',
    },
    {
      'name': 'Mediterranean Harvest Bowl',
      'time': '15m',
      'kcal': '380 kcal',
      'match': '87%',
      'tag': 'Low cal · Mediterranean cuisine',
      'image':
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&q=80',
    },
  ];

  void updateSearch(String query) => searchQuery.value = query;
  void clearSearch() {
    searchQuery.value = '';
    isSearching.value = false;
  }
}
