import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nomadworld/models/Location.dart';
import 'package:nomadworld/ui/screens/RouteScreen/widgets/LocationList.dart';

class DaysList extends StatelessWidget {
  final int day;
  final List<LocationData> locations;

  DaysList({required this.day, required this.locations});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.03, 0, MediaQuery.of(context).size.width * 0.03, MediaQuery.of(context).size.width * 0.01),
        child: Column(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Dia ${day}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.003,
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
            LocationList(locations: locations)
          ],
        )
        );
  }
}