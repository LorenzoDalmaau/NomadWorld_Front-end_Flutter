import 'package:flutter/material.dart';

class BuildTextFields extends StatelessWidget {
  const BuildTextFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        children: [
          NameLocation(),

        ],
      ),
    );
  }
}



class NameLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Pon un título a tu recuerdo *',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }

}