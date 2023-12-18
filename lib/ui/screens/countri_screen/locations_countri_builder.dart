import 'package:flutter/material.dart';
import 'package:nomadworld/models/Country.dart';
import 'package:nomadworld/utils/api/api_service.dart';
import '../../../models/Location.dart';
import '../RouteScreen/widgets/Location_Card.dart';

class LocationsCountriBuilder extends StatefulWidget {
  LocationsCountriBuilder({super.key, required this.country});

  late Country country;
  @override
  State<LocationsCountriBuilder> createState() => _LocationsCountriBuilderState();
}

class _LocationsCountriBuilderState extends State<LocationsCountriBuilder> {
  List<LocationData> locations = [];

  @override
  initState(){
    getLocations();
  }

  getLocations() async {
    List<LocationData> apiResponse = await ApiService().getCountryLocations(widget.country.name);
    locations = apiResponse;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.7,
        crossAxisCount: 2,
      ),
      itemCount: locations.length,
      itemBuilder: (BuildContext context, int index) {
        return LocationCard(location: locations[index]);
      },
    );
  }
}