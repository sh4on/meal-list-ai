import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/plan_controller.dart';
import 'widgets/day_view/day_view.dart';
import 'widgets/three_day_view/three_day_view.dart';
import 'widgets/week_view/week_view.dart';

// Plan Screen -- main container coordinating Day, 3-Day, and Week views
class PlanScreen extends GetView<PlanController> {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Obx(() {
        return switch (controller.viewMode.value) {
          '3 Days' => const ThreeDayView(),
          'Week' => const WeekView(),
          _ => const DayView(),
        };
      }),
    );
  }
}
