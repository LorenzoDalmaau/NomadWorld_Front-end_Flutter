import 'package:flutter/material.dart';

class RouteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200, // Altura expandida del app bar
            floating: false, // La app bar no se mantiene flotando
            pinned: true, // La app bar permanece fija en la parte superior
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Título de la Ruta'),
              background: Image.asset(
                'assets/japan.jpg',
                fit: BoxFit.cover,
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
              childCount: 20, // Cantidad de elementos en la lista
            ),
          ),
        ],
      ),
    );
  }
}