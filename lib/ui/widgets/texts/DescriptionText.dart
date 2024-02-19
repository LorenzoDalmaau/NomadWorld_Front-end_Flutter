import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
      child: Expanded(
        child: Text(
          description,
          style: const TextStyle(
              fontSize: 15,
              //fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
