class Country{
  int id;
  String name;
  String image;

  Country({required this.id, required this.name, required this.image});

  factory Country.fromJson(Map<String, dynamic> parsedJson) {

    return Country(
        id : parsedJson["id"],
        name : parsedJson["name"],
        image : parsedJson["image_uri"]
    );
  }
}