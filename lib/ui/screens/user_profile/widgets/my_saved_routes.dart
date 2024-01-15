import 'package:flutter/material.dart';
import 'package:nomadworld/utils/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MySavedRoutes extends StatefulWidget {
  MySavedRoutes({super.key});

  @override
  State<MySavedRoutes> createState() => _MySavedRoutesState();
}

class _MySavedRoutesState extends State<MySavedRoutes> {
  // Instancia of the UserProvider
  late UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);

    /// Muestra el número de rutas guardadas en consola
    print('@@@@ RUTAS: ${_userProvider.savedLocations.length}');

    return _userProvider.savedRoutes.isEmpty
        ? const Center(
            child: Text('No hay rutas guardadas'),
          )
        : GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.3),
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 15.0,
            ),
            itemCount: _userProvider.savedRoutes.length,
            itemBuilder: (context, index) {
              final item = _userProvider.savedRoutes[index];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/ruta',
                    arguments: item,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    image: DecorationImage(
                      image: NetworkImage(_userProvider
                          .savedRoutes[index].locations[0].images[0]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Text(
                    _userProvider.savedRoutes[index].name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
  }
}
