import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomadworld/domain/provider/provider.dart';
import 'package:nomadworld/models/Country.dart';
import 'package:provider/provider.dart';

class ContryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Country> countries = Provider.of<NomadProvider>(context).countries;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * 0.03,
        0,
        MediaQuery.of(context).size.width * 0.03,
        MediaQuery.of(context).size.width * 0.01,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.57,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio:
              MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.3),
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 15.0,
            ),
            itemCount: countries.length,
            itemBuilder: (context, index) {
              final item = countries[index];
              return InkWell(
                onTap: (){
                  Navigator.pushNamed(
                    context,
                    '/country',
                    arguments: item,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    image: DecorationImage(
                      image: NetworkImage(item.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          checkTextSize(item.name),
                          style: const TextStyle(
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
            },
          ),
        ),
      ),
    );
  }

  String checkTextSize(String text) {
    if (text.length > 10) {
      return "${text.substring(0, 7)}...";
    } else {
      return text;
    }
  }
}