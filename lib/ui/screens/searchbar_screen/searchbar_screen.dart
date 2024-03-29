import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomadworld/models/Location.dart';
import 'package:nomadworld/models/TravelRoute.dart';
import 'package:nomadworld/ui/widgets/search_bars/searchLocationListWidget.dart';
import 'package:nomadworld/ui/widgets/search_bars/searchRouteListWidget.dart';
import 'package:nomadworld/utils/providers/data_provider.dart';
import '../../../models/Country.dart';
import '../../../utils/api/api_service.dart';
import '../../widgets/search_bars/searchCountryListWidget.dart';

class SearchBarScreen extends StatefulWidget {
  const SearchBarScreen({super.key});

  @override
  State<SearchBarScreen> createState() => _SearchBarScreenState();
}

class _SearchBarScreenState extends State<SearchBarScreen> {

  final TextEditingController _textController = TextEditingController();

  List<LocationData> locationList = [];
  List<LocationData> _filteredLocationList = [];

  List<TravelRoute> routeList = [];
  List<TravelRoute> _filteredRouteList = [];

  List<Country> countryList = [];
  List<Country> _filteredCountryList = [];

  @override
  void initState() {
    getSearchDatas();
    super.initState();
  }

  void _filterLogListBySearchText(String searchText) {
    setState(() {
      _filteredLocationList = locationList
          .where((location) =>
              location.name!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      _filteredRouteList = routeList
          .where((route) =>
          route.name!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      _filteredCountryList = countryList
          .where((country) =>
          country.name!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  getSearchDatas() async {
    countryList = await ApiService().getCountryList();
    locationList = await ApiService().getLocations();
    routeList = await ApiService().getPopularRoutes();
    setState(() {
      _filteredLocationList = locationList;
      _filteredRouteList = routeList;
      _filteredCountryList = countryList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 37, 113, 85),
            elevation: 0.0,
            toolbarHeight:
            kToolbarHeight + MediaQuery.of(context).size.height * 0.03,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                }),
            bottom: const TabBar(tabs: [
              Tab(
                child: Text('Pais', style: TextStyle(color: Colors.white)),
              ),
              Tab(
                child:
                Text('Localización', style: TextStyle(color: Colors.white)),
              ),
              Tab(
                child: Text('Ruta', style: TextStyle(color: Colors.white)),
              ),
            ], indicatorColor: Colors.white),
            title: Container(
              height: 45,
              decoration: BoxDecoration(
                  color: const Color(0xffF5F5F5),
                  borderRadius: BorderRadius.circular(5)),
              child: TextField(
                cursorColor: const Color(0xFF257155),

                controller: _textController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 10,left: 10,bottom: 10),
                  suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.clear_rounded,
                        color: Color(0xFF257155),
                      ),
                      onPressed: () {
                        _textController.text = "";
                        _filterLogListBySearchText("");
                      }),
                  hintText: 'Buscar...',
                  border: InputBorder.none,
                ),
                onChanged: (value) => _filterLogListBySearchText(value),
                onSubmitted: (value) => _filterLogListBySearchText(value),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              countryList.isEmpty ? circularIndicator() : searchCountryList(countryList: _filteredCountryList),
              locationList.isEmpty ? circularIndicator() : SearchLocationList(locationList: _filteredLocationList),
              routeList.isEmpty ? circularIndicator() : SearchRouteList(routeList: _filteredRouteList),
            ],
          ),
        ),
      ),
    );
  }

  Widget circularIndicator(){
    return const Center(
      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF257155))),
    );
  }

}

