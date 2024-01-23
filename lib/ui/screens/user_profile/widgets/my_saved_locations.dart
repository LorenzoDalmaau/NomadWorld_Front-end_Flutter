import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/providers/user_provider.dart';

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
            itemBuilder: (context, index) => Card(
              child: ListTile(
                title: Text(_userProvider.savedLocations[index].name!),
                subtitle:
                    Text(_userProvider.savedLocations[index].description!),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // TODO deleteSavedLocation
                  },
                ),
              ),
            ),
          );
  }
}
