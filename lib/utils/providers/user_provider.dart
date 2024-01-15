import 'package:flutter/material.dart';
import 'package:nomadworld/models/Location.dart';
import 'package:nomadworld/models/TravelRoute.dart';
import 'package:nomadworld/models/user_base.dart';

class UserProvider extends ChangeNotifier{

  UserBase? user;
  List<TravelRoute> savedRoutes = [TravelRoute(id: 1, name: 'name', descrption: 'descrption', distance: 52, duration: 52, country_id: 1, locations: [])]; // TravelRoute(id: 1, name: 'name', descrption: 'descrption', distance: 52, duration: 52, country_id: 1, locations: [])
  List<LocationData> savedLocations = [LocationData(id: 1, name: 'Hola', description: 'description', date: 'date', countri_id: 1, images: [], longitude: 1.23123, latitude: 1.5123123)]; // LocationData(id: 1, name: 'Hola', description: 'description', date: 'date', countri_id: 1, images: [], longitude: 1.23123, latitude: 1.5123123)

  initUser(UserBase? userDatas){
    user = userDatas;
    // savedRoutes = userDatas!.savedRoutes;
    // savedLocations = userDatas!.savedLocations;
    notifyListeners();
  }

  saveLocation(){
    //TODO peticion a la api que guarde una localizacion
    notifyListeners();
  }

  saveRoute(){
    //TODO peticion a la api que guarde una localizacion
    notifyListeners();
  }

  deleteSavedRoute(){
    //Todo peticion a la api para que deje de guardar una ruta
    notifyListeners();
  }

  deleteSavedLocation(){
    //TOdo peticion a la api para dejar de guardar una localizacion
    notifyListeners();
  }

}