import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'shared/bindings/main_binding.dart';

// root application widget
// encapsulates ScreenUtilInit for responsive screen adaptations and GetMaterialApp configuration
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ScreenUtilInit configures design dimensions based on figma canvas (390 x 844)
    // this ensures all responsive .w and .h sizing scales proportionately on diverse screen sizes
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (final BuildContext context, final Widget? child) {
        return GetMaterialApp(
          title: 'Mealist.ai',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          initialRoute: AppRoutes.splash,
          getPages: AppPages.pages,
          initialBinding: MainBinding(),
          defaultTransition: Transition.cupertino,
        );
      },
    );
  }
}
