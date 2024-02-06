import 'package:flutter/cupertino.dart';
import 'package:nomadworld/models/Country.dart';
import 'package:nomadworld/models/Location.dart';
import 'package:nomadworld/models/TravelRoute.dart';

class DataProvider extends ChangeNotifier{

  List<Country> countryList = [];
  List<TravelRoute> routeList = [];
  List<LocationData> locationList = [];

}