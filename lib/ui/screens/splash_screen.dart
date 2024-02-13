import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/api/api_service.dart';
import '../../utils/providers/user_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    a();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          "assets/lottie/nomadSplash.json",
          height: 300,
          width: 300,
        )
      ),
    );
  }

  a() async {
    await initApp();
  }

  initApp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var logedUserId = prefs.getInt("userId");
    if(logedUserId != null){
      Timer(const Duration(seconds: 3), () {
        Get.offAllNamed('/navigation');

      });

      if(Provider.of<UserProvider>(context, listen: false).user == null){
        Provider.of<UserProvider>(context, listen: false).initUser(await ApiService().getUserById(logedUserId!));
      }

    }
    else {
      Timer(const Duration(seconds: 3), () {
        Get.offAllNamed('/login');
      });
    }
  }
}
