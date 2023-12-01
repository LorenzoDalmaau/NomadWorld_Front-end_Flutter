import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:nomadworld/controllers/location_service.dart';
import 'package:nomadworld/models/Country.dart';
import 'package:nomadworld/ui/widgets/images_loader.dart';
import 'package:nomadworld/ui/widgets/map_box.dart';
import 'package:provider/provider.dart';
import '../../../domain/provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CreateLocation extends StatefulWidget {
  const CreateLocation({super.key});

  @override
  State<CreateLocation> createState() => _CreateLocationState();
}

class _CreateLocationState extends State<CreateLocation> {
  TextEditingController nameLocationController = TextEditingController();
  TextEditingController descriptionLocationController = TextEditingController();

  /// TODO Agregar campo descripción
  late NomadProvider provider;
  Country dropdownValue = countries.first;
  LatLng? location;

  /// Crear post de location
  void createLocation(String name, String description, LatLng location, List<String> base64Images) async {
    String countryName = dropdownValue.name;

    var url = Uri.parse('http://192.168.1.50:8000/create_location/$countryName');

    // Creating the location object
    Map<String, dynamic> locationMap = {
      "image_files": base64Images,
      "location": {
        'name': name,
        'description': description,
        'latitude': location.latitude,
        'longitude': location.longitude
      }
    };

    // Sending the user object to the server
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: convert.jsonEncode(locationMap),
    );

    // Checking the response
    if (response.statusCode == 200) {
      var jsonResponse = response.body;

      if (jsonResponse.contains('Location created successfully')) {
        Get.snackbar('Genial!', 'Has creado una ubicación!',
            snackPosition: SnackPosition.BOTTOM);
        Get.offAllNamed('/home');
      } else {
        // Mostrar un mensaje de error si la respuesta no contiene el mensaje esperado
        Get.snackbar('Error', 'Error en la respuesta del servidor',
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      // Mostrar el código de estado HTTP si la respuesta no es 201
      Get.snackbar('Error', 'HTTP Error: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<NomadProvider>(context);
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              if (location != null) {
                List<String> base64Images = provider.convertImagesToBase64();
                createLocation(
                  nameLocationController.text.toString(),
                  descriptionLocationController.text.toString(),
                  location!,
                  base64Images,
                );
              } else {
                // Manejar el caso cuando location es nulo
                print("Error: location es nulo");
              }
            },
            child: const Text(
              'Crear ubicación',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 17,
                //decoration: TextDecoration.underline,
                letterSpacing: 0.5,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 25, 30, 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Title
                const Text(
                  'Mi ubicación',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),

                /// Subtitle
                const Text('Añade la ubicación, tus fotos y\nrecomendaciones'),

                const SizedBox(height: 50),

                /// Location Name
                const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'Pon un título a tu recuerdo',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 10),

                /// FormField
                TextFormField(
                  controller: nameLocationController,
                  maxLines: 1,
                  maxLength: 25,
                  minLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Por ejemplo: La Sagrada Familia',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'Añade una descripción',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 10),

                // Textfiel descripción
                TextFormField(
                  controller: descriptionLocationController,
                  maxLength: 180,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('¿A que país pertenece?',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),

                // TODO Almacenar el país seleccionado en countryName
                DropdownButton<Country>(
                  value: dropdownValue,
                  onChanged: (Country? newDropdownValue) {
                    setState(() {
                      dropdownValue = newDropdownValue!;
                      print(dropdownValue.name);
                    });
                  },
                  items: countries.map((Country country) {
                    return DropdownMenuItem<Country>(
                      value: country,
                      child: Text(country.name),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                /// Title Location
                const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'Ubicación',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  height: 250,
                  color: const Color.fromARGB(192, 25, 95, 71),
                  child: MapBox(
                    onLocationChanged: (LatLng newLocation) {
                      setState(() {
                        location = newLocation;
                        print('Selected Location: $location');
                      });
                    },
                  ),
                ),

                const SizedBox(height: 5),

                /// Advertation
                const Text(
                  'Por favor, en caso de que no le deje continuar, seleccione un marcador de nuevo.',
                  style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),

                const SizedBox(height: 20),

                /// Images
                const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'Tus fotografías',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 10),

                /// Load Images from camera | gallery
                const ImagesLoader(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


List<Country> countries = [
  Country("Spain", "assets/espana.jpg"),
  Country("France", "assets/paris.jpg"),
  Country("Italy", "assets/Italia.jpg"),
  Country("Germany", "assets/croacia.jpg"),
  Country("Australia", "assets/rusia.jpg"),
  Country("Rusia", "assets/austaralia.jpg"),
  Country("Usa", "assets/japan.jpg"),
  Country("Croatia", "assets/ny.jpg"),
  Country("Japan", "assets/espana.jpg"),
  Country("Albania", "assets/paris.jpg"),
  Country("Andorra", "assets/Italia.jpg"),
  Country("Armenia", "assets/croacia.jpg"),
  Country("Austria", "assets/rusia.jpg"),
  Country("Azerbaijan", "assets/austaralia.jpg"),
  Country("Belgium", "assets/japan.jpg"),
  Country("Belarus", "assets/ny.jpg"),
];