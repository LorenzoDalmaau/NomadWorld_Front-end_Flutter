import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomadworld/models/TravelRoute.dart';
import 'package:nomadworld/ui/screens/RouteScreen/widgets/Location_Card.dart';
import 'package:nomadworld/ui/widgets/CarrouselAppbar.dart';

import '../../widgets/texts/DescriptionText.dart';

class RouteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final TravelRoute route = Get.arguments as TravelRoute;

    return Scaffold(
      body: CustomScrollView(
            slivers: <Widget>[
              CarrouselAppBar(name: route.name, images: route.locations[0].images),
              SliverToBoxAdapter(
                child: DescriptionText(description: route.descrption)
              ),
              SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.height * 0.01, MediaQuery.of(context).size.height * 0.01, MediaQuery.of(context).size.height * 0.01, MediaQuery.of(context).size.height * 0.005),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.035,
                          child: const SingleChildScrollView(
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "Itinerario",
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                          ),
                        ),

                        Container(
                          height: MediaQuery.of(context).size.height * 0.005,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(150, 0, 0, 0),
                                blurRadius: 20,
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage('assets/card_background.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ),

              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                      child: Text(
                        "${route.duration} dias",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                      child: Text(
                        "${route.distance}Km",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.7,
                  crossAxisCount: 2,
                ),
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return LocationCard(location: route.locations[index]);
                  },
                  childCount: route.locations.length,
                ),
              ),
            ],
      ),
    );
  }
}