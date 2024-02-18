import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../models/Country.dart';
import '../../../models/Location.dart';

class SearchLocationList extends StatelessWidget {
  List<LocationData> locationList = [];



  SearchLocationList({super.key, required this.locationList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: locationList.length,
      itemBuilder: (BuildContext context, int index) {
        return LocationInfoCard(location: locationList[index]);
      },
    );
  }
}

class LocationInfoCard extends StatelessWidget {
  LocationInfoCard({super.key, required this.location});

  late LocationData location;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.toNamed('/location', arguments: location);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.all(Radius.circular(10))
          ),
          child: Row(
            children: [
              /// Imagen
              Expanded(
                flex: 2,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(location.images[0]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              /// Título y descripción
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        location.name!,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        location.description,
                        style: const TextStyle(
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

