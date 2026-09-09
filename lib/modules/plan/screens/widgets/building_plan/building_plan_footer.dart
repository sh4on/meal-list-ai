import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildingPlanFooter extends StatelessWidget {
  const BuildingPlanFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Mealist is balancing your nutrition goals,\npreferences, cooking time and available\ningredients.',
      style: TextStyle(
        color: const Color(0xFF6B6B6B),
        fontSize: 13.sp,
        height: 1.45,
      ),
      textAlign: TextAlign.center,
    );
  }
}
