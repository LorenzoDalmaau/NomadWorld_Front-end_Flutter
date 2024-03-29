import 'package:nomadworld/models/TravelRoute.dart';
import 'Location.dart';

class UserBase {
  final int id;
  final String username;
  final String email;
  late final String image;
  final String password;
  List<TravelRoute> savedRoutes;
  List<LocationData> savedLocations;

  UserBase({required this.id, required this.username, required this.email, required this.image,required this.password, required this.savedRoutes, required this.savedLocations});

  factory UserBase.fromJson(Map<String, dynamic> parsedJson) {

    var locationsDataList = parsedJson['saved_locations'] as List;
    List<LocationData> locationsList = locationsDataList.map((i) => LocationData.fromJson(i)).toList();

    var routesDataList = parsedJson['saved_routes'] as List;
    List<TravelRoute> routesList = routesDataList.map((i) => TravelRoute.fromJson(i)).toList();

    return UserBase(
        id: parsedJson['id'],
        username: parsedJson['username'],
        email: parsedJson['email'],
        image: parsedJson['img'],
        password: parsedJson['password'],
        savedRoutes: routesList,
        savedLocations: locationsList
    );
  }
}