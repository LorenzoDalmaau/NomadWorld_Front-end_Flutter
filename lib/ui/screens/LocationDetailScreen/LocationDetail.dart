import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomadworld/models/Location.dart';

class LocationDetail extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    final LocationData location = Get.arguments as LocationData;

    return Text(location.name);
  }

}