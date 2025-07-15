import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';
import '../../controller/auth_controller.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailCtrl = TextEditingController();
    final passCtrl  = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 24),
            Obx(() => controller.loading.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () => controller.login(
                emailCtrl.text.trim(),
                passCtrl.text,
              ),
              child: const Text('Login'),
            )),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Get.toNamed(Routes.signup),
              child: const Text('No account? Sign up'),
            ),
            Obx(() => controller.error.value == null
                ? const SizedBox.shrink()
                : Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                controller.error.value!,
                style: const TextStyle(color: Colors.red),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
