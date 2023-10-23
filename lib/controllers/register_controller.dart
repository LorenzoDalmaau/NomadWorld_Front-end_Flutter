import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomadworld/data/data_provider/api_provider.dart';
import 'package:nomadworld/data/models/user.dart';
import 'package:nomadworld/data/repositories/user_repository.dart';

class RegisterController extends GetxController {
  final UserRepository _userRepository = UserRepository(ApiProvider());

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  final imageController = TextEditingController();

  Future<void> registerUser() async {
    final username = usernameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    try {
      final user = User(
        username: username,
        email: email,
        password: password,
        image: imageController.text,
      );

      await _userRepository.registerUser(user);

      Get.snackbar('Éxito', 'Usuario registrado exitosamente');
      Get.offNamed('/login');
    } catch (e) {
      Get.snackbar('Error', 'Error al registrar el usuario: $e');
    }
  }

  @override
  void dispose() {
    // Limpia los controladores cuando el controlador es eliminado
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    imageController.dispose();
    super.dispose();
  }
}
