import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/common_widgets/app_text_field_widget.dart';
import '../../../shared/common_widgets/primary_button_widget.dart';

// personal info screen
// allows updating account demographics, physical metrics, and activity level
class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameCtrl =
        TextEditingController(text: 'Alex Morgan');
    final TextEditingController emailCtrl =
        TextEditingController(text: 'alex@email.com');
    final TextEditingController ageCtrl = TextEditingController(text: '28');
    final TextEditingController heightCtrl =
        TextEditingController(text: '175 cm');
    final TextEditingController weightCtrl =
        TextEditingController(text: '72 kg');

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: Get.back,
        ),
        title: const Text('Personal Info', style: AppTextStyles.headlineSmall),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenH.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSpacing.md.h),
            AppTextFieldWidget(
              label: 'Full Name',
              hint: 'Your name',
              controller: nameCtrl,
            ),
            SizedBox(height: AppSpacing.md.h),
            AppTextFieldWidget(
              label: 'Email Address',
              hint: 'Your email',
              controller: emailCtrl,
            ),
            SizedBox(height: AppSpacing.md.h),
            Row(
              children: [
                Expanded(
                  child: AppTextFieldWidget(
                    label: 'Age',
                    hint: '28',
                    controller: ageCtrl,
                  ),
                ),
                SizedBox(width: AppSpacing.md.w),
                Expanded(
                  child: AppTextFieldWidget(
                    label: 'Height',
                    hint: '175 cm',
                    controller: heightCtrl,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.md.h),
            AppTextFieldWidget(
              label: 'Weight',
              hint: '72 kg',
              controller: weightCtrl,
            ),
            SizedBox(height: AppSpacing.xl.h),
            PrimaryButtonWidget(
              label: 'Save Info',
              onTap: () {
                Get.back();
                Get.snackbar(
                  'Profile Updated',
                  'Your personal details have been updated.',
                  backgroundColor: AppColors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  margin: const EdgeInsets.all(AppSpacing.md),
                );
              },
            ),
            SizedBox(height: AppSpacing.xxxl.h),
          ],
        ),
      ),
    );
  }
}
