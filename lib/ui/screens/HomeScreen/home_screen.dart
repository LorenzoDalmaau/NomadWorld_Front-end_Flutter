import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:nomadworld/models/Country.dart';
import 'package:nomadworld/models/Location.dart';
import 'package:nomadworld/ui/screens/HomeScreen/Widgets/PopularRoutesList.dart';

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
    widget.country_list = getFakeCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.33,
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
              height: MediaQuery.of(context).size.height * 0.59,
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
      TravelRoute(1, 1, "Paris", ["assets/paris.jpg", "assets/espana.jpg"], "description", "creationDate", [
        [
          LocationData(1, 5, "Torre Eiffel", 0, ["assets/paris.jpg"]),
          LocationData(1, 5, "Torre Eiffel", 0, ["assets/paris.jpg"]),
          LocationData(1, 5, "Torre Eiffel", 0, ["assets/paris.jpg"]),
          LocationData(1, 5, "Torre Eiffel", 0, ["assets/paris.jpg"]),
          LocationData(1, 5, "Torre Eiffel", 0, ["assets/paris.jpg"]),
        ],
        [
          LocationData(1, 5, "Torre Eiffel", 0, ["assets/paris.jpg"]),
        ],
        [
          LocationData(1, 5, "Torre Eiffel", 0, ["assets/paris.jpg"]),
          LocationData(1, 5, "Torre Eiffel", 0, ["assets/paris.jpg"]),
          LocationData(1, 5, "Torre Eiffel", 0, ["assets/paris.jpg"]),
        ],
        [
          LocationData(1, 5, "Torre Eiffel", 0, ["assets/paris.jpg"]),
          LocationData(1, 5, "Torre Eiffel", 0, ["assets/paris.jpg"]),
          LocationData(1, 5, "Torre Eiffel", 0, ["assets/paris.jpg"]),
          LocationData(1, 5, "Torre Eiffel", 0, ["assets/paris.jpg"]),
        ],
        [
          LocationData(1, 5, "Torre Eiffel", 0, ["assets/paris.jpg"]),
          LocationData(1, 5, "Torre Eiffel", 0, ["assets/paris.jpg"]),
        ],
      ], 50),
      TravelRoute(2, 2, "New York", ["assets/ny.jpg"], "description", "creationDate", [], 1200),
      TravelRoute(3, 4, "Japan", ["assets/japan.jpg"], "description", "creationDate", [], 500),
      TravelRoute(4, 4, "Italy", ["assets/Italia.jpg"], "description", "creationDate", [], 1000000),
      TravelRoute(5, 1, "Paris", ["assets/paris.jpg"], "description", "creationDate", [], 50),
      TravelRoute(6, 2, "New York", ["assets/ny.jpg"], "description", "creationDate", [], 1200),
      TravelRoute(7, 4, "Japan", ["assets/japan.jpg"], "description", "creationDate", [], 500),
      TravelRoute(8, 4, "Italy", ["assets/Italia.jpg"], "description", "creationDate", [], 1000000),
      TravelRoute(9, 1, "Paris", ["assets/paris.jpg"], "description", "creationDate", [], 50),
      TravelRoute(10, 2, "New York", ["assets/ny.jpg"], "description", "creationDate", [], 1200),
      TravelRoute(11, 4, "Japan", ["assets/japan.jpg"], "description", "creationDate", [], 500),
      TravelRoute(12, 4, "Italy", ["assets/Italia.jpg"], "description", "creationDate", [], 1000000),
    ];

    return routes;
  }

  Future<List<Country>> getFakeCountries() async {
    // Simular la obtención de rutas falsas con un retraso
    await Future.delayed(Duration(seconds: 1));

    var countries = [
      Country("España", "assets/espana.jpg"),
      Country("Francia", "assets/paris.jpg"),
      Country("Italia", "assets/Italia.jpg"),
      Country("Croacia", "assets/croacia.jpg"),
      Country("Rusia", "assets/rusia.jpg"),
      Country("Australia", "assets/austaralia.jpg"),
      Country("Japon", "assets/japan.jpg"),
      Country("USA", "assets/ny.jpg"),
      Country("España", "assets/espana.jpg"),
      Country("Francia", "assets/paris.jpg"),
      Country("Italia", "assets/Italia.jpg"),
      Country("Croacia", "assets/croacia.jpg"),
      Country("Rusia", "assets/rusia.jpg"),
      Country("Australia", "assets/austaralia.jpg"),
      Country("Japon", "assets/japan.jpg"),
      Country("USA", "assets/ny.jpg"),
    ];

    return countries;
  }

}