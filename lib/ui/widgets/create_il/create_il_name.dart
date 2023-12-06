import 'package:flutter/material.dart';

class CreateILName extends StatelessWidget {
  String ilName;
  CreateILName({
    super.key,
    required this.ilName,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        ilName,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
