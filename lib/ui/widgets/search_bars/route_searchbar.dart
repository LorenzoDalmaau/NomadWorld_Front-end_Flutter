import 'package:flutter/material.dart';

import '../../../models/Country.dart';

class RouteSearchBar extends StatefulWidget {
  Country countySelected;
  RouteSearchBar({super.key, required this.countySelected});

  @override
  State<RouteSearchBar> createState() => _RouteSearchBarState();
}

class _RouteSearchBarState extends State<RouteSearchBar> {

  String query = '';
  void onQueryChanged(String newQuery) {
    setState(() {
      query = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        onChanged: onQueryChanged,
        decoration: const InputDecoration(
          labelText: 'Buscar...',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
