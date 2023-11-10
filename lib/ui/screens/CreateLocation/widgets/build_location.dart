import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nomadworld/controllers/app_image_picker.dart';

class BuildLocation extends StatelessWidget {
  const BuildLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        children: [
          const TNameLocation(),
          const SizedBox(height: 10),
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
  BuildingLocationData({super.key});

  @override
  State<BuildingLocationData> createState() => _BuildingLocationDataState();
}

class _BuildingLocationDataState extends State<BuildingLocationData> {
  // Controllers
  TextEditingController nameLocationController = TextEditingController();

  File? image;

  pickImage(ImageSource source) {
    AppImagePicker(source: source)
        .pick(onPick: (File? image){
          setState(() {
            this.image = image;
          },);
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          color: Colors.green,
          height: 250,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(20),
          // ),
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

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null)
              Image.file(image!)
          ],
        ),

        const SizedBox(height: 20),

        ElevatedButton(
          onPressed: () {
            pickImage(ImageSource.gallery);
          },
          child: const Text('Subir Imagen'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            pickImage(ImageSource.camera);
          },
          child: const Text('Hacer Foto'),
        ),
      ],
    );
  }
}
