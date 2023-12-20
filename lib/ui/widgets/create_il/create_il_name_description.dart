import 'package:flutter/material.dart';

class create_il_name_description extends StatelessWidget {
  const create_il_name_description({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        'Añade una descripción',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}