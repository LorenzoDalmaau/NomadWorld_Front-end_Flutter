import 'package:flutter/material.dart';
import 'package:nomadworld/ui/widgets/create_il/create_il_name.dart';
import 'package:nomadworld/ui/widgets/create_il/create_il_title.dart';

import '../../widgets/create_il/create_il_subtitle.dart';

class CreateRoute extends StatefulWidget {
  const CreateRoute({super.key});

  @override
  State<CreateRoute> createState() => _CreateRouteState();
}

class _CreateRouteState extends State<CreateRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Crear ruta',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 17,
                letterSpacing: 0.5,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 25, 30, 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                CreateILTitle(title: 'Crear nueva ruta'),

                /// Subtitle
                CreateILSubtitle(
                    subtitle: 'Pensar una frase\nacorde a su objetivo'),

                const SizedBox(height: 50),
                
                /// Route Name
                CreateILName(ilName: 'Pon un título a tu ruta')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
