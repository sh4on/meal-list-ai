import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

// auth binding — shares one AuthController across all auth screens
// using fenix: true keeps it alive during back-navigation within the auth flow
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(AuthController.new, fenix: true);
  }
}
