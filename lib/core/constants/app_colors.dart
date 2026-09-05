import 'package:flutter/material.dart';

// all brand colors extracted from figma design tokens
// keeping these centralized ensures consistent design across the whole app
abstract final class AppColors {
  // background — warm cream used as the main app background
  static const Color bg = Color(0xFFF5F3EE);

  // primary — deep forest green, used for buttons, active states, logo
  static const Color primary = Color(0xFF2D5F4F);
  static const Color primaryLight = Color(0xFF3D7A65);
  static const Color primarySurface = Color(0xFFE8F0ED);

  // accent — golden orange for AI/sparkle indicators and highlights
  static const Color accent = Color(0xFFE8A838);
  static const Color accentSurface = Color(0xFFFDF3E1);

  // text colors
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textTertiary = Color(0xFFAAAAAA);
  static const Color textInverse = Color(0xFFFFFFFF);
  static const Color textLink = Color(0xFF2D5F4F);

  // surface/card colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color cardBgSecondary = Color(0xFFF9F7F3);

  // border and divider
  static const Color border = Color(0xFFE0DDD6);
  static const Color divider = Color(0xFFEEECE8);

  // nav bar
  static const Color navBar = Color(0xFFFFFFFF);
  static const Color navActive = Color(0xFF2D5F4F);
  static const Color navInactive = Color(0xFFAAAAAA);

  // status colors
  static const Color success = Color(0xFF2D5F4F);
  static const Color successSurface = Color(0xFFE8F0ED);
  static const Color error = Color(0xFFD94040);
  static const Color errorSurface = Color(0xFFFDECEC);
  static const Color warning = Color(0xFFE8A838);

  // meal type indicators
  static const Color breakfast = Color(0xFFE8A838);
  static const Color lunch = Color(0xFF4A90A4);
  static const Color dinner = Color(0xFF7B6CF6);

  // progress bar track
  static const Color progressTrack = Color(0xFFE0DDD6);
  static const Color progressProtein = Color(0xFF2D5F4F);
  static const Color progressCarbs = Color(0xFFE8A838);
  static const Color progressFat = Color(0xFFD94040);

  // chip — unselected state
  static const Color chipUnselected = Color(0xFFFFFFFF);
  static const Color chipUnselectedBorder = Color(0xFFE0DDD6);
  static const Color chipSelected = Color(0xFF2D5F4F);
  static const Color chipSelectedText = Color(0xFFFFFFFF);

  // skeleton/shimmer
  static const Color shimmerBase = Color(0xFFE8E5DF);
  static const Color shimmerHighlight = Color(0xFFF5F3EE);

  // overlay scrim
  static const Color scrim = Color(0x80000000);
}
