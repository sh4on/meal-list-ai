import 'package:get/get.dart';
import '../controllers/recipe_creator_controller.dart';

// recipe creator binding
class RecipeCreatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecipeCreatorController>(RecipeCreatorController.new);
  }
}
