import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:nomadworld/ui/widgets/images_loader.dart';
import 'dart:io';
import 'package:nomadworld/ui/widgets/map_box.dart';

class CreateLocation extends StatefulWidget {
  const CreateLocation({super.key});

  @override
  State<CreateLocation> createState() => _CreateLocationState();
}

class _CreateLocationState extends State<CreateLocation> {
  TextEditingController nameLocationController = TextEditingController();

  TextEditingController descriptionLocationController = TextEditingController();

  List<File> images = [];

  LatLng? location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Continuar',
              style: TextStyle(
                color: Colors.green,
                fontSize: 15,
                decoration: TextDecoration.underline,
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
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
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

                /// Title Location
                const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'Ubicación',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: 250,
                  child: MapBox(
                    onLocationChanged: (LatLng location) {
                      setState(() {
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
                ImagesLoader(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
