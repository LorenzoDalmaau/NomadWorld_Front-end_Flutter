import 'package:flutter/material.dart';

class BuildTitle extends StatelessWidget {
  const BuildTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Mi ubicación',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}