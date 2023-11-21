import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:nomadworld/models/Country.dart';
import 'package:nomadworld/models/Location.dart';
import 'package:nomadworld/ui/screens/HomeScreen/Widgets/PopularRoutesList.dart';
import 'package:http/http.dart' as http;
import '../../../models/TravelRoute.dart';
import 'Widgets/CountryList.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key});

  late Future<List<TravelRoute>> route_list;
  late Future<List<Country>> country_list;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    //Lamar a la funcion que reciba datos de la api y devuelva una lista de rutas y de paises
    widget.route_list = getFakeRoutes();
    widget.country_list = getAPIData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.34,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(150, 0, 0, 0),
                  blurRadius: 20,
                ),
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              image: DecorationImage(
                image: AssetImage('assets/card_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),

            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.0265),
                Padding(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.height * 0.02, 0, MediaQuery.of(context).size.height * 0.02, MediaQuery.of(context).size.height * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Rutas Populares",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Acción al presionar el botón
                            Get.toNamed('/create-il');
                          },
                        ),
                      ],
                    )
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    child: FutureBuilder<List<TravelRoute>>(
                      future: widget.route_list,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            return Padding(
                                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.height * 0.02, 0, MediaQuery.of(context).size.height * 0.02, 0),
                                child: PopularRoutesList(routes: snapshot.data!)
                            );
                          } else if (snapshot.hasError) {
                            return Text("ERROR");
                          }
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    )
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                )
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
            child: Row(
                children: [
                  Text("Paises",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ]
            ),
          ),

          Container(
              height: MediaQuery.of(context).size.height * 0.56,
              child: FutureBuilder<List<Country>>(
                future: widget.country_list,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ContryList(countries: snapshot.data!);

                    } else if (snapshot.hasError) {
                      return Text("ERROR");
                    }
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
          )
        ],
      ),
    );
  }

  Future<List<TravelRoute>> getFakeRoutes() async {
    // Simular la obtención de rutas falsas con un retraso
    await Future.delayed(Duration(seconds: 1));

    var routes = [
      TravelRoute(1, "Paris", "Ruta por paris", 123, 5, 4, [
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
      ]
      ),
      TravelRoute(1, "Paris", "Ruta por paris", 123, 5, 4, [
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
      ]
      ),
      TravelRoute(1, "Paris", "Ruta por paris", 123, 5, 4, [
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
      ]
      ),
      TravelRoute(1, "Paris", "Ruta por paris", 123, 5, 4, [
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
      ]
      ),
      TravelRoute(1, "Paris", "Ruta por paris", 123, 5, 4, [
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
      ]
      ),
      TravelRoute(1, "Paris", "Ruta por paris", 123, 5, 4, [
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
      ]
      ),
      TravelRoute(1, "Paris", "Ruta por paris", 123, 5, 4, [
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
      ]
      ),
      TravelRoute(1, "Paris", "Ruta por paris", 123, 5, 4, [
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
      ]
      ),
      TravelRoute(1, "Paris", "Ruta por paris", 123, 5, 4, [
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
      ]
      ),
      TravelRoute(1, "Paris", "Ruta por paris", 123, 5, 4, [
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
        LocationData(id: 1, name: "Torre eiffel", description: "Monumento iconico de paris", date: "10/8/219", Countri_id: 4, images: ["assets/paris.jpg", "assets/Italia.jpg", "assets/espana.jpg", "assets/austaralia.jpg"], longitude: 1.328478, latitude: 2.35873),
      ]
      )
    ];

    return routes;
  }

  Future<List<Country>> getFakeCountries() async {
    // Simular la obtención de rutas falsas con un retraso
    await Future.delayed(Duration(seconds: 1));

    var countries = [
      Country("España", "assets/espana.jpg",1),
      Country("Francia", "assets/paris.jpg",1),
      Country("Italia", "assets/Italia.jpg",1),
      Country("Croacia", "assets/croacia.jpg",1),
      Country("Rusia", "assets/rusia.jpg",1),
      Country("Australia", "assets/austaralia.jpg",1),
      Country("Japon", "assets/japan.jpg",1),
      Country("USA", "assets/ny.jpg",1),
      Country("España", "assets/espana.jpg",1),
      Country("Francia", "assets/paris.jpg",1),
      Country("Italia", "assets/Italia.jpg",1),
      Country("Croacia", "assets/croacia.jpg",1),
      Country("Rusia", "assets/rusia.jpg",1),
      Country("Australia", "assets/austaralia.jpg",1),
      Country("Japon", "assets/japan.jpg",1),
      Country("USA", "assets/ny.jpg",1),
    ];

    return countries;
  }

  Future<List<Country>> getAPIData() async{

    List<Country>  countrys= [];

    final response = await http.get(Uri.parse('http://172.23.6.206:8080/country/'));
    if (response.statusCode == 200){
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);

      for(var item in jsonData){
        countrys.add(Country(item["name"], item["image_uri"], item["id"]));
      }
      return countrys;
    }
    else {
      throw Exception("Erros al hacer get de paises");
    }
  }

}