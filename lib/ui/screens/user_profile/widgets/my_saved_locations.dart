import 'package:flutter/material.dart';
import 'package:nomadworld/models/Location.dart';
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
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: RLCard(
                _userProvider.savedLocations[index],
              ),
            ),
          );
  }
}

class RLCard extends StatelessWidget {
  final LocationData savedLocation;

  RLCard(this.savedLocation, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: Colors.grey[200],
        child: Row(
          children: [

            /// Imagen
            Expanded(
              flex: 2,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(savedLocation.images[0]!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            /// Título y descripción
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      savedLocation.name!,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      savedLocation.description!,
                      style: const TextStyle(
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {

                },
                icon: const Icon(Icons.delete),
              )
            ),
          ],
        ),
      ),
    );
  }
}

// class RLCard extends StatelessWidget {
//   final LocationData savedLocation;
//
//   RLCard(this.savedLocation, {Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: Container(
//         color: Colors.grey[200],
//         child: Row(
//           children: [
//             Container(
//               width: 100,
//               height: 100,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 image: DecorationImage(
//                   image: NetworkImage(savedLocation.images[0]!),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 10.0),
//               child: Flexible(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Title
//                     Text(
//                       'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
//                       style: const TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//
//                     // Description
//                     Text(
//                       'savedLocation.description!aaaaaaaaaaaaaaaaaaaaa',
//                       style: const TextStyle(
//                         fontSize: 15,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
