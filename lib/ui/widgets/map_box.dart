import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoibG9yZW56b2RhbG1hdSIsImEiOiJjbG92ZXMxemswdzAwMmxsbDF0dWhyNW9rIn0.JyO5o6PltVGdyybgflz7uQ';

const MAPBOX_STYLE = 'mapbox/streets-v12';

final myPosition = LatLng(41.4326948, 2.1733909);

class MapBox extends StatefulWidget {
  const MapBox({super.key});

  @override
  State<MapBox> createState() => _MapBoxState();
}

class _MapBoxState extends State<MapBox> {
  LatLng? myPosition;

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

  void getCurrentLocation() async {
    Position position = await determinePosition();
    setState(() {
      myPosition = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return myPosition == null
        ? const Text('Cargando...', style: TextStyle(color: Color(0xff185f46), fontWeight: FontWeight.bold),)
        : FlutterMap(
            options: MapOptions(
              initialCenter: myPosition!,
              minZoom: 5,
              maxZoom: 25,
              initialZoom: 15,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                additionalOptions: const {
                  'accessToken': MAPBOX_ACCESS_TOKEN,
                  'id': MAPBOX_STYLE,
                },
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: myPosition!,
                    child: const Icon(
                      Icons.person_pin,
                      color: Color(0xff185f46),
                      size: 30,
                    ),
                  ),
                ],
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     getCurrentLocation();
              //   },
              //   child: Text('Probar'),
              // ),
            ],
          );
  }
}
