import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nomadworld/utils/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../../widgets/user_profile/rcard.dart';

class MySavedRoutes extends StatefulWidget {
  MySavedRoutes({super.key});

  @override
  State<MySavedRoutes> createState() => _MySavedRoutesState();
}

class _MySavedRoutesState extends State<MySavedRoutes> {
  // Instancia of the UserProvider
  late UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);

    return _userProvider.savedRoutes.isEmpty
        ? const Center(
            child: Text('No hay rutas guardadas'),
          )
        : ListView.builder(
            itemCount: _userProvider.savedRoutes.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Get.toNamed('/route', arguments: _userProvider.savedRoutes[index]);
                },
                child: Rcard(
                  savedRoute: _userProvider.savedRoutes[index],
                  updateList: () {
                    setState(() {});
                  },
                ),
              ),
            ),
          );
  }
}
