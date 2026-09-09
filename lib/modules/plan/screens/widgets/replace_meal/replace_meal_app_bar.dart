import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';

class ReplaceMealAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onFilterTap;

  const ReplaceMealAppBar({
    super.key,
    this.title = 'Replace Monday Lunch',
    this.onFilterTap,
  });

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.bg,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: AppColors.primary,
          size: 24,
        ),
        onPressed: () => Get.back(),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.tune_rounded,
            color: AppColors.textPrimary,
            size: 22,
          ),
          onPressed: onFilterTap ?? () {},
        ),
        SizedBox(width: 8.w),
      ],
    );
  }
}
