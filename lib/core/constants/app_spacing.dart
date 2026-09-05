// spacing and sizing constants in logical pixels
// all values use .w or .h from flutter_screenutil for responsive scaling
// text sizes are excluded from scaling per project rules
abstract final class AppSpacing {
  // base unit: 4px
  static const double xxs = 4.0;
  static const double xs = 8.0;
  static const double sm = 12.0;
  static const double md = 16.0;
  static const double lg = 20.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double xxxl = 40.0;
  static const double huge = 48.0;
  static const double giant = 64.0;

  // screen edge padding — consistent horizontal padding on all screens
  static const double screenH = 20.0;
  static const double screenV = 24.0;

  // card internal padding
  static const double cardPadding = 16.0;
  static const double cardPaddingLg = 20.0;

  // section gap — vertical space between major sections on a screen
  static const double sectionGap = 28.0;

  // item gap — space between list/grid items
  static const double itemGap = 12.0;
  static const double itemGapSm = 8.0;
  static const double itemGapLg = 16.0;

  // bottom nav height
  static const double bottomNavHeight = 72.0;

  // app bar height
  static const double appBarHeight = 56.0;

  // button height
  static const double buttonHeight = 52.0;
  static const double buttonHeightSm = 40.0;

  // input field height
  static const double inputHeight = 52.0;

  // icon sizes
  static const double iconXs = 14.0;
  static const double iconSm = 18.0;
  static const double iconMd = 22.0;
  static const double iconLg = 26.0;
  static const double iconXl = 32.0;

  // avatar sizes
  static const double avatarSm = 32.0;
  static const double avatarMd = 48.0;
  static const double avatarLg = 72.0;
  static const double avatarXl = 88.0;

  // meal card thumbnail
  static const double mealThumb = 72.0;

  // recipe card image height
  static const double recipeCardImage = 180.0;

  // cuisine grid item height
  static const double cuisineGridHeight = 120.0;

  // calorie ring size
  static const double calorieRingSize = 96.0;
}
