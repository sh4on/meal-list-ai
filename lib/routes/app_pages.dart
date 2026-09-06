import 'package:get/get.dart';
import '../modules/ask_mealist/bindings/ask_mealist_binding.dart';
import '../modules/ask_mealist/screens/ask_mealist_result_screen.dart';
import '../modules/ask_mealist/screens/ask_mealist_screen.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/screens/forgot_password_screen.dart';
import '../modules/auth/screens/register_screen.dart';
import '../modules/auth/screens/reset_password_screen.dart';
import '../modules/auth/screens/sign_in_screen.dart';
import '../modules/auth/screens/welcome_screen.dart';
import '../modules/cook_mode/bindings/cook_mode_binding.dart';
import '../modules/cook_mode/screens/cook_mode_screen.dart';
import '../modules/cook_mode/screens/cooking_complete_screen.dart';
import '../modules/explore/screens/cuisine_detail_screen.dart';
import '../modules/explore/screens/for_you_screen.dart';
import '../modules/explore/screens/search_results_screen.dart';
import '../modules/explore/screens/surprise_me_screen.dart';
import '../modules/main_shell/bindings/main_shell_binding.dart';
import '../modules/main_shell/screens/main_shell_screen.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/screens/allergies_screen.dart';
import '../modules/onboarding/screens/cooking_household_screen.dart';
import '../modules/onboarding/screens/dietary_preferences_screen.dart';
import '../modules/onboarding/screens/favourite_cuisines_screen.dart';
import '../modules/onboarding/screens/your_goals_screen.dart';
import '../modules/pantry/bindings/pantry_binding.dart';
import '../modules/pantry/screens/add_to_pantry_screen.dart';
import '../modules/pantry/screens/my_pantry_screen.dart';
import '../modules/pantry/screens/what_can_i_cook_screen.dart';
import '../modules/profile/screens/account_settings_screen.dart';
import '../modules/profile/screens/add_household_member_screen.dart';
import '../modules/profile/screens/app_settings_screen.dart';
import '../modules/profile/screens/food_preferences_screen.dart';
import '../modules/profile/screens/manage_allergies_screen.dart';
import '../modules/profile/screens/manage_household_screen.dart';
import '../modules/profile/screens/manage_subscription_screen.dart';
import '../modules/profile/screens/my_goals_screen.dart';
import '../modules/profile/screens/nutrition_targets_screen.dart';
import '../modules/profile/screens/personal_info_screen.dart';
import '../modules/profile/screens/progress_insights_screen.dart';
import '../modules/profile/screens/share_your_week_screen.dart';
import '../modules/recipes/bindings/recipe_creator_binding.dart';
import '../modules/recipes/screens/add_recipe_screen.dart';
import '../modules/recipes/screens/create_recipe_wizard_screen.dart';
import '../modules/recipes/screens/import_from_link_screen.dart';
import '../modules/recipes/screens/recipe_details_screen.dart';
import '../modules/shopping/bindings/shopping_binding.dart';
import '../modules/shopping/screens/shopping_list_screen.dart';
import '../modules/shopping/screens/shopping_mode_screen.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/screens/splash_screen.dart';
import 'app_routes.dart';

// central page registry
// registers all application pages and their corresponding dependency bindings
abstract final class AppPages {
  static final List<GetPage<dynamic>> pages = [
    // auth flow
    GetPage(
      name: AppRoutes.splash,
      page: SplashScreen.new,
      binding: SplashBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.welcome,
      page: WelcomeScreen.new,
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: SignInScreen.new,
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.register,
      page: RegisterScreen.new,
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: ForgotPasswordScreen.new,
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: ResetPasswordScreen.new,
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),

    // onboarding flow
    GetPage(
      name: AppRoutes.dietaryPreferences,
      page: DietaryPreferencesScreen.new,
      binding: OnboardingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.favouriteCuisines,
      page: FavouriteCuisinesScreen.new,
      binding: OnboardingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.allergies,
      page: AllergiesScreen.new,
      binding: OnboardingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.cookingHousehold,
      page: CookingHouseholdScreen.new,
      binding: OnboardingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.yourGoals,
      page: YourGoalsScreen.new,
      binding: OnboardingBinding(),
      transition: Transition.rightToLeft,
    ),

    // main app shell
    GetPage(
      name: AppRoutes.main,
      page: MainShellScreen.new,
      binding: MainShellBinding(),
      transition: Transition.fadeIn,
    ),

    // pantry module
    GetPage(
      name: AppRoutes.pantry,
      page: MyPantryScreen.new,
      binding: PantryBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.addToPantry,
      page: AddToPantryScreen.new,
      binding: PantryBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.whatCanICook,
      page: WhatCanICookScreen.new,
      binding: PantryBinding(),
      transition: Transition.rightToLeft,
    ),

    // cook mode module
    GetPage(
      name: AppRoutes.cookMode,
      page: CookModeScreen.new,
      binding: CookModeBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: AppRoutes.cookingComplete,
      page: CookingCompleteScreen.new,
      transition: Transition.fadeIn,
    ),

    // ask mealist ai module
    GetPage(
      name: AppRoutes.askMealist,
      page: AskMealistScreen.new,
      binding: AskMealistBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: AppRoutes.askMealistResult,
      page: AskMealistResultScreen.new,
      transition: Transition.rightToLeft,
    ),

    // recipes module & creator wizard
    GetPage(
      name: AppRoutes.recipeDetails,
      page: RecipeDetailsScreen.new,
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.addRecipe,
      page: AddRecipeScreen.new,
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.importFromLink,
      page: ImportFromLinkScreen.new,
      binding: RecipeCreatorBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.createRecipeWizard,
      page: CreateRecipeWizardScreen.new,
      binding: RecipeCreatorBinding(),
      transition: Transition.rightToLeft,
    ),

    // explore extensions
    GetPage(
      name: AppRoutes.cuisineDetail,
      page: CuisineDetailScreen.new,
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.surpriseMe,
      page: SurpriseMeScreen.new,
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.exploreForYou,
      page: ForYouScreen.new,
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.searchResults,
      page: SearchResultsScreen.new,
      transition: Transition.rightToLeft,
    ),

    // shopping module
    GetPage(
      name: AppRoutes.shoppingList,
      page: ShoppingListScreen.new,
      binding: ShoppingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.shoppingMode,
      page: ShoppingModeScreen.new,
      transition: Transition.downToUp,
    ),

    // profile & settings sub-screens
    GetPage(
      name: AppRoutes.progressInsights,
      page: ProgressInsightsScreen.new,
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.myGoals,
      page: MyGoalsScreen.new,
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.nutritionTargets,
      page: NutritionTargetsScreen.new,
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.personalInfo,
      page: PersonalInfoScreen.new,
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.manageAllergies,
      page: ManageAllergiesScreen.new,
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.foodPreferences,
      page: FoodPreferencesScreen.new,
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.manageSubscription,
      page: ManageSubscriptionScreen.new,
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.manageHousehold,
      page: ManageHouseholdScreen.new,
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.addHouseholdMember,
      page: AddHouseholdMemberScreen.new,
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.appSettings,
      page: AppSettingsScreen.new,
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.accountSettings,
      page: AccountSettingsScreen.new,
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.shareYourWeek,
      page: ShareYourWeekScreen.new,
      transition: Transition.rightToLeft,
    ),
  ];
}
