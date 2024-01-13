import 'package:flutter/material.dart';
import 'package:nomadworld/utils/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../screens/RouteScreen/widgets/Carousel.dart';

class CarrouselAppBar extends StatelessWidget{

  late List<String> images;

  CarrouselAppBar({required this.images});

  @override
  Widget build(BuildContext context) {
    return checkImageNumber(images);
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