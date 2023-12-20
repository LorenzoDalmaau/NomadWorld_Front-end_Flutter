import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:nomadworld/models/Location.dart';
import 'package:nomadworld/ui/widgets/CarrouselAppbar.dart';
import 'package:nomadworld/ui/widgets/map/map_box.dart';
import 'package:nomadworld/ui/widgets/texts/DescriptionText.dart';

class LocationDetail extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final LocationData location = Get.arguments as LocationData;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CarrouselAppBar(name: location.name!, images: location.images),
          SliverList(delegate: SliverChildListDelegate(
            [
            DescriptionText(description: location.description),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: MapBox(cordinades: LatLng(location.latitude, location.longitude)),
            )
            ]
          )
          )
        ],
      ),
    );
  }

}