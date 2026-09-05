import 'package:get/get.dart';

class PlanController extends GetxController {
  // current selected view mode — week / day / 3-day
  final RxString viewMode = 'Week'.obs;
  final List<String> viewModes = const ['Day', '3-Day', 'Week'];
  final RxInt selectedDayIndex = 0.obs;

  void setViewMode(String mode) => viewMode.value = mode;
  void selectDay(int index) => selectedDayIndex.value = index;
}
