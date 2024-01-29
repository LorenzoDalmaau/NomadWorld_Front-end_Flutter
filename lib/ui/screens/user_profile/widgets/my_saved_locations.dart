import 'package:flutter/material.dart';
import 'package:nomadworld/models/Location.dart';
import 'package:provider/provider.dart';
import '../../../../utils/providers/user_provider.dart';
import '../../../widgets/user_profile/rl_card.dart';

class MySavedLocations extends StatefulWidget {
  const MySavedLocations({super.key});

  @override
  State<MySavedLocations> createState() => _MySavedLocationsState();
}

class _MySavedLocationsState extends State<MySavedLocations> {
  // Instancia of the UserProvider
  late UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);

    /// Muestra el número de localizaciones guardadas en consola
    print('@@@@ LOCALIZACIONES: ${_userProvider.savedLocations.length}');

    return _userProvider.savedLocations.isEmpty
        ? const Center(
            child: Text('No hay localizaciones guardadas'),
          )
        : ListView.builder(
            itemCount: _userProvider.savedLocations.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: LCard(
                savedLocation: _userProvider.savedLocations[index],
                updateList: () {
                  setState(() {});
                },
              ),
            ),
          );
  }
}


