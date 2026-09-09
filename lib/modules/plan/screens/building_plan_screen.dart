import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import 'widgets/building_plan/building_plan_checklist_card.dart';
import 'widgets/building_plan/building_plan_footer.dart';
import 'widgets/building_plan/rotating_dashed_ring.dart';

class BuildingPlanScreen extends StatefulWidget {
  const BuildingPlanScreen({super.key});

  @override
  State<BuildingPlanScreen> createState() => _BuildingPlanScreenState();
}

class _BuildingPlanScreenState extends State<BuildingPlanScreen> {
  final List<String> _steps = const [
    'Checking your goals',
    'Reviewing dietary preferences',
    'Building balanced meals',
    'Using your pantry ingredients',
    'Finalizing your week',
  ];

  int _currentStep = 2;
  Timer? _stepTimer;

  @override
  void initState() {
    super.initState();
    _startProgressAnimation();
  }

  void _startProgressAnimation() {
    _stepTimer = Timer.periodic(const Duration(milliseconds: 900), (timer) {
      if (!mounted) return;
      if (_currentStep < _steps.length - 1) {
        setState(() {
          _currentStep++;
        });
      } else {
        timer.cancel();
        Future.delayed(const Duration(milliseconds: 600), () {
          if (!mounted) return;
          Get.back();
          Get.snackbar(
            'Plan Created',
            'Your personalized 7-day meal plan is ready!',
            backgroundColor: AppColors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(16),
            duration: const Duration(seconds: 3),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _stepTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 90.h),

              // Animated Sparkle Orb + Dashed Ring
              const RotatingDashedRing(size: 140),

              SizedBox(height: 36.h),

              // Headline
              Text(
                'Building your plan...',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 28.h),

              // Checklist Card
              BuildingPlanChecklistCard(
                steps: _steps,
                currentStep: _currentStep,
              ),

              SizedBox(height: 28.h),

              // Subtitle Footer
              const BuildingPlanFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
