import 'package:flutter/material.dart';

class CreateILTitle extends StatelessWidget {
  String title;

  CreateILTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 25, fontWeight: FontWeight.bold),
    );
  }
}