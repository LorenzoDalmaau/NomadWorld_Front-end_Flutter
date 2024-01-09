import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImage extends StatefulWidget {
  bool canEdit;

  UserImage({
    super.key,
    required this.canEdit,
  });

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  XFile? imageFile;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: widget.canEdit ? () {_showSelectionDialog(context);} : () {},
          // Función que muestra la opcion de abrir la camara o galería
          child: SizedBox(
            width: 120,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image(image: _setImageView(), fit: BoxFit.fill,
              ), // Selecciona la imagen
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: widget.canEdit
              ? Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.green,
            ),
            child: const Icon(Icons.edit, color: Colors.black),
          )
              : Container(),
        ),
      ],
    );
  }

  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('¿De donde quieres utilizar la foto?'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: const Text('Galería'),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(10.0)),
                  GestureDetector(
                    child: const Text('Camara'),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  _setImageView(){
    if(imageFile != null) {
      return FileImage(File(imageFile!.path));
    } else {
      return const AssetImage('assets/croacia.jpg');
    }
  }
}

