import 'Location.dart';

class TravelRoute{
  int id;
  String name;
  String descrption;
  int distance;
  int duration;
  int country_id;
  List<LocationData> locations;

  TravelRoute(this.id, this.name, this.descrption, this.distance, this.duration, this.country_id, this.locations);
}