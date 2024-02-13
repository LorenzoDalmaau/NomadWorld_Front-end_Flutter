import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nomadworld/controllers/app_image_picker.dart';
import 'package:provider/provider.dart';
import '../../domain/provider/provider.dart';
import 'image_list_loader.dart';

class ImagesLoader extends StatefulWidget {
  const ImagesLoader({super.key});

  @override
  State<StatefulWidget> createState() => _buildImagesLoader();
}

class _buildImagesLoader extends State<ImagesLoader> {
  File? image;
  late NomadProvider provider;

  /// Función para seleccionar camara o galería
  pickImage(ImageSource source) {
    AppImagePicker(source: source).pick(
      onPick: (File? image) {
        setState(
          () {
            provider.images.add(image!);

            /// TODO Agregar función que añada las imagenes a la lista del provider
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<NomadProvider>(context);

    return Column(
      children: [
        ImgListLoader(),

        const SizedBox(height: 20), // SizedBox

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                pickImage(ImageSource.gallery);
                checkImage();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff195f47),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Subir Imagen',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                pickImage(ImageSource.camera);
                checkImage();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff195f47),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Hacer Foto', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ],
    );
  }

  checkImage() {
    if (image != null) {
      provider.images.add(image!);
      return Image.file(image!);
    }
  }

  @override
  void dispose() {
    provider.images.clear();
  }
}
