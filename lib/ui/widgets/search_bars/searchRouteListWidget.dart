import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/TravelRoute.dart';

class SearchRouteList extends StatelessWidget {
  List<TravelRoute> routeList = [];


  SearchRouteList({super.key, required this.routeList});

  @override
  Widget build(BuildContext context) {
    return routeList.isEmpty
        ? const Center(
            child: Text("No se han encontrado resultados"),
          )
        : ListView.builder(
      itemCount: routeList.length,
      itemBuilder: (BuildContext context, int index) {
        return RouteInfoCart(route: routeList[index]);
      },
    )
    ;
  }
}

class RouteInfoCart extends StatelessWidget {

  TravelRoute? route;

  RouteInfoCart({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.toNamed('/route', arguments: route);
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
                      image: NetworkImage(route!.locations![0].images![0]),
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
                        route!.name!,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        route!.descrption!,
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
