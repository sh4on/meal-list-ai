import 'package:get/get.dart';
import '../../../shared/controllers/bottom_nav_controller.dart';
import '../../explore/controllers/explore_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../plan/controllers/plan_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../recipes/controllers/recipes_controller.dart';

// main shell binding
// registers all tab controllers eagerly so they are accessible during bottom navigation transitions
class MainShellBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavController>(BottomNavController.new, fenix: true);
    Get.lazyPut<HomeController>(HomeController.new, fenix: true);
    Get.lazyPut<PlanController>(PlanController.new, fenix: true);
    Get.lazyPut<RecipesController>(RecipesController.new, fenix: true);
    Get.lazyPut<ExploreController>(ExploreController.new, fenix: true);
    Get.lazyPut<ProfileController>(ProfileController.new, fenix: true);
  }
}
