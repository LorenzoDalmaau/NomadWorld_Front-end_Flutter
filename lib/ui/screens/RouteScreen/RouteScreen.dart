import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class RouteScreen extends StatelessWidget {
  final List<String> images = [
    'assets/paris.jpg',
    'assets/espana.jpg',
    'assets/japan.jpg',
    'assets/croacia.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.3,
            floating: false,
            pinned: true,
            backgroundColor: Color.fromARGB(255, 20, 134, 94),
            //backgroundColor: Colors.transparent, // Fondo transparente para que se vea el fondo de imagen
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Título de la Ruta'),
              background: CarouselSlider(
                items: images.map((image) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.4,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayAnimationDuration: Duration(milliseconds: 1000),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  enlargeCenterPage: true,
                ),
              ),
            ),
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
}