import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'level1_hanoi.dart';
import 'level2_annoy.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(title: const Text("Towers of Annoy"),backgroundColor: Colors.amber,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Image(image: AssetImage("assets/images/tower.png"),height: 400,width: 800,),
            Container(
              decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/towerhanoi.png")),color: Colors.red),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber, // Primary color
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: const BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                    onPressed: () => Get.to(const Level1Hanoi()),
                    child: const Text("Level 1 - Normal"),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber, // Primary color
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: const BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                    onPressed: () => Get.to(const Level2Hanoi()),
                    child: const Text("Level 2 - Annoying Mode"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
