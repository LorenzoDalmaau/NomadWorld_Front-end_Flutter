import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoibG9yZW56b2RhbG1hdSIsImEiOiJjbG92ZXMxemswdzAwMmxsbDF0dWhyNW9rIn0.JyO5o6PltVGdyybgflz7uQ';

const MAPBOX_STYLE = 'mapbox/streets-v12';

final myPosition = LatLng(41.4326948, 2.1733909);

class MapBox extends StatelessWidget {
  const MapBox({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: myPosition,
        minZoom: 5,
        maxZoom: 25,
        initialZoom: 15,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
          additionalOptions: const {
            'accessToken': MAPBOX_ACCESS_TOKEN,
            'id': MAPBOX_STYLE,
          },
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: myPosition,
              child: const Icon(
                Icons.person_pin,
                color: Colors.green,
                size: 40,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
