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
    Get.put<BottomNavController>(BottomNavController(), permanent: true);
    Get.put<HomeController>(HomeController(), permanent: true);
    Get.put<PlanController>(PlanController(), permanent: true);
    Get.put<RecipesController>(RecipesController(), permanent: true);
    Get.put<ExploreController>(ExploreController(), permanent: true);
    Get.put<ProfileController>(ProfileController(), permanent: true);
  }
}
