import 'package:flutter/material.dart';
import 'package:nomadworld/utils/api/api_service.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../../domain/provider/provider.dart';
import '../../../models/user_base.dart';
import '../../../utils/helpers/image_picker_helper.dart';
import '../../../utils/providers/user_provider.dart';

class UserEditProfileScreen extends StatefulWidget {
  const UserEditProfileScreen({super.key});

  @override
  State<UserEditProfileScreen> createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  late UserProvider _userProvider;
  late NomadProvider _nomadProvider;

  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
  TextEditingController();

  File? _imageSelected; // Image selected from user

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    _nomadProvider = Provider.of<NomadProvider>(context);
    var userId = _userProvider.user!.id;

    print(userId);



    return Scaffold(
      body: Column(
        children: [
          _buildGreenCard(context),
          // Formulario de edición de usuario
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.09,
                  vertical: MediaQuery.of(context).size.height * 0.03,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Username
                    const Text(
                      'Nombre de usuario*',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _usernameController,
                      maxLines: 1,
                      maxLength: 15,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: _userProvider.user!.username,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),

                    /// First Password
                    const Text(
                      'Contraseña*',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      maxLines: 1,
                      maxLength: 25,
                      minLines: 1,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Contraseña",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),

                    /// Password Confirmation
                    const Text(
                      'Confirmar contraseña*',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),

                    const SizedBox(height: 10),

                    TextFormField(
                      controller: _passwordConfirmationController,
                      maxLines: 1,
                      maxLength: 25,
                      minLines: 1,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Contraseña",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                    /// Botón de guardar
                    Center(
                      child: ElevatedButton(
                        onPressed: () => modifyUser(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff195f47),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Actualizar perfil',
                          style: TextStyle(color: Colors.white),
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
    );
  }

  modifyUser() async {
    String? image;
    String? username;
    String? password;

    // Esta función se encargará de convertir la imagen seleccionada a base64
    if (_imageSelected != null) {
      image = ImagePickerHelper().convertImageToBase64(_imageSelected!);
    } else {
      image = null;
    }

    // Validar que username no esté vacío
    if (_usernameController.text.isEmpty) {
      username = null;
    } else {
      username = _usernameController.text;
    }

    // Validar que password no esté vacío
    if (_passwordController.text.isEmpty) {
      password = null;
    } else {
      password = _passwordController.text;
    }

    // Validar que password y passwordConfirmation sean iguales
    if (_passwordController.text != _passwordConfirmationController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Las contraseñas no coinciden'),
        ),
      );
      return;
    }

    // Llamar a la función de modificar usuario
    String? response = await ApiService().modifyUser(
      _userProvider.user!.id,
      username,
      password,
      image,
    );

    // Actualizar el usuario en el provider
    _userProvider.modifyUser(
      UserBase(
        id: _userProvider.user!.id,
        username: username == null ? _userProvider.user!.username : username!,
        password: password == null ? _userProvider.user!.password : password!,
        email: _userProvider.user!.email,
        image: image == null ? _userProvider.user!.image : response!,
        savedRoutes: _userProvider.user!.savedRoutes,
        savedLocations: _userProvider.user!.savedLocations,
      ),
    );
    print("IMAGEN DEL BACKEND");
    print(response);
    print("USER BASE MODIFICADO");
    print(_userProvider.user!.image);

  }

  /// Esta función se encargará de permitir al usuario elegir entre imagen de galería o cámara.
  Future<void> _selectedImage() async {
    await ImagePickerHelper.showImagePickerDialog(context, (File? image) {
      if (image != null) {
        setState(() {
          _imageSelected = image;
          // String newImage = ImagePickerHelper().convertImageToBase64(image);
          // _userProvider.updateUserImage(newImage);
        });
      }
    });
  }

  /// Green Card
  Widget _buildGreenCard(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: double.infinity,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(150, 0, 0, 0),
                blurRadius: 20,
              ),
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            image: DecorationImage(
              image: AssetImage('assets/card_background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Column(
                children: [
                  // Nombre del usuario
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 20, right: 20, top: 50),
                    child: Text(
                      _userProvider.user!.username,
                      style: const TextStyle(
                        fontSize: 25,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  // Email del usuario
                  Text(
                    _userProvider.user!.email,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),

                  const SizedBox(height: 25),

                  // Icono del usuario
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 65,
                        backgroundImage: _imageSelected != null
                            ? FileImage(_imageSelected!)
                            : _userProvider.user!.image != null
                            ? NetworkImage(_userProvider.user!.image!)
                            : const AssetImage('assets/user_icon.png')
                        as ImageProvider,
                      ),

                      // Icono de edición
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            // Implementar aquí ImagePicker
                            _selectedImage();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Color(0xff195f47),
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        /// Menú
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
