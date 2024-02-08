import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
          return CountryInfoCard(country: widget.countryList[index]);
        },
      ),
    );
  }
}

class CountryInfoCard extends StatelessWidget {
  CountryInfoCard({super.key, required this.country});

  late Country country;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.toNamed('/country', arguments: country);
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
                      image: NetworkImage(country.image),
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
                  child: Text(
                    country.name,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
