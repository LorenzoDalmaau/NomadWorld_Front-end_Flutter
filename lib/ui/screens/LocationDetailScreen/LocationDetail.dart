import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:nomadworld/models/Location.dart';
import 'package:nomadworld/ui/widgets/CarrouselAppbar.dart';
import 'package:nomadworld/ui/widgets/map/map_box.dart';
import 'package:nomadworld/ui/widgets/texts/DescriptionText.dart';
import 'package:nomadworld/utils/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LocationDetail extends StatefulWidget {
  @override
  State<LocationDetail> createState() => _LocationDetailState();
}

class _LocationDetailState extends State<LocationDetail> {
  @override
  Widget build(BuildContext context) {
    UserProvider provider = Provider.of<UserProvider>(context);

    final LocationData location = Get.arguments as LocationData;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height * 0.3,
                  floating: false,
                  pinned: true,
                  title: Text(
                    location.name!,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: const Color.fromARGB(255, 20, 134, 94),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: CarrouselAppBar(images: location.images),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                  [
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.025, top: MediaQuery.of(context).size.height * 0.025,bottom: MediaQuery.of(context).size.height * 0.010),
                    child: Text(
                      location.name!,
                      style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.025),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.005,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/card_background.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  DescriptionText(description: location.description),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    child: MapBox(
                        cordinades:
                            LatLng(location.latitude, location.longitude)),
                  )
                ]))
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: _checkLocationSaved(provider, location.id)
                      ? IconButton(
                          onPressed: () {
                            provider.deleteSavedLocation(location.id);
                            setState(() {
            
                            });
                          },
                          icon: const Icon(
                            Icons.bookmark,
                            color: Color.fromARGB(255, 20, 134, 94),
                            size: 30,
                          ))
                      : IconButton(
                          onPressed: () {
                            provider.saveLocation(location);
                            setState(() {
            
                            });
                          },
                          icon: const Icon(
                            Icons.bookmark_border,
                            size: 30,
                          )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _checkLocationSaved(UserProvider provider, int locaiton){
    for (var locationsSaved in provider.savedLocations){
      if(locationsSaved.id == locaiton){
        return true;
      }
    }
    return false;
  }

}
