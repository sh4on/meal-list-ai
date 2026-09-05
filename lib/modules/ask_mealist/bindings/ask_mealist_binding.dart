import 'package:get/get.dart';
import '../controllers/ask_mealist_controller.dart';

// ask mealist binding configuration
class AskMealistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AskMealistController>(AskMealistController.new);
  }
}
