import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:towersofannoy/screens/splash_screen.dart';
import 'screens/main_menu.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Towers of Annoy",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashScreen(),
    );
  }
}
