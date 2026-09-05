import 'package:get/get.dart';
import '../controllers/shopping_controller.dart';

// shopping list binding configuration
// registering shopping controller lazily ensures memory efficiency
class ShoppingBinding extends Bindings {
  @override
  void dependencies() {
    // lazy injection allows controller creation only when the shopping list is opened
    Get.lazyPut<ShoppingController>(ShoppingController.new);
  }
}
