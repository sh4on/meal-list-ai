import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

// splash controller — decides navigation target after init delay
// in a real app this would check auth token and redirect accordingly
class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    // small delay so the logo animation is visible before navigating
    Future.delayed(const Duration(seconds: 2), _navigate);
  }

  void _navigate() {
    // replace so user cannot back-navigate to splash
    Get.offAllNamed(AppRoutes.welcome);
  }

  // allows retry button to re-trigger navigation when load takes too long
  void onRetry() => _navigate();
}
