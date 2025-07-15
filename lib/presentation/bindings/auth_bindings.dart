import 'package:get/get.dart';

import '../../di/service_locator.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../controller/auth_controller.dart';


class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(
      sl<LoginUsecase>(),
      sl<SignupUsecase>(),
    ));
  }
}
