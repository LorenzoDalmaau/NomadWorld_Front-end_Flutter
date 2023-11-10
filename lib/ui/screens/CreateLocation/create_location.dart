import 'package:flutter/material.dart';
import 'package:nomadworld/ui/screens/CreateLocation/widgets/build_subtitle.dart';
import 'package:nomadworld/ui/screens/CreateLocation/widgets/build_location.dart';
import 'package:nomadworld/ui/screens/CreateLocation/widgets/build_title.dart';

class CreateLocation extends StatefulWidget {
  const CreateLocation({super.key});

  @override
  State<CreateLocation> createState() => _CreateLocationState();
}

class _CreateLocationState extends State<CreateLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Continuar',
              style: TextStyle(
                color: Colors.green,
                fontSize: 15,
                decoration: TextDecoration.underline,
                letterSpacing: 0.5,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),

      //BODY
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const BuildTitle(),
                // Subtitle
                BuildSubtitle(),
                // TextFields
                const BuildLocation(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


