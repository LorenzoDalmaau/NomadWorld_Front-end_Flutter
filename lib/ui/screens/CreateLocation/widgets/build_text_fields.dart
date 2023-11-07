import 'package:flutter/material.dart';

class BuildTextFields extends StatelessWidget {
  TextEditingController nameLocationController = TextEditingController();
  TextEditingController descriptionLocationController = TextEditingController();

  BuildTextFields({super.key, required this.nameLocationController, required this.descriptionLocationController});




  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Column(
        children: [
          LocationName(),

        ],
      ),
    );
  }
}



class LocationName extends StatelessWidget {
  const LocationName({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Pon un título a tu recuerdo *',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        TextField(

        ),
      ],
    );
  }

}