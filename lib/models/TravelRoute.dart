import 'Location.dart';

class TravelRoute{
  int id;
  String name;
  String descrption;
  int distance;
  int duration;
  int country_id;
  List<LocationData> locations;

  TravelRoute({required this.id, required this.name, required this.descrption, required this.distance, required this.duration, required this.country_id, required this.locations});


  factory TravelRoute.fromJson(Map<String, dynamic> parsedJson) {

    var list = parsedJson['location_id'] as List;
    List<LocationData> locationsList = list.map((i) => LocationData.fromJson(i)).toList();

    return TravelRoute(
        id : parsedJson["id"],
        name : parsedJson["name"],
        descrption : parsedJson["description"],
        distance : parsedJson["distance"],
        duration : parsedJson["duration"],
        country_id : parsedJson["country_id"],
        locations : locationsList
    );
  }
}