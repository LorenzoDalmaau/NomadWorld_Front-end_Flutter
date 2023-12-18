import 'dart:convert' as convert;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import '../../models/Country.dart';
import '../../models/Location.dart';
import '../../models/TravelRoute.dart';

class ApiService {

  final baseUrl = 'http://3.230.177.201:8000';

  /// Get popular routes
  Future<List<TravelRoute>> getPopularRoutes() async {

    List<TravelRoute>  routes= [];
    final response = await http.get(Uri.parse('$baseUrl/route/more_likes/'));
    if (response.statusCode == 200){

      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for(var item in jsonData){
        routes.add(TravelRoute.fromJson(item));
      }
      return routes;
    }
    else {
      throw Exception("Error al hacer get de rutas populares");
    }
  }

  /// Get Country list
  Future<List<Country>> getCountryList() async{

    List<Country>  countrys= [];

    final response = await http.get(Uri.parse('$baseUrl/country/'));
    if (response.statusCode == 200){
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);

      for(var item in jsonData){
        countrys.add(Country.fromJson(item));
      }
      return countrys;
    }
    else {
      throw Exception("Error al hacer get de paises");
    }
  }


  /// Crear post de location
  void createLocation(String name, String description, LatLng location, List<String> base64Images, Country country) async {

    // Mostrar Snackbar indicando que la ubicación se está creando
    Get.snackbar('Creando ubicación', 'Por favor, espera...',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        isDismissible: false);

    var url =
    Uri.parse('$baseUrl/create_location/${country.name}');

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

    try {
      // Sending the user object to the server
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: convert.jsonEncode(locationMap),
      );

      // Checking the response
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Si la creación es exitosa, mostrar Snackbar y navegar a la otra página
        Get.snackbar('¡Localización creada correctamente!', '',
            snackPosition: SnackPosition.BOTTOM);
        Get.toNamed('/create-location');
      } else {
        // Si la respuesta no es 200/201, mostrar un mensaje de error
        Get.snackbar(
            'Error', 'No hemos podido crear tu ubicación',
            snackPosition: SnackPosition.BOTTOM);
        Get.toNamed('/create-il');
      }
    } catch (error) {
      // Mostrar un Snackbar en caso de error durante la solicitud HTTP
      print('Error en la solicitud HTTP: $error');
    }
  }

  Future<List<LocationData>> getCountryLocations(String country) async {
    List<LocationData> locations = [];

    final response = await http.get(Uri.parse('http://3.230.177.201:8000/location/$country'));
    if (response.statusCode == 200){
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);

      print('JSONDATA: jsonData');
      for(var item in jsonData){
        locations.add(LocationData.fromJson(item));
        print('PAISES: $item');
      }
      return locations;
    }
    else {
      throw Exception("Error al hacer get de localizaciones de un pais");
    }
  }
}