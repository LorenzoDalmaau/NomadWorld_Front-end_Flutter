import 'package:flutter/material.dart';
import 'package:nomadworld/models/Country.dart';
import 'package:nomadworld/models/TravelRoute.dart';
import 'package:nomadworld/ui/screens/countri_screen/widgets/countri_route_card.dart';
import 'package:nomadworld/utils/api/api_service.dart';

class RoutesCountriBuilder extends StatefulWidget {
  RoutesCountriBuilder({super.key, required this.country});

  late Country country;
  @override
  State<RoutesCountriBuilder> createState() => _RoutesCountriBuilderState();
}

class _RoutesCountriBuilderState extends State<RoutesCountriBuilder> {
  late Future<List<TravelRoute>> routesFuture;

  @override
  void initState() {
    super.initState();
    routesFuture = getLocations();
  }

  Future<List<TravelRoute>> getLocations() async {
    List<TravelRoute> apiResponse =
    await ApiService().getCountryRoutes(widget.country.name);
    return apiResponse;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: routesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error al recivir los datos'),
          );
        } else {
          List<TravelRoute> routes = snapshot.data as List<TravelRoute>;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.7,
              crossAxisCount: 2,
            ),
            itemCount: routes.length,
            itemBuilder: (BuildContext context, int index) {
              return CountiRouteCard(route: routes[index]);//Cambiar por widget del card
            },
          );
        }
      },
    );
  }
}