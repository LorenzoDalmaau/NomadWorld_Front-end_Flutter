import 'package:flutter/material.dart';

class create_il_location_title extends StatelessWidget {
  const create_il_location_title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        'Ubicación',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}