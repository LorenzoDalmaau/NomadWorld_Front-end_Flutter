import 'package:flutter/material.dart';
import 'package:nomadworld/models/Location.dart';
import 'package:nomadworld/models/TravelRoute.dart';
import 'package:nomadworld/models/user_base.dart';
import 'package:nomadworld/utils/api/api_service.dart';

class UserProvider extends ChangeNotifier{

  UserBase? user;
  List<TravelRoute> savedRoutes = [];
  List<LocationData> savedLocations = [];

  initUser(UserBase? userDatas){
    user = userDatas;
    savedRoutes = userDatas!.savedRoutes;
    savedLocations = userDatas!.savedLocations;
    notifyListeners();
  }

  saveLocation(LocationData location){
    savedLocations.add(location);
    ApiService().saveLocation(user!.id, location.id);
    notifyListeners();
  }

  deleteSavedLocation(int locationId){
    for (int i = 0; i < savedLocations.length; i++) {
      if(savedLocations[i].id == locationId){
        savedLocations.remove(savedLocations[i]);
        ApiService().unsaveLocation(user!.id, locationId);
        break;
      }
    }
    notifyListeners();
  }


  saveRoute(TravelRoute route){
    savedRoutes.add(route);
    ApiService().saveRoute(user!.id, route.id);
    notifyListeners();
  }

  deleteSavedRoute(int routeID){
    for (int i = 0; i < savedRoutes.length; i++) {
      if(savedRoutes[i].id == routeID){
        savedRoutes.remove(savedRoutes[i]);
        ApiService().unsaveRoute(user!.id, routeID);
        break;
      }
    }
    notifyListeners();
  }
}