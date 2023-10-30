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
  late Size mediaSize;
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
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    mediaSize = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          // image: AssetImage("assets/images/background.png"),
          image: AssetImage("assets/travel3.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Color.fromARGB(192, 25, 95, 71),
            BlendMode.darken,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: 40,
              child: _buildTop(),
            ),
            Positioned(
              bottom: -3,
              child: _buildBotton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            image: AssetImage("assets/Nomad.png"),
            width: 200,
            height: 200,
          ), 
        ],
      ),
    );
  }

  Widget _buildBotton() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Welcome',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        _buildGreenText("Please register with your information"),
        const SizedBox(height: 25),
        _buildGreenText("Username"),
        _buildInputField(usernameController),
        const SizedBox(height: 20),
        _buildGreenText("Email Address"),
        _buildInputField(emailController),
        const SizedBox(height: 20),
        _buildGreenText("Password"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 20),
        _buildGreenText("Password Confirmation"),
        _buildInputField(passwordConfirmationController, isPassword: true),
        const SizedBox(height: 20),
        _buildRegisterButton(),
      ],
    );
  }

  Widget _buildGreenText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF195F47),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? const Icon(Icons.remove_red_eye)
            : const Icon(Icons.person_2_outlined),
      ),
      obscureText: isPassword,
    );
  }

  // Register Button
  Widget _buildRegisterButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (passwordController.text.toString() ==
              passwordConfirmationController.text.toString()) {
            registerUser(
                usernameController.text.toString(),
                emailController.text.toString(),
                passwordController.text.toString());
          } else {
            Get.snackbar('Error', 'Las contraseñas no coinciden',
                snackPosition: SnackPosition.BOTTOM);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF195F47),
          padding: const EdgeInsets.symmetric(horizontal: 80),
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
    );
  }
}
