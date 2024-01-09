import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:nomadworld/ui/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'domain/provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<NomadProvider>(create: (_) => NomadProvider()),
      ],
      child: GetMaterialApp(
        title: 'Nomad World',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: '/login',
        getPages: AppRoutes.routes,
      ),
    );
  }
}

