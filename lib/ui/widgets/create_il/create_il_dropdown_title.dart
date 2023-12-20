import 'package:flutter/material.dart';

class dropdown_menu_title extends StatelessWidget {
  const dropdown_menu_title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text('¿A que país pertenece?',
          style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}