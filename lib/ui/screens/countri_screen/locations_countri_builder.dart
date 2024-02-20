import 'package:flutter/material.dart';
import 'package:nomadworld/models/Country.dart';
import 'package:nomadworld/utils/api/api_service.dart';
import '../../../models/Location.dart';
import '../RouteScreen/widgets/Location_Card.dart';

class LocationsCountriBuilder extends StatefulWidget {
  LocationsCountriBuilder({super.key, required this.country});

  late final Country country;

  @override
  State<LocationsCountriBuilder> createState() => _LocationsCountriBuilderState();
}

class _LocationsCountriBuilderState extends State<LocationsCountriBuilder> {
  late Future<List<LocationData>> locationsFuture;

  @override
  void initState() {
    super.initState();
    locationsFuture = getLocations();
  }

  Future<List<LocationData>> getLocations() async {
    List<LocationData> apiResponse =
    await ApiService().getCountryLocations(widget.country.name);
    return apiResponse;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: locationsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('No hay localizaciones para este país'),
          );
        } else {
          List<LocationData> locations = snapshot.data as List<LocationData>;
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
      },
    );
  }
}