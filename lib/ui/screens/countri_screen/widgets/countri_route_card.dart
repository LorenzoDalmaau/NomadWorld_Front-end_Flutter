import 'package:flutter/material.dart';
import 'package:nomadworld/models/TravelRoute.dart';

class CountiRouteCard extends StatelessWidget {
  CountiRouteCard({super.key, required this.route});

  late TravelRoute route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, arguments: route, '/route');
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                image: DecorationImage(
                  image: NetworkImage(route.locations[0].images[0]),
                  fit: BoxFit.cover,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(150, 0, 0, 0),
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        route.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "${route.distance}km",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ]),
        ));
  }
}
