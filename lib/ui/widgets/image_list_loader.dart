import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/provider/provider.dart';

class ImgListLoader extends StatelessWidget {
  late NomadProvider provider;

  ImgListLoader({super.key});

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<NomadProvider>(context);

    return SizedBox(
      height: setContainerHeigh(context),
      child: ListView.builder(
        itemCount: provider.images.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var image = provider.images[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Expanded(
              child: Image.file(image, fit: BoxFit.fill),
            ),
          );
        },
      ),
    );
  }

  setContainerHeigh(context) {
    if (provider.images.isNotEmpty) {
      return MediaQuery.of(context).size.height * 0.20;
    } else {
      return 1.0;
    }
  }
}