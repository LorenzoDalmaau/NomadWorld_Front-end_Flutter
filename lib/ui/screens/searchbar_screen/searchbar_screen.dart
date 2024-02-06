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
  /// Controller for the search bar
  SearchController _searchController = SearchController();

  List<LocationData> locationList = [];
  List<TravelRoute> routeList = [];
  List<Country> countryList = [];



  ///Llamar a provider
  late DataProvider _dataProvider;

  /// Variable to check if the user is searching
  bool _isSearching = false;


  void startSearching() {
    setState(() {
      _isSearching = true;
    });
  }

  void stopSearching() {
    setState(() {
      _isSearching = false;
    });
  }
  void goBack(){
    navigator?.pop(context);
  }

  void clearSearch() {
    _searchController.clear();
  }

  @override
  void initState() {
    getSearchDatas();
    super.initState();
  }

  getSearchDatas() async {
    locationList = await ApiService().getLocations();
    routeList = await ApiService().getPopularRoutes();
    countryList = await ApiService().getCountryList();
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 37, 113, 85),
              elevation: 0.0,
              toolbarHeight: kToolbarHeight + MediaQuery.of(context).size.height * 0.03,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    goBack();
                  }),
            bottom: const TabBar(
              tabs: [

                  Tab(
                    child: Text('Country', style: TextStyle(color: Colors.white)),


                  ),
                  Tab(
                    child: Text('Location', style: TextStyle(color: Colors.white)),

                  ),
                  Tab(
                    child: Text('Route', style: TextStyle(color: Colors.white)),
                  ),
                ], indicatorColor: Colors.white),

              title: miSearchBar(_searchController),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {

                  },
                ),
              ],
            ),
            body: TabBarView(
              children: [
                searchCountryList(countryList: countryList),
                searchLocationList(locationList: locationList),
                searchRouteList(routeList: routeList),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
String busqueda = '';
Widget miSearchBar(SearchController _searchController) {


  return SearchBar(
    controller: _searchController,
    hintText: 'Search',
    elevation: MaterialStateProperty.all(0.0),
    onTap: () {
      SearchController();
    },
    onChanged: (value) {
      busqueda = value;
      // Do something with the value
      DataProvider().routeList.length;
      ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(DataProvider().routeList[index].name),
          );
        },
      );
    },
  );
}
