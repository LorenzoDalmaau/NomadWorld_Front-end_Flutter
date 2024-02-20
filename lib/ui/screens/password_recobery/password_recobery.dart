import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomadworld/models/user_base.dart';
import 'package:nomadworld/utils/api/api_service.dart';
import 'package:nomadworld/utils/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecoveryPasswordScreen extends StatefulWidget {
  const RecoveryPasswordScreen({super.key});

  @override
  State<RecoveryPasswordScreen> createState() => _RecoveryPasswordScreenState();
}

class _RecoveryPasswordScreenState extends State<RecoveryPasswordScreen> {
  late Size mediaSize;

  TextEditingController emailController = TextEditingController();

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
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
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
          'Recobery password',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        _buildGreenText("Please enter your Email address"),
        const SizedBox(height: 25),
        _buildGreenText("Email address"),
        _buildInputField(emailController),
        const SizedBox(height: 100,),
        _buildButton()
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

  Widget _buildInputField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: "Email",

        suffixIcon: Icon(Icons.alternate_email)
      ),
    );
  }

  Widget _buildButton(){
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          if(emailController.text == ""){
            Get.snackbar('Error!', 'Debes introducir tu correo ',
                snackPosition: SnackPosition.BOTTOM);
          }
          else{
            var response = await ApiService().restorePassword(emailController.text);

            if(response){
              Get.snackbar('Genial!', 'Contraseña restablecida correctamente',
                  snackPosition: SnackPosition.BOTTOM);
            }
            else{
              Get.snackbar('Error!', 'Ha ocurrido un error al restaurar tu contraseña, comprueba el correo electronico',
                  snackPosition: SnackPosition.BOTTOM);
            }

          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF195F47),
          padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 13),
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          elevation: 20,
        ),
        child: const Text(
          'Recovery password',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
