import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../../controllers/location_service.dart';

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoibG9yZW56b2RhbG1hdSIsImEiOiJjbG92ZXMxemswdzAwMmxsbDF0dWhyNW9rIn0.JyO5o6PltVGdyybgflz7uQ';

const MAPBOX_STYLE = 'mapbox/streets-v12';


class MapBox extends StatefulWidget {
  final Function(LatLng) onLocationChanged;

  const MapBox({super.key, required this.onLocationChanged});

  @override
  State<MapBox> createState() => _MapBoxState();
}

class _MapBoxState extends State<MapBox> {
  LatLng? myPosition;
  LatLng? tappedPosition;
  List<Marker> markers = [];

  void getCurrentLocation() async {
    Position position = await determinePosition();
    setState(() {
      myPosition = LatLng(position.latitude, position.longitude);
      tappedPosition = myPosition;
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
        ? const Center(
            child: Text(
              'Cargando...',
              style: TextStyle(
                  color: Color(0xff185f46),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          )
        : Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                initialCenter: myPosition!,
                minZoom: 5,
                maxZoom: 25,
                initialZoom: 15,
                onTap: (point, latLng) {
                  setState(() {
                    tappedPosition = latLng;
                    markers = [
                      Marker(
                        point: tappedPosition!,
                        child: const Icon(
                          Icons.location_on,
                          color: Color(0xff185f46),
                          size: 30,
                        ),
                      ),
                    ];
                    widget.onLocationChanged(tappedPosition!);
                  });
                }
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
                    if (myPosition != null)
                      // Marker(
                      //   point: myPosition!,
                      //   child: const Icon(
                      //     Icons.person_pin,
                      //     color: Color(0xff185f46),
                      //     size: 30,
                      //   ),
                      // ),

                    if (tappedPosition != null)
                      Marker(
                        point: tappedPosition!,
                        child: const Icon(
                          Icons.location_on,
                          color: Color(0xff185f46),
                          size: 30,
                        ),
                      ),
                  ],
                ),
              ],

            ),
          ],
        );
  }
}
