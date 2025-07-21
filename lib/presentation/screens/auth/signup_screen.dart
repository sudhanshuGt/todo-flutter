import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';

/// Signup screen using GetX for state management.
///
/// Provides input fields for name, email, and password.
/// Uses [AuthController] for handling sign-up logic and showing loading/errors.
class SignupPage extends GetView<AuthController> {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers for user input fields
    final nameCtrl  = TextEditingController();
    final emailCtrl = TextEditingController();
    final passCtrl  = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Name input
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12),

            // Email input
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),

            // Password input
            TextField(
              controller: passCtrl,
              obscureText: true, // Hide password characters
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 24),

            // Signup button or loading indicator
            Obx(() => controller.loading.value
                ? const CircularProgressIndicator() // Show while signing up
                : ElevatedButton(
              onPressed: () => controller.signup(
                nameCtrl.text.trim(),
                emailCtrl.text.trim(),
                passCtrl.text,
              ),
              child: const Text('Create Account'),
            ),
            ),
            const SizedBox(height: 12),

            // Navigation back to login screen
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Already registered? Log in'),
            ),

            // Display errors if any
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
