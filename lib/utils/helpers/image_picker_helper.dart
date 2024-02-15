import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {

  static Future<File?> pickImageFromGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery);
    if (pickedFile != null) {
      print("Image selected from gallery: ${pickedFile.path}");
      return File(pickedFile.path);
    }
    return null;
  }

  static Future<File?> pickImageFromCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera);
    if (pickedFile != null) {
      print("Image selected from camera: ${pickedFile.path}");
      return File(pickedFile.path);
    }
    return null;
  }


  static Future<void> showImagePickerDialog(BuildContext context,
      Function(File?) onImageSelected) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿De dónde quieres utilizar la foto?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: const Text('Galería'),
                  onTap: () async {
                    File? pickedImage = await pickImageFromGallery(context);
                    onImageSelected(pickedImage);
                    Navigator.of(context).pop();
                  },
                ),
                const Padding(padding: EdgeInsets.all(10.0)),
                GestureDetector(
                  child: const Text('Cámara'),
                  onTap: () async {
                    File? pickedImage = await pickImageFromCamera(context);
                    onImageSelected(pickedImage);
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  /// Image to base64
  // Función para convertir una imagen en base64
  String convertImageToBase64(File imageFile) {
    var imageByte = imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageByte);
    return base64Image;
  }
}