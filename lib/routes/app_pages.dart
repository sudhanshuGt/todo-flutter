import 'package:get/get.dart';
import 'package:myapp/routes/routes.dart';


 import '../presentation/bindings/auth_bindings.dart';
import '../presentation/bindings/todo_binding.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/signup_screen.dart';
import '../presentation/screens/todo/todo_screen.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.signup,
      page: () => const SignupPage(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.todos,
      page: () => const TodoPage(),
      binding: TodoBinding(),
      transition: Transition.leftToRight,
    ),
  ];
}
