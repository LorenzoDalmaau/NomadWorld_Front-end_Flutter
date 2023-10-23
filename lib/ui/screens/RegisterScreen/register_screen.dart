import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomadworld/controllers/register_controller.dart';
import 'package:nomadworld/ui/widgets/custom_textfield.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterController controller = Get.put(RegisterController());

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color(0xFF195F47),
              Color.fromARGB(255, 20, 134, 94),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Icon(
                Icons.logo_dev_rounded,
                size: 150,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(150, 0, 0, 0), blurRadius: 50)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 40),
                      CustomTextField(
                        controller: controller.usernameController,
                        hintText: 'Nombre de usuario',
                        isPassword: false,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: controller.emailController,
                        hintText: 'Correo electrónico',
                        isPassword: false,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: controller.passwordController,
                        hintText: 'Contraseña',
                        isPassword: true,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: controller.repeatPasswordController,
                        hintText: 'Repetir Contraseña',
                        isPassword: true,
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () => controller.registerUser(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF195F47),
                          padding: const EdgeInsets.symmetric(horizontal: 100),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          elevation: 20,
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

