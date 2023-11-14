import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';
import '../../../widgets/images_loader.dart';
import '../../../widgets/map_box.dart';

class BuildLocation extends StatelessWidget {
  const BuildLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Column(
        children: [
          TNameLocation(),
          SizedBox(height: 10),
          BuildingLocationData(),
        ],
      ),
    );
  }
}

class TNameLocation extends StatelessWidget {
  const TNameLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        'Pon un título a tu recuerdo *',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class BuildingLocationData extends StatefulWidget {
  const BuildingLocationData({super.key});

  @override
  State<BuildingLocationData> createState() => _BuildingLocationDataState();
}

class _BuildingLocationDataState extends State<BuildingLocationData> {
  // Controllers
  TextEditingController nameLocationController = TextEditingController();
  LatLng? location;

  // TODO Crear función para el POST a la API
  // A la hora de pasar la lat y long por separadas, debo de pasar lcoation por parametro en la función para después
  // llamar a position.latitude.toString() y position.longitude.toString()

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        children: [
          // TextField
          TextField(
            controller: nameLocationController,
            maxLines: 1,
            maxLength: 25,
            minLines: 1,
            decoration: InputDecoration(
              hintText: 'Por ejemplo: La Sagrada Familia',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Title Ubicacion
          const Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'Ubicación *',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 20),
          // Maps
          Container(
            height: 250,
            child: MapBox(
              onLocationChanged: (LatLng location) {
                setState(() {
                  print('Selected Location $location');
                });
              },
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Por favor, en caso de que no le deje continuar, seleccione un marcador de nuevo.',
            style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),

          const SizedBox(height: 20),

          // Tus fotografías
          const Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'Tus Fotografías *',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Load Images from camera|gallery
          const ImagesLoader(),
        ],
      ),
    );
  }
}


