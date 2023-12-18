class LocationData{

  int id;
  String? name;
  String description;
  String date;
  int countri_id;
  List<String> images;
  double longitude;
  double latitude;

  LocationData({required this.id, required this.name, required this.description, required this.date, required this.countri_id, required this.images, required this.longitude, required this.latitude});

  factory LocationData.fromJson(Map<String, dynamic> parsedJson) {
    var imagesFromJson = parsedJson["image"];
    List<String> imagesList = List<String>.from(imagesFromJson);

    return LocationData(
      id: parsedJson["id"],
      name: parsedJson["name"],
      description: parsedJson["description"],
      date: parsedJson["creation_date"],
      countri_id: parsedJson["country_id"],
      images: imagesList,
      longitude: parsedJson["longitude"],
      latitude: parsedJson["latitude"],
    );
  }
}