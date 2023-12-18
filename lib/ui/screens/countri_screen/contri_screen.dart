import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nomadworld/models/Country.dart';
import 'package:nomadworld/ui/screens/countri_screen/locations_countri_builder.dart';
import 'package:nomadworld/ui/screens/countri_screen/routes_countri_builder.dart';

class CountriScreen extends StatelessWidget {

  CountriScreen({super.key});

  @override
  Widget build(BuildContext context) {
   final Country country = Get.arguments as Country;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF257155),
          title: Text(
            country.name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          bottom: TabBar(
            labelColor:  Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "Rutas",),
              Tab(text: "Localizaciones",)
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RoutesCountriBuilder(country: country),
            LocationsCountriBuilder(country: country)
          ],
        ),
      ),
    );
  }
}
