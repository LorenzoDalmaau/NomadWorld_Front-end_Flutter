import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CardILWidget extends StatelessWidget {
  final Image image;
  final String titleCard;
  final String subtitleCard;
  final String routing;

  const CardILWidget({
    super.key,
    required this.titleCard,
    required this.subtitleCard,
    required this.image,
    required this.routing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 50),
      child: InkWell(
        onTap: () {
          Get.toNamed(routing);
        },
        child: Container(
          width: 380,
          height: 130,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(181, 0, 0, 0),
                blurRadius: 20,
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
                child: image,
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 25.0, right: 25.0),
                  child: Column(
                    children: [
                      Text(
                        titleCard,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        subtitleCard,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
