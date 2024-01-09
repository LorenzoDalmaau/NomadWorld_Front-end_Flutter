import 'package:nomadworld/models/TravelRoute.dart';
import 'Location.dart';

class UserBase {
  final String username;
  final String email;
  final String image;
  final String password;
  List<TravelRoute> savedRoutes;
  List<LocationData> savedLocations;

  UserBase({required this.username, required this.email, required this.image,required this.password, required this.savedRoutes, required this.savedLocations});

  factory UserBase.fromJson(Map<String, dynamic> parsedJson) {

    var locationsDataList = parsedJson['saved_locations'] as List;
    List<LocationData> locationsList = locationsDataList.map((i) => LocationData.fromJson(i)).toList();

    var routesDataList = parsedJson['saved_routes'] as List;
    List<TravelRoute> routesList = routesDataList.map((i) => TravelRoute.fromJson(i)).toList();

    return UserBase(
        username: parsedJson['username'],
        email: parsedJson['email'],
        image: parsedJson['img'],
        password: parsedJson['password'],
        savedRoutes: routesList,
        savedLocations: locationsList
    );
  }
}