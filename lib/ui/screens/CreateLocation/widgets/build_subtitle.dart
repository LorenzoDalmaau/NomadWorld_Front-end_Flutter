import 'package:flutter/material.dart';

class BuildSubtitle extends StatelessWidget {
  final String text = 'Añade la ubicación, tus fotos y recomendaciones';

  @override
  Widget build(BuildContext context) {
    List<String> words = text.split(" ");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // Muestra las primeras 6 palabras en la primera línea
          words.take(6).join(' '),
        ),
        if (words.length > 6)
          Text(
            // Muestra las palabras restantes en la segunda línea
            words.skip(6).join(' '),
          ),
      ],
    );
  }
}