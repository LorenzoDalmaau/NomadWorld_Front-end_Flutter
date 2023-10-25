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

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void registerUser(String username, String email, String password) async {
    var url = Uri.parse('http://127.0.0.1:8000/register');
    var response = await http.post(url, body: {
      'username': username,
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        Get.offAllNamed('/login');
      } else {
        
      }
    } else {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                hintText: 'Username',
              ),
            ),

            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'aaaaa@gmail.com',
              ),
            ),

            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'password',
              ),
            ),

            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                registerUser(usernameController.text.toString(), emailController.text.toString(), passwordController.text.toString());
              },
              child: const Text('Register!'),
            ),
          ],
        ),
      ),
    );
  }
}
