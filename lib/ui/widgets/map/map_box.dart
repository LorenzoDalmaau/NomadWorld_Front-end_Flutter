import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoibG9yZW56b2RhbG1hdSIsImEiOiJjbG92ZXMxemswdzAwMmxsbDF0dWhyNW9rIn0.JyO5o6PltVGdyybgflz7uQ';

const MAPBOX_STYLE = 'mapbox/streets-v12';


class MapBox extends StatefulWidget {

  late LatLng cordinades;

  MapBox({required this.cordinades});

  @override
  State<MapBox> createState() => _MapBoxState();
}

class _MapBoxState extends State<MapBox> {

  late LatLng cordinades;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: FlutterMap(
        options: MapOptions(
            initialCenter: widget.cordinades,
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
                point: widget.cordinades,
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
    );
  }
}
