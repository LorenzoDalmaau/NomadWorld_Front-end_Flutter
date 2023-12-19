import 'package:flutter/material.dart';

class CreateILSubtitle extends StatelessWidget {
  String subtitle;
  CreateILSubtitle({
    super.key,
    required this.subtitle
  });

  @override
  Widget build(BuildContext context) {
    return Text(subtitle);
  }
}