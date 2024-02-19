import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomadworld/models/TravelRoute.dart';
import 'package:nomadworld/ui/screens/RouteScreen/widgets/Location_Card.dart';
import 'package:nomadworld/ui/widgets/CarrouselAppbar.dart';
import 'package:provider/provider.dart';

import '../../../utils/providers/user_provider.dart';
import '../../widgets/texts/DescriptionText.dart';

class RouteScreen extends StatefulWidget {

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  @override
  Widget build(BuildContext context) {
    UserProvider provider = Provider.of<UserProvider>(context);

    final TravelRoute route = Get.arguments as TravelRoute;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height * 0.3,
                  floating: false,
                  pinned: true,
                  title: Text(
                    route.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  backgroundColor: const Color.fromARGB(255, 20, 134, 94),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: CarrouselAppBar(images: getAllImages(route)),
                  ),
                ),
                SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.025, top: MediaQuery.of(context).size.height * 0.025,bottom: MediaQuery.of(context).size.height * 0.010),
                          child: Text(
                            route.name,
                            style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.025),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.005,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/card_background.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        DescriptionText(description: route.descrption),
                      ],
                    )
                ),
                SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.height * 0.025, MediaQuery.of(context).size.height * 0.025, MediaQuery.of(context).size.height * 0.025, MediaQuery.of(context).size.height * 0.025),
                      child: Column(
                        children: [
                          SizedBox(
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
                          const SizedBox(height: 5,),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.005,
                            decoration: const BoxDecoration(
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
                        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01, horizontal: MediaQuery.of(context).size.height * 0.025),
                        child: Text(
                          "${route.duration} dias",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01, horizontal: MediaQuery.of(context).size.height * 0.025),
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
            Positioned(
              top: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: _checkLocationSaved(provider, route.id)
                      ? IconButton(
                      onPressed: () {
                        provider.deleteSavedRoute(route.id);
                        setState(() {
        
                        });
                      },
                      icon: const Icon(
                        Icons.bookmark,
                        color: Color.fromARGB(255, 20, 134, 94),
                        size: 30,
                      ))
                      : IconButton(
                      onPressed: () {
                        provider.saveRoute(route);
                        setState(() {
        
                        });
                      },
                      icon: const Icon(
                        Icons.bookmark_border,
                        size: 30,
                      )
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );

  }

  bool _checkLocationSaved(UserProvider provider, int routeID){
    for (var locationsSaved in provider.savedRoutes){
      if(locationsSaved.id == routeID){
        return true;
      }
    }
    return false;
  }

  List<String> getAllImages(TravelRoute route){
    List<String> images = [];

    for( var location in route.locations){
      images.addAll(location.images);
    }

    return images;
  }
}