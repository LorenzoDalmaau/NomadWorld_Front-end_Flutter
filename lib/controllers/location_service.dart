import 'package:geolocator/geolocator.dart';

Future<Position> determinePosition() async {
  LocationPermission permission;
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error(
          'Debes aceptar los permisos para obtener tu ubicación');
    }
  }
  return await Geolocator.getCurrentPosition();
}