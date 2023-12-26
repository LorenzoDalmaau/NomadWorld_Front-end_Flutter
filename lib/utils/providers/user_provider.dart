import 'package:flutter/material.dart';
import 'package:nomadworld/models/Location.dart';
import 'package:nomadworld/models/TravelRoute.dart';
import 'package:nomadworld/models/user_base.dart';

class UserProvider extends ChangeNotifier{

  UserBase? user;
  List<TravelRoute> savedRoutes = [];
  List<LocationData> savedLocations = [];

  initUser(UserBase userDatas){
    user = userDatas;
    savedRoutes = userDatas.savedRoutes;
    savedLocations = userDatas.savedLocations;
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