import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nomadworld/models/Location.dart';

class LocationList extends StatelessWidget {
  final List<LocationData> locations;

  LocationList({required this.locations});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * (0.24 * locations.length + 0.08),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: locations.length,
          itemBuilder: (context, index) {
            final location = locations[index];
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, bottom: MediaQuery.of(context).size.height * 0.02),
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(150, 0, 0, 0),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                          child: Container(
                            width: MediaQuery.of(context).size.height * 0.17,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                              image: DecorationImage(
                                image: AssetImage(location.images[0]),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(150, 0, 0, 0),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                              padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
                              child: Text(
                                location.description,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                      ]
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
                        child: Row(
                          children: [
                            Text(
                              "${location.likes} ",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Image.asset(
                              "assets/like-black.png",
                              height: MediaQuery.of(context).size.height * 0.02,
                              width: MediaQuery.of(context).size.height * 0.02,
                            ),
                          ],
                        ),
                      )
                    ),
                ],
              )
            );
          }
      ),
    );
  }
}