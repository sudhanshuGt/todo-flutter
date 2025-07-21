import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/routes/app_pages.dart';
import 'package:myapp/routes/routes.dart';

import 'di/service_locator.dart' as di;

/// Entry point of the application.
void main() async {
  // Ensures that plugin services are initialized before runApp is called.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize all dependencies (DI setup: repositories, use cases, controllers, etc.)
  await di.init();

  // Launch the root widget of the app.
  runApp(const MyApp());
}

/// Root widget of the application.
///
/// Uses [GetMaterialApp] for routing and dependency injection.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Todo',

      // Define the initial screen of the app.
      initialRoute: Routes.login,

      // Define the application's named routes.
      getPages: AppPages.pages,

      // Disable the debug banner for production-like appearance.
      debugShowCheckedModeBanner: false,
    );
  }
}
