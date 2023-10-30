import 'package:flutter/material.dart';

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
                  const Text('¿Qué te gustaría crear hoy?', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  const Text("¡Crea nuevas rutas y/o ubicaciones para que los demás usuarios puedan disfrutar de nuevas rutas!", style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
          ),
          //TODO Agregar Cards
          //Card1
          InkWell(
            child: Container(

            ),
          ),
          //Card2
        ],
      ),
    );
  }
}
