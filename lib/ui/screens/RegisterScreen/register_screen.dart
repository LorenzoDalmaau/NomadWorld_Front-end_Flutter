import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:nomadworld/utils/api/api_service.dart';

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
  TextEditingController passwordConfirmationController = TextEditingController();

  bool _obscureText = true;
  bool _obscureText2 = true;

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
        // _buildInputField(usernameController),
        /// Username
        _buildUsernameInputField(),
        const SizedBox(height: 20),
        _buildGreenText("Email Address"),
        // _buildInputField(emailController),
        _buildEmailInputField(),
        const SizedBox(height: 20),
        _buildGreenText("Password"),
        // _buildInputField(passwordController, isPassword: true),
        _buildPasswordInputField(),
        const SizedBox(height: 20),
        _buildGreenText("Password Confirmation"),
        // _buildInputField(passwordConfirmationController, isPassword: true),
        /// Password confirmation
        _buildSeccondPasswordInputField(),
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

  Widget _buildUsernameInputField() {
    return TextField(
      controller: usernameController,
      decoration: InputDecoration(
        hintText: 'Username',
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
      ),
    );
  }

  static const shadowFocused = BoxShadow(color: Colors.teal, blurRadius: 8.0);
  static const shadowNorm = BoxShadow(color: Colors.transparent, blurRadius: 0.0);
  
  Widget _buildEmailInputField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [shadowFocused],
      ),
      child: TextField(
        controller: emailController,
        decoration: InputDecoration(
          hoverColor: Colors.blue,
          hintText: 'Email',
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          prefixIcon: const Icon(
            Icons.email,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: Colors.blueAccent, // Border color when focused
            ),
          ),
        ),
      ),
    );
  }




  Widget _buildPasswordInputField() {
    return TextField(
      controller: passwordController,
      obscureText: _obscureText,
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: const Icon(
          Icons.lock,
          color: Colors.grey,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(end: 5.0),
          child: InkWell(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSeccondPasswordInputField() {
    return TextField(
      controller: passwordConfirmationController,
      obscureText: _obscureText2,
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: const Icon(
          Icons.lock,
          color: Colors.grey,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(end: 5.0),
          child: InkWell(
            onTap: () {
              setState(() {
                _obscureText2 = !_obscureText2;
              });
            },
            child: Icon(
              _obscureText2 ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  // Register Button
  Widget _buildRegisterButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (passwordController.text.toString() ==
              passwordConfirmationController.text.toString()) {
            ApiService().registerUser(
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
