import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'level1_hanoi.dart';
import 'level2_annoy.dart';

class MainMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(title: const Text("Towers of Annoy"),backgroundColor: Colors.amber,),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/gate.png"),),color: Colors.red),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber, // Primary color
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                onPressed: () => Get.to(Level1Hanoi()),
                child: const Text("Level 1 - Normal"),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber, // Primary color
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                onPressed: () => Get.to(Level2Hanoi()),
                child: const Text("Level 2 - Annoying Mode"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
