import 'package:flutter/material.dart';
import 'package:nomadworld/utils/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../widgets/user_profile/rcard.dart';
import '../../../widgets/user_profile/rl_card.dart';

class MySavedRoutes extends StatefulWidget {
  MySavedRoutes({super.key});

  @override
  State<MySavedRoutes> createState() => _MySavedRoutesState();
}

class _MySavedRoutesState extends State<MySavedRoutes> {
  // Instancia of the UserProvider
  late UserProvider _userProvider;

  // Primero se crea la lista vacía
  // Añades la lista que tiene localizaciones de la función de ApiService en esa lista
  // Interactuas con esa lista vacía

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);

    /// Muestra el número de rutas guardadas en consola
    print('@@@@ RUTAS: ${_userProvider.savedRoutes.length}');

    return _userProvider.savedRoutes.isEmpty
        ? const Center(
            child: Text('No hay rutas guardadas'),
          )
        : ListView.builder(
            itemCount: _userProvider.savedRoutes.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Rcard(
                savedRoute: _userProvider.savedRoutes[index],
                updateList: () {
                  setState(() {});
                },
              ),
            ),
          );
  }
}
