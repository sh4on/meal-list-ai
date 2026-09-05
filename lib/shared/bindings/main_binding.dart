import 'package:get/get.dart';
import '../../core/services/network_service.dart';

// main application initial binding
// establishes global singletons and services available throughout the entire app lifetime
class MainBinding extends Bindings {
  @override
  void dependencies() {
    // network service instance registration for direct access by feature controllers
    Get.put<NetworkService>(NetworkService.instance, permanent: true);
  }
}
