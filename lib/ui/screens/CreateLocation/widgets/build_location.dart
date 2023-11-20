import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:latlong2/latlong.dart';
import '../../../widgets/images_loader.dart';
import '../../../widgets/map_box.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io';


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
  TextEditingController descriptionLocationController = TextEditingController();
  LatLng? location;
  List<File> images = [];

  // Function to register the user
  void userLocation(String name, String description, List images) async {
    var url = Uri.parse('http://localhost/create_location');

    // Creating the user object
    Map<String, dynamic> userLocation = {
      // TODO añadir los campos
      "name" : nameLocationController,
      "latitude": location!.latitude.toString(),
      "longitude" : location!.longitude.toString(),
      "image" : images,
    };

    // Sending the user object to the server
    var response = await http.post(url,
        body: convert.jsonEncode(userLocation),
        headers: {'Content-Type': 'application/json'});

    response.body; // "Envía" la location a la api
  }


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
          ImagesLoader(images: const []),
        ],
      ),
    );
  }
}


