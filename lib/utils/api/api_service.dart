import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/Country.dart';
import '../../models/TravelRoute.dart';

class ApiService {

  Future<List<TravelRoute>> getPopularRoutes() async {

    List<TravelRoute>  routes= [];
    final response = await http.get(Uri.parse('http://172.23.6.201:8080/route/more_likes/'));
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

  Future<List<Country>> getCountryList() async{

    List<Country>  countrys= [];

    final response = await http.get(Uri.parse('http://172.23.6.201:8080/country/'));
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
}