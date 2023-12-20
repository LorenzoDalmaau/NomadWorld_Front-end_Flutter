import 'package:flutter/material.dart';

import '../screens/RouteScreen/widgets/Carousel.dart';

class CarrouselAppBar extends StatelessWidget{

  late String name;
  late List<String> images;

  CarrouselAppBar({required this.name, required this.images});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.3,
      floating: false,
      pinned: true,
      title: Text(
        name,
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 20, 134, 94),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: checkImageNumber(images),
      ),
    );
  }

  checkImageNumber(List<String> images){
    if (images.length > 1){
      return Carousel(images: images);
    }
    else {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(images[0]),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }

}