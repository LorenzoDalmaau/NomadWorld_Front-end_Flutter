import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controllers for the text fields
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  // Function to register the user
  void registerUser(String username, String email, String password) async {
    var url = Uri.parse('http://192.168.56.1:8000/register');

    // Creating the user object
    Map<String, dynamic> userMap = {
      'username': username,
      'email': email,
      'password': password
    };

    // Sending the user object to the server
    var response = await http.post(url,
        body: convert.jsonEncode(userMap),
        headers: {'Content-Type': 'application/json'});

    // Checking the response
    if (response.statusCode == 201) {
      var jsonResponse = response.body;

      if (jsonResponse.contains('User created successfully')) {
        Get.snackbar('Genial!', 'Usuario registrado correctamente',
            snackPosition: SnackPosition.BOTTOM);
        Get.offAllNamed('/login');
      } else {
        // Mostrar un mensaje de error si la respuesta no contiene el mensaje esperado
        Get.snackbar('Error', 'Error en la respuesta del servidor',
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      // Mostrar el código de estado HTTP si la respuesta no es 201
      Get.snackbar('Error', 'HTTP Error: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

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
              child: SingleChildScrollView(
                reverse: true,
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                    .onDrag, // Controla el comportamiento del teclado
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(150, 0, 0, 0),
                        blurRadius: 50,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 80),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 40),
                        // Username field
                        TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            hintText: 'Username',
                          ),
                        ),
                        const SizedBox(height: 40),
                        // Email field
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            hintText: 'email@example.com',
                          ),
                        ),

                        const SizedBox(height: 40),
                        // Password field
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                          ),
                        ),

                        const SizedBox(height: 40),
                        // Password confirmation
                        TextFormField(
                          controller: passwordConfirmationController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Password confirmation',
                          ),
                        ),

                        const SizedBox(height: 80),
                        // Register button
                        ElevatedButton(
                          onPressed: () {
                            if (passwordController.text.toString() ==
                                passwordConfirmationController.text
                                    .toString()) {
                              registerUser(
                                  usernameController.text.toString(),
                                  emailController.text.toString(),
                                  passwordController.text.toString());
                            } else {
                              Get.snackbar(
                                  'Error', 'Las contraseñas no coinciden',
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF195F47),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 80),
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
            ),
          ],
        ),
      ),
    );
  }
}
