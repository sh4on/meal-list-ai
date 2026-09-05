import 'package:get/get.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    // fenix keeps controller alive across all onboarding steps
    Get.lazyPut<OnboardingController>(OnboardingController.new, fenix: true);
  }
}
