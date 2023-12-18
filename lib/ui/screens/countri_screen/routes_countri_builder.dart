import 'package:flutter/material.dart';
import 'package:nomadworld/models/Country.dart';
import 'package:nomadworld/models/TravelRoute.dart';
import 'package:nomadworld/utils/api/api_service.dart';

class RoutesCountriBuilder extends StatefulWidget {
  RoutesCountriBuilder({super.key, required this.country});

  late Country country;
  @override
  State<RoutesCountriBuilder> createState() => _RoutesCountriBuilderState();
}

class _RoutesCountriBuilderState extends State<RoutesCountriBuilder> {
  List<TravelRoute> routes = [];

  @override
  initState(){
    getRoutes();
  }

  getRoutes() async {
    //List<TravelRoute> apiResponse = await ApiService().getCountryRoutes(widget.country.name);
    //routes = apiResponse;
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
      itemCount: routes.length,
      itemBuilder: (BuildContext context, int index) {
        //return LocationCard(location: locations[index]);
      },
    );
  }
}