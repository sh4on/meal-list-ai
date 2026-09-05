import 'package:get/get.dart';

// bottom nav controller — tracks active tab index
// using a shared controller so any module can switch tabs programmatically
class BottomNavController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeTo(int index) => currentIndex.value = index;
}
