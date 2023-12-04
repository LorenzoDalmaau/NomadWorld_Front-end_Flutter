import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:nomadworld/models/Country.dart';

class NomadProvider extends ChangeNotifier {
  List<File> images = [];
  List<Country> countries = [];


  // Función para convertir la lista de imagenes en base64
  List<String> convertImagesToBase64() {
    List<String> base64Images = [];

    for(File imageFile in images) {
      List<int> imageBytes = imageFile.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      base64Images.add(base64Image);
    }
    return base64Images;
  }

  setAPIContries(List<Country> apiCountries) async {
    countries = apiCountries;
    notifyListeners();
  }
}
