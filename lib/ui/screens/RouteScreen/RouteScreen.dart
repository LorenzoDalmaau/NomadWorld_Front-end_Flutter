import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomadworld/models/TravelRoute.dart';
import 'package:nomadworld/ui/screens/RouteScreen/widgets/Carousel.dart';

class RouteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final TravelRoute route = Get.arguments as TravelRoute;

    return Scaffold(
      body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.3,
                floating: false,
                pinned: true,
                backgroundColor: Color.fromARGB(255, 20, 134, 94),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(route.title),
                  background: checkImageNumber(route),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                  child: Container(
                    color: Colors.green, // Color verde
                    height: 140, // Ajusta la altura del Container según tus necesidades
                    child: SingleChildScrollView(
                      child: Text(route.description),
                    ),
                  ),
                )
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return ListTile(
                      title: Text('Elemento $index'),
                    );
                  },
                  childCount: 20,
                ),
              ),
            ],
      ),
      );
  }

  checkImageNumber(TravelRoute route){
    if (route.images.length > 1){
      return Carousel(images: route.images);
    }
    else {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(route.images[0]),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }
}

