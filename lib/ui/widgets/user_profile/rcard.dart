import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:nomadworld/models/TravelRoute.dart';
import 'package:provider/provider.dart';
import '../../../models/Location.dart';
import '../../../utils/providers/user_provider.dart';

class Rcard extends StatelessWidget {
  TravelRoute? savedRoute;
  late Function updateList;

   Rcard({required this.savedRoute, required this.updateList});

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
                    image: NetworkImage(savedRoute!.locations![0].images![0]),
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
                      savedRoute!.name!,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      savedRoute!.descrption!,
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
                  // Eliminar utilizando el provider la ruta guardada
                  Provider.of<UserProvider>(context, listen: false)
                      .deleteSavedRoute(savedRoute!.id);
                },
                icon: const Icon(Icons.delete),
              ),
            ),
          ],
        ),
      ),
    );
  }
}