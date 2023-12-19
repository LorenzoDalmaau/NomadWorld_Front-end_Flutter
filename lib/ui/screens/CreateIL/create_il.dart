import 'package:flutter/material.dart';
import 'package:nomadworld/ui/screens/CreateIL/Constants/constants.dart';
import 'package:nomadworld/ui/screens/CreateIL/Widgets/card_il_widget.dart';

class CreateIL extends StatelessWidget {
  const CreateIL({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              //height: MediaQuery.of(context).size.height * 0.33,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(150, 0, 0, 0),
                    blurRadius: 20,
                  ),
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/card_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 50),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    const Text(creationPageTitle,
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    const Text(
                      creationPageSubtitle,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardILWidget(
                  image: Image.asset("assets/route.jpg", fit: BoxFit.cover),
                  titleCard: titleCardRoute,
                  subtitleCard: subtitleCardRoute,
                  routing: '/create_route',
                ),
                const SizedBox(height: 20),
                CardILWidget(
                  image: Image.asset("assets/location.jpg", fit: BoxFit.cover),
                  titleCard: titleCardLocation,
                  subtitleCard: subtitleCardLocation,
                  routing: '/create_location',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}