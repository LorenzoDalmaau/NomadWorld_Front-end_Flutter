import 'package:flutter/material.dart';

import '../../../models/Country.dart';

class searchCountryList extends StatefulWidget {
  List<Country> countryList = [];


  searchCountryList({super.key, required this.countryList});

  @override
  State<searchCountryList> createState() => _searchCountryListState();
}

class _searchCountryListState extends State<searchCountryList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        itemCount: widget.countryList.length,
        itemBuilder: (BuildContext context, int index) {
          print(widget.countryList.length);
          return ListTile(
            title: Text(widget.countryList[index].name!),
          );
        },
      ),
    );
  }
}
