import 'package:flutter/material.dart';

import '../../../models/Country.dart';
import '../../../models/TravelRoute.dart';

class searchRouteList extends StatefulWidget {
  List<TravelRoute> routeList = [];


  searchRouteList({super.key, required this.routeList});

  @override
  State<searchRouteList> createState() => _searchRouteListState();
}

class _searchRouteListState extends State<searchRouteList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.routeList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(widget.routeList[index].name!),
        );
      },
    );
  }
}
