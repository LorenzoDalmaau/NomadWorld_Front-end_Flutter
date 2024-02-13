import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/providers/user_provider.dart';

class UserEditProfileScreen extends StatefulWidget {
  const UserEditProfileScreen({super.key});

  @override
  State<UserEditProfileScreen> createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  late UserProvider _userProvider;

  TextEditingController _imageController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);

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
                        onPressed: () {
                          // Implementa aquí la lógica para guardar los cambios
                          // Puedes utilizar el método setState para actualizar los datos del usuario
                          // Ejemplo: setState(() => _userProvider.user!.username = _usernameController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff195f47),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Guardar',
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
                          color: Colors.white),
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

                  const SizedBox(height: 20),

                  // Icono del usuario
                  // Icono del usuario
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            NetworkImage(_userProvider.user!.image),
                      ),

                      // Icono de edición
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            // Implementa aquí la lógica para cambiar la imagen
                            // Puedes abrir un diálogo de selección de imagen, por ejemplo.
                            // También puedes utilizar Navigator para navegar a otra pantalla de edición de imagen.
                            // Ejemplo: Navigator.push(context, MaterialPageRoute(builder: (context) => ImageEditScreen()));
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
                  color: Colors.black,
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
