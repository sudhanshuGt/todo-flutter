import 'package:get/get.dart';
import '../../core/error/failure.dart';
import '../../core/utils/hive_key.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import 'package:hive/hive.dart';

/// Controller responsible for managing authentication flow.
/// Uses GetX for state management and Hive for local token storage.
class AuthController extends GetxController {
  final LoginUsecase loginUsecase;   // Handles login business logic
  final SignupUsecase signupUsecase; // Handles signup business logic

  AuthController(this.loginUsecase, this.signupUsecase);

  /// Observables for UI state management
  final loading = false.obs;   // Tracks loading state for login/signup actions
  final error   = Rxn<String>(); // Holds error messages for display in the UI

  /// Performs user login using provided [email] and [pass].
  /// On success: stores JWT token locally and navigates to '/todos'.
  /// On failure: sets [error] message for UI.
  Future<void> login(String email, String pass) async {
    loading.value = true; // Start loading indicator
    error.value   = null; // Clear previous errors

    try {
      final token = await loginUsecase(email, pass); // Execute login use case
      await _saveToken(token.value);                 // Persist token locally
      Get.offAllNamed('/todos');                     // Navigate to main screen
    } on Failure catch (f) {
      error.value = f.message; // Capture domain-level error for UI display
    } finally {
      loading.value = false; // Stop loading indicator regardless of outcome
    }
  }

  /// Performs user signup with name [n], email [e], and password [p].
  /// On success: stores JWT token locally and navigates to '/todos'.
  /// On failure: sets [error] message for UI.
  Future<void> signup(String n, String e, String p) async {
    loading.value = true;
    error.value   = null;

    try {
      final token = await signupUsecase(n, e, p); // Execute signup use case
      await _saveToken(token.value);              // Persist token locally
      Get.offAllNamed('/todos');                  // Navigate to main screen
    } on Failure catch (f) {
      error.value = f.message; // Capture domain-level error for UI display
    } finally {
      loading.value = false; // Stop loading indicator
    }
  }

  /// Saves JWT [tok] into Hive local storage for future authenticated requests.
  Future<void> _saveToken(String tok) async {
    final box = await Hive.openBox(HiveKeys.authBox); // Open auth storage box
    await box.put(HiveKeys.jwtToken, tok);            // Save token securely
  }
}
