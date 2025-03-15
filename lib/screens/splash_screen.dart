import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:towersofannoy/screens/main_menu.dart';
import 'dart:math';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
  }

  void _shakeButton() {
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/entrance1.png"))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "TOWERS OF ANNOY",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 2.0,
                    ),
                  ],
                ),

              ),
              const SizedBox(height: 20),
              const Text(
                "Prepare to Suffer!",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                        Random().nextDouble() * 10 - 5,
                        Random().nextDouble() * 10 - 5),

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber, // Primary color
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: const BorderSide(color: Colors.white, width: 2),
                      ),
                      ),
                      onPressed: () {
                        _shakeButton();
                        Future.delayed(const Duration(milliseconds: 500), () {
                          Get.off(const MainMenuScreen()); // Navigate using GetX
                        });
                      },

                      child: const Text("Start Game"),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
