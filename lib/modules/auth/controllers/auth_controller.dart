import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

// auth controller — manages form state and navigation for all auth screens
class AuthController extends GetxController {
  // observable fields for reactive form state
  final RxBool isSignInLoading = false.obs;
  final RxBool isRegisterLoading = false.obs;
  final RxBool isForgotLoading = false.obs;
  final RxBool showSignInPassword = false.obs;
  final RxBool showRegisterPassword = false.obs;
  final RxBool showRegisterConfirmPassword = false.obs;

  // navigate to registration screen
  void goToRegister() => Get.toNamed(AppRoutes.register);

  // navigate to sign in screen
  void goToSignIn() => Get.toNamed(AppRoutes.signIn);

  // navigate to forgot password screen
  void goToForgotPassword() => Get.toNamed(AppRoutes.forgotPassword);

  // simulate sign-in — replace with real API call when backend is ready
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isSignInLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isSignInLoading.value = false;
    // navigate to onboarding — your goals is always step 1
    Get.offAllNamed(AppRoutes.yourGoals);
  }

  // simulate registration
  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    isRegisterLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isRegisterLoading.value = false;
    Get.offAllNamed(AppRoutes.yourGoals);
  }

  // simulate forgot password email send
  Future<void> sendResetEmail(String email) async {
    isForgotLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isForgotLoading.value = false;
    Get.toNamed(AppRoutes.resetPassword);
  }

  void toggleSignInPasswordVisibility() =>
      showSignInPassword.value = !showSignInPassword.value;

  void toggleRegisterPasswordVisibility() =>
      showRegisterPassword.value = !showRegisterPassword.value;

  void toggleRegisterConfirmPasswordVisibility() =>
      showRegisterConfirmPassword.value = !showRegisterConfirmPassword.value;
}
