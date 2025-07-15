import 'package:get/get.dart';
import '../../core/error/failure.dart';
import '../../core/utils/hive_key.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import 'package:hive/hive.dart';

class AuthController extends GetxController {
  final LoginUsecase loginUsecase;
  final SignupUsecase signupUsecase;
  AuthController(this.loginUsecase, this.signupUsecase);

  final loading = false.obs;
  final error   = Rxn<String>();

  Future<void> login(String email, String pass) async {
    loading.value = true;
    error.value   = null;
    try {
      final token = await loginUsecase(email, pass);
      await _saveToken(token.value);
      Get.offAllNamed('/todos');
    } on Failure catch (f) {
      error.value = f.message;
    } finally {
      loading.value = false;
    }
  }

  Future<void> signup(String n, String e, String p) async {
    loading.value = true;
    error.value   = null;
    try {
      final token = await signupUsecase(n, e, p);
      await _saveToken(token.value);
      Get.offAllNamed('/todos');
    } on Failure catch (f) {
      error.value = f.message;
    } finally {
      loading.value = false;
    }
  }

  Future<void> _saveToken(String tok) async {
    final box = await Hive.openBox(HiveKeys.authBox);
    await box.put(HiveKeys.jwtToken, tok);
  }
}
