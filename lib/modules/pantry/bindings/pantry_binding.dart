import 'package:get/get.dart';
import '../controllers/pantry_controller.dart';

// pantry binding configuration
// registering pantry controller lazily optimizes memory consumption
class PantryBinding extends Bindings {
  @override
  void dependencies() {
    // lazy injection ensures controller is instantiated only when pantry is visited
    Get.lazyPut<PantryController>(PantryController.new);
  }
}
