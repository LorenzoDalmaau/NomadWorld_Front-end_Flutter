import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:nomadworld/domain/provider/provider.dart';
import 'package:nomadworld/models/Country.dart';
import 'package:nomadworld/ui/screens/HomeScreen/Widgets/PopularRoutesList.dart';
import 'package:nomadworld/utils/api/api_service.dart';
import 'package:provider/provider.dart';
import '../../../models/TravelRoute.dart';
import 'Widgets/CountryList.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key});

  late Future<List<TravelRoute>> route_list;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late NomadProvider provider;
  List<Country> country_list = [];

  @override
  void initState(){
    getDatas();
  }

  getDatas() async {
    widget.route_list = ApiService().getPopularRoutes();
    country_list = await ApiService().getCountryList();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<NomadProvider>(context);
    provider.setAPIContries(country_list);
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
                            print(snapshot);
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
          ContryList()
        ],
      ),
    );
  }
}