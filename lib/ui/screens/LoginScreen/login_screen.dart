import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Size mediaSize;
  
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  // Function to login the user
  void loginUser(String email, String password) async {
    var url = Uri.parse('http://192.168.56.1:8000/login');

    // Creating the user object
    Map<String, dynamic> userMap = {'email': email, 'password': password};

    // Sending the user object to the server
    var response = await http.post(
      url,
      body: convert.jsonEncode(userMap),
      headers: {'Content-Type': 'application/json'},
    );

    // Checking the response
    if (response.statusCode == 200) {
      var jsonResponse = response.body;

      if (jsonResponse.contains('User logged successfully')) {
        Get.snackbar('Genial!', 'Has iniciado sesión correctamente',
            snackPosition: SnackPosition.BOTTOM);
        Get.offAllNamed('/home');
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
              child: _buildBottom(),
            )
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
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50)
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
        _buildGreenText("Please login with your information"),
        const SizedBox(height: 25),
        _buildGreenText("Email address"),
        _buildInputField(emailController),
        const SizedBox(height: 20),
        _buildGreenText("Password"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 10),
        _buildRegisterText(),
        const SizedBox(height: 30),
        _buildLoginButton()
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

  Widget _buildInputField(TextEditingController controller, {isPassword = false}) {
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

  Widget _buildLoginButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // loginUser(emailController.text.toString(),
          //     passwordController.text.toString());
          Get.toNamed("/home");
        },
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
          'Login',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterText() {
    return Row(
      children: [
        const Text(
          "¿Todavía no tienes cuenta?",
          style: TextStyle(fontSize: 13),
        ),
        InkWell(
          onTap: () {
            Get.toNamed('/register');
          },
          child: const Text(
            " Crear una cuenta",
            style: TextStyle(
                fontSize: 13,
                color: Color(0xFF195F47),
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ],
    );
  }

}
