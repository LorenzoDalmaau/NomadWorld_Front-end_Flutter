import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../models/TravelRoute.dart';

class PopularRoutesList extends StatelessWidget {
  final List<TravelRoute> routes;

  PopularRoutesList({required this.routes});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: routes.length,
        itemBuilder: (context, index) {
          final item = routes[index];
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/route',
                arguments: item,
              );
            },
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.50,
                height: MediaQuery.of(context).size.height * 0.18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  image: DecorationImage(
                    image: NetworkImage(item.locations[0].images[0]),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        checkTextSize(item.name),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 8,
                      child: Row(
                        children: [
                          Text(
                            "${item.distance}Km",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  String checkTextSize(String text){

    if(text.length > 10){
      return "${text.substring(0,7)}...";
    }
    else {
      return text;
    }
  }
}