import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/Location.dart';
import '../../../utils/providers/user_provider.dart';

class LCard extends StatelessWidget {
  LocationData? savedLocation;
  late Function updateList;

  LCard({required this.savedLocation, required this.updateList});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
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
                    image: NetworkImage(savedLocation!.images[0]),
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
                      savedLocation!.name!,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      savedLocation!.description,
                      style: const TextStyle(
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            IconButton(
              onPressed: () {
                // Eliminar utilizando el provider la ruta guardada
                Provider.of<UserProvider>(context, listen: false)
                    .deleteSavedLocation(savedLocation!.id);
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}