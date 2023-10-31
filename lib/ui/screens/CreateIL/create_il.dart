import 'package:flutter/material.dart';
import 'package:nomadworld/ui/screens/CreateIL/Constants/constants.dart';

class CreateIL extends StatelessWidget {
  const CreateIL({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.33,
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
              child:  Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  const Text(creationPageTitle, style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  const Text(creationPageSubtitle, style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
          ),

          // Contenedor donde estarán las 2 opciones
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
            child: InkWell(
              child: Container(
                width: 300,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color.fromARGB(115, 105, 103, 103),
                  ),
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 50),
                      child: Icon(
                          Icons.map_sharp,
                          size: 40,
                          color: Colors.black38),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
