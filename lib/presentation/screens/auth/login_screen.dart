import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';
import '../../controller/auth_controller.dart';

/// Login screen using GetX for state management.
///
/// Provides input fields for email and password,
/// and handles navigation to the signup screen if the user doesn't have an account.
class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers for text input fields
    final emailCtrl = TextEditingController();
    final passCtrl  = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Email input field
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),

            // Password input field
            TextField(
              controller: passCtrl,
              obscureText: true, // Hides password input
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 24),

            // Login button or loading indicator
            Obx(() => controller.loading.value
                ? const CircularProgressIndicator() // Show loader while logging in
                : ElevatedButton(
              onPressed: () => controller.login(
                emailCtrl.text.trim(),
                passCtrl.text,
              ),
              child: const Text('Login'),
            ),
            ),
            const SizedBox(height: 12),

            // Navigation to signup page
            TextButton(
              onPressed: () => Get.toNamed(Routes.signup),
              child: const Text('No account? Sign up'),
            ),

            // Display error messages, if any
            Obx(() => controller.error.value == null
                ? const SizedBox.shrink()
                : Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                controller.error.value!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
