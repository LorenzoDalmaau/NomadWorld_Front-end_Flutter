import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nomadworld/controllers/app_image_picker.dart';

class ImagesLoader extends StatefulWidget {

  ImagesLoader({super.key});

  @override
  State<StatefulWidget> createState() => _buildImagesLoader();
}

class _buildImagesLoader extends State<ImagesLoader> {
  List<File> images = [];
  File? image;

  pickImage(ImageSource source) {
    AppImagePicker(source: source).pick(
      onPick: (File? image) {
        setState(
          () {
            images.add(image!);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TODO Agregar ListView.builder
        ImgListLoader(images: images),

        const SizedBox(height: 20), // SizedBox

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                pickImage(ImageSource.gallery);
                checkImage();
              },
              child: const Text('Subir Imagen'),
            ),

            const SizedBox(width: 20),

            ElevatedButton(
              onPressed: () {
                pickImage(ImageSource.camera);
                checkImage();
              },
              child: const Text('Hacer Foto'),
            ),
          ],
        ),

      ],
    );
  }

  checkImage() {
    if (image != null) {
      images.add(image!);
      return Image.file(image!);
    }
  }
}

class ImgListLoader extends StatelessWidget {
  late List<File> images;

  ImgListLoader({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: setContainerHeigh(context),
      child: ListView.builder(
        itemCount: images.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var image = images[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Expanded(
              child: Image.file(image, fit: BoxFit.fill),
            ),
          );
        },
      ),
    );
  }

  setContainerHeigh(context){
    if(images.isNotEmpty){
      return MediaQuery.of(context).size.height * 0.20;
    }
    else {
      return 1.0;
    }
  }
}
