import 'Location.dart';

class TravelRoute{
  int id;
  int creator_id;
  String title;
  List<String> images;
  String description;
  String creationDate;
  List<List<LocationData>> locations;
  int likes;

  TravelRoute(this.id, this.creator_id, this.title, this.images, this.description, this.creationDate, this.locations, this.likes);
}