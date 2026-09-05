import 'package:get/get.dart';
import '../controllers/cook_mode_controller.dart';

// cook mode binding configuration
// lazily provides the cook mode controller upon entering cook assistance
class CookModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CookModeController>(CookModeController.new);
  }
}
