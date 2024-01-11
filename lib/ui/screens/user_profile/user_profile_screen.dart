import 'package:flutter/material.dart';
import 'package:nomadworld/ui/screens/user_profile/widgets/my_saved_locations.dart';
import 'package:nomadworld/ui/screens/user_profile/widgets/my_saved_routes.dart';
import 'package:provider/provider.dart';
import '../../../utils/providers/user_provider.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  // Instancia of the UserProvider
  late UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);

    if (_userProvider.user!.savedLocations.length == 0) {
      print("@@@@@@@No hay rutas guardadas@@@@@@@");
      print(_userProvider.user!.savedLocations.length);
    } else {
      print("@@@@@@@Hay rutas guardadas@@@@@@@");
      print(_userProvider.user!.savedLocations.length);
    }

    return Scaffold(
      body: Column(
        children: [
          _buildGreenCard(context),
          // TAB BAR VIEW
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TabBar(
                    labelColor: Colors.black,
                    indicatorColor: Colors.black,
                    tabs: [
                      Tab(text: "Mis rutas"),
                      Tab(text: "Mis Localizaciones"),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: TabBarView(
                    children: [
                      MySavedRoutes(),
                      MySavedLocations(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
                        const EdgeInsets.only(left: 50, right: 50, top: 50),
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
                  CircleAvatar(
                    radius: 65,
                    backgroundImage: NetworkImage(_userProvider.user!.image),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}



