import 'package:flutter/material.dart';
import '../../../models/Location.dart';

class RouteSearchBar extends StatefulWidget {
  final List<LocationData> locations;
  final List<int> selectedLocations;
  final void Function(List<int>) onSelectionChanged;

  const RouteSearchBar({
    Key? key,
    required this.locations,
    required this.selectedLocations,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  State<RouteSearchBar> createState() => _RouteSearchBarState();
}

class _RouteSearchBarState extends State<RouteSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.37,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.locations.length,
        itemBuilder: (context, index) {
          var location = widget.locations[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                if (widget.selectedLocations.contains(location.id)) {
                  widget.selectedLocations.remove(location.id);
                } else {
                  widget.selectedLocations.add(location.id);
                }
                // Llama a la función de devolución de llamada con la lista actualizada
                widget.onSelectionChanged(widget.selectedLocations);
              });
            },
            child: Card(
              elevation: widget.selectedLocations.contains(location.id) ? 5 : 12,
              shadowColor: Colors.black,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              color: widget.selectedLocations.contains(location.id)
                  ? const Color(0xff398d6d)
                  : const Color(0xff195f47),
              child: ListTile(
                leading: Text(
                  location.id.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                title: Text(location.name!, style: const TextStyle(color: Colors.white)),
              ),
            ),
          );
        },
      ),
    );
  }
}
