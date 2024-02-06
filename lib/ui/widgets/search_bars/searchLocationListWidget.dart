import 'package:flutter/material.dart';

import '../../../models/Country.dart';
import '../../../models/Location.dart';

class searchLocationList extends StatefulWidget {
  List<LocationData> locationList = [];



  searchLocationList({super.key, required this.locationList});

  @override
  State<searchLocationList> createState() => _searchLocationListState();
}

class _searchLocationListState extends State<searchLocationList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.locationList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(widget.locationList[index].name!),
        );
      },
    );
  }
}
