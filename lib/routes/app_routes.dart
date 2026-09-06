// central route name constants
// prevents string literal typos and maintains a single source of truth for routing
abstract final class AppRoutes {
  // auth routes
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String signIn = '/sign-in';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';

  // onboarding routes
  static const String dietaryPreferences = '/onboarding/dietary-preferences';
  static const String favouriteCuisines = '/onboarding/favourite-cuisines';
  static const String allergies = '/onboarding/allergies';
  static const String cookingHousehold = '/onboarding/cooking-household';
  static const String yourGoals = '/onboarding/your-goals';

  // main tab shell
  static const String main = '/main';

  // pantry module
  static const String pantry = '/pantry';
  static const String addToPantry = '/pantry/add';
  static const String searchPantry = '/pantry/search';
  static const String pantryItemDetails = '/pantry/item-details';
  static const String whatCanICook = '/pantry/what-can-i-cook';

  // cook mode module
  static const String cookMode = '/cook-mode';
  static const String cookingComplete = '/cook-mode/complete';

  // ask mealist ai module
  static const String askMealist = '/ask-mealist';
  static const String askMealistResult = '/ask-mealist/result';

  // recipe creation and intake module
  static const String addRecipe = '/recipes/add';
  static const String importFromLink = '/recipes/import-link';
  static const String createRecipeWizard = '/recipes/wizard';
  static const String recipeDetails = '/recipes/details';

  // explore extensions
  static const String cuisineDetail = '/explore/cuisine-detail';
  static const String surpriseMe = '/explore/surprise-me';

  // shopping module
  static const String shoppingList = '/shopping-list';
  static const String shoppingMode = '/shopping-mode';

  // profile & settings sub-screens
  static const String progressInsights = '/profile/progress-insights';
  static const String myGoals = '/profile/my-goals';
  static const String nutritionTargets = '/profile/nutrition-targets';
  static const String personalInfo = '/profile/personal-info';
  static const String manageAllergies = '/profile/manage-allergies';
  static const String foodPreferences = '/profile/food-preferences';
  static const String manageSubscription = '/profile/subscription';
  static const String manageHousehold = '/profile/household';
  static const String addHouseholdMember = '/profile/household/add';
  static const String appSettings = '/profile/app-settings';
  static const String accountSettings = '/profile/account-settings';
  static const String shareYourWeek = '/profile/share-your-week';
}

