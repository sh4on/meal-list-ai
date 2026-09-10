import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_text_styles.dart';

// options bottom sheet shown when user taps ⋮ on a recipe card
// actions: share, edit, duplicate, version history, add to collection, report, delete
class RecipeOptionsBottomSheet {
  const RecipeOptionsBottomSheet._();

  static void show(
    final BuildContext context, {
    required final String recipeName,
  }) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.xl),
        ),
      ),
      builder: (_) => _RecipeOptionsContent(recipeName: recipeName),
    );
  }
}

class _RecipeOptionsContent extends StatelessWidget {
  final String recipeName;

  const _RecipeOptionsContent({required this.recipeName});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: AppSpacing.md.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // drag handle
            Container(
              margin: EdgeInsets.only(top: AppSpacing.sm.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            SizedBox(height: AppSpacing.sm.h),

            // standard options
            _OptionTile(
              icon: Icons.share_outlined,
              label: 'Share',
              onTap: () => Navigator.pop(context),
            ),
            _OptionTile(
              icon: Icons.edit_outlined,
              label: 'Edit Recipe',
              onTap: () => Navigator.pop(context),
            ),
            _OptionTile(
              icon: Icons.copy_outlined,
              label: 'Duplicate',
              onTap: () => Navigator.pop(context),
            ),
            _OptionTile(
              icon: Icons.history_outlined,
              label: 'Version History',
              onTap: () => Navigator.pop(context),
            ),
            _OptionTile(
              icon: Icons.add_box_outlined,
              label: 'Add to Collection',
              onTap: () => Navigator.pop(context),
            ),
            _OptionTile(
              icon: Icons.flag_outlined,
              label: 'Report a Problem',
              onTap: () => Navigator.pop(context),
            ),

            Divider(
              height: 1,
              color: AppColors.divider,
              indent: AppSpacing.screenH.w,
              endIndent: AppSpacing.screenH.w,
            ),

            // destructive delete option in red
            _OptionTile(
              icon: Icons.delete_outline,
              label: 'Delete',
              color: AppColors.error,
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

// single option row within the bottom sheet
class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _OptionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final Color tileColor = color ?? AppColors.textPrimary;
    return ListTile(
      leading: Icon(icon, color: tileColor, size: AppSpacing.iconMd),
      title: Text(
        label,
        style: AppTextStyles.titleSmall.copyWith(
          color: tileColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.screenH.w,
        vertical: 2.h,
      ),
    );
  }
}
