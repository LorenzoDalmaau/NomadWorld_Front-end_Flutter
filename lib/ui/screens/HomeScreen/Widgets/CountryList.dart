import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nomadworld/models/Country.dart';

class ContryList extends StatelessWidget {
  final List<Country> countries;

  ContryList({required this.countries});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.03, 0, MediaQuery.of(context).size.width * 0.03, MediaQuery.of(context).size.width * 0.01),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.3),
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            itemCount: countries.length,
            itemBuilder: (context, index) {
              final item = countries[index];
              return InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    image: DecorationImage(
                      image: AssetImage(item.image),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(150, 0, 0, 0),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          checkTextSize(item.name),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
        ),
      )
    );
  }


  String checkTextSize(String text){

    if(text.length > 10){
      return "${text.substring(0,7)}...";
    }
    else return text;
  }
}