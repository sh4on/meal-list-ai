import 'package:get/get.dart';
import '../controllers/recipes_controller.dart';

// recipes binding configuration
// registering recipes controller lazily ensures memory is managed efficiently
class RecipesBinding extends Bindings {
  @override
  void dependencies() {
    // lazy injection allows controller creation only when the recipes feature is accessed
    Get.lazyPut<RecipesController>(RecipesController.new);
  }
}
