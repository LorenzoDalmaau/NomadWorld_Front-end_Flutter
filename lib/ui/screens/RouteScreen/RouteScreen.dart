import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomadworld/models/TravelRoute.dart';
import 'package:nomadworld/ui/screens/RouteScreen/widgets/Carousel.dart';
import 'package:nomadworld/ui/screens/RouteScreen/widgets/DaysList.dart';

class RouteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final TravelRoute route = Get.arguments as TravelRoute;

    return Scaffold(
      body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.3,
                floating: false,
                pinned: true,
                backgroundColor: Color.fromARGB(255, 20, 134, 94),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(route.name),
                  centerTitle: true, // Centra el título verticalmente
                  background: checkImageNumber(route),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: SingleChildScrollView(
                      child: Text(
                        route.descrption,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                )
              ),
              SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.height * 0.01, MediaQuery.of(context).size.height * 0.01, MediaQuery.of(context).size.height * 0.01, MediaQuery.of(context).size.height * 0.04),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.035,
                          child: const SingleChildScrollView(
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "Itinerario de viaje",
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

              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return DaysList(day: index+1, locations: route.locations);
                  },
                  childCount: route.locations.length,
                ),
              ),
            ],
      ),
      );
  }

  checkImageNumber(TravelRoute route){
    if (route.locations[0].images.length > 1){
      return Carousel(images: route.locations[0].images);
    }
    else {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(route.locations[0].images[0]),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }
}

