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

  /// Login User
  void loginUser(String email, String password) async {
    var url = Uri.parse('$baseUrl/login');

    // Creating the user object
    Map<String, dynamic> userMap = {'email': email, 'password': password};

    // Sending the user object to the server
    var response = await http.post(
      url,
      body: convert.jsonEncode(userMap),
      headers: {'Content-Type': 'application/json'},
    );

    // Checking the response
    if (response.statusCode == 200) {
      var jsonResponse = response.body;

      if (jsonResponse.contains('User logged successfully')) {
        Get.snackbar('Genial!', 'Has iniciado sesión correctamente',
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

  /// Register User
  void registerUser(String username, String email, String password) async {
    var url = Uri.parse('$baseUrl/register');

    // Creating the user object
    Map<String, dynamic> userMap = {
      'username': username,
      'email': email,
      'password': password
    };

    // Sending the user object to the server
    var response = await http.post(url,
        body: convert.jsonEncode(userMap),
        headers: {'Content-Type': 'application/json'});

    // Checking the response
    if (response.statusCode == 201) {
      var jsonResponse = response.body;

      if (jsonResponse.contains('User created successfully')) {
        Get.snackbar('Genial!', 'Usuario registrado correctamente',
            snackPosition: SnackPosition.BOTTOM);
        Get.offAllNamed('/login');
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

  Future<List<LocationData>> getCountryLocations(String country) async {

    List<LocationData> locations = [];

    final response = await http.get(Uri.parse('http://3.230.177.201:8000/location/${country}'));
    if (response.statusCode == 200){
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);

      for(var item in jsonData){
        locations.add(LocationData.fromJson(item));
      }
      return locations;
    }
    else {
      throw Exception("Error al hacer get de localizaciones de un pais");
    }
  }

  Future<List<TravelRoute>> getCountryRoutes(String country) async {

    List<TravelRoute> routes = [];

    final response = await http.get(Uri.parse('http://3.230.177.201:8000/route/${country}'));
    if (response.statusCode == 200){
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);

      for(var item in jsonData){
        routes.add(TravelRoute.fromJson(item));
      }
      return routes;
    }
    else {
      throw Exception("Error al hacer get de rutas de un pais");
    }
  }

  /// Crear post de location
  void createLocation(String name, String description, LatLng location, List<String> base64Images, Country country) async {

    // Mostrar Snackbar indicando que la ubicación se está creando
    Get.snackbar('Creando ubicación', 'Por favor, espera...',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        isDismissible: false);

    var url = Uri.parse('$baseUrl/create_location/${country.name}');
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
        Get.toNamed('/create-il');
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

  /// POST Create Route
  Future<void> createRoute(Country country,String nameRoute, String descriptionRoute, List<int> locationIds) async {
    var url = Uri.parse('$baseUrl/create_route/${country.name}');

    // Mostrar Snackbar indicando que la ubicación se está creando
    Get.snackbar('Creando ruta', 'Por favor, espere...',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        isDismissible: false);

    final Map<String, dynamic> routeMap = {
      'id': 0,
      'name': nameRoute,
      'description': descriptionRoute, // TODO Agregar descripción
      'distance': 0, // TODO Agregar distancia
      'duration': 0, // TODO Agregar duración
      'country_id': country.id,
      'location_id': locationIds,
    };

    try {
      // Sending the user object to the server
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: convert.jsonEncode(routeMap),
      );

      // Checking the response
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Si la creación es exitosa, mostrar Snackbar y navegar a la otra página
        Get.snackbar('¡Ruta creada correctamente!', '',
            snackPosition: SnackPosition.BOTTOM);
        Get.toNamed('/create-location');
      } else {
        // Si la respuesta no es 200/201, mostrar un mensaje de error
        Get.snackbar(
            'Error', 'No hemos podido crear tu ruta',
            snackPosition: SnackPosition.BOTTOM);
        Get.toNamed('/create-il');
      }
    } catch (error) {
      // Mostrar un Snackbar en caso de error durante la solicitud HTTP
      print('Error en la solicitud HTTP: $error');
    }
  }
}