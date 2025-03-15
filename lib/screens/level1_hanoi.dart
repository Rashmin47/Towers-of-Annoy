import 'package:flutter/material.dart';

import '../widgets/disk_widget.dart';
import 'level2_annoy.dart';

class Level1Hanoi extends StatefulWidget {
  const Level1Hanoi({super.key});

  @override
  _Level1HanoiState createState() => _Level1HanoiState();
}

class _Level1HanoiState extends State<Level1Hanoi> {
  List<List<int>> pegs = [
    [3, 2, 1], // Peg A (Source)
    [],        // Peg B (Auxiliary)
    []         // Peg C (Destination)
  ];
  bool isSolved = false;

  void performMove(int fromPegIndex, int toPegIndex) {
    setState(() {
      if (pegs[fromPegIndex].isEmpty) return;

      final fromDisk = pegs[fromPegIndex].last;
      final toDisk = pegs[toPegIndex].isEmpty ? null : pegs[toPegIndex].last;

      if (toDisk == null || fromDisk < toDisk) {
        pegs[toPegIndex].add(pegs[fromPegIndex].removeLast());
        checkForCompletion();
      }
    });
  }

  void checkForCompletion() {
    setState(() {
      isSolved = pegs[2].length == 3 &&
          pegs[2][0] == 3 &&
          pegs[2][1] == 2 &&
          pegs[2][2] == 1;
    });
  }
  void _showCongratsDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.amber, width: 3),
        ),
        backgroundColor: Colors.red.withOpacity(0.9),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title Section
              Text(
                "🏆 CONGRATULATIONS!",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(2, 2),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Content Section
              Text(
                "You solved Level 1!",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Next Level Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 25,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const Level2Hanoi()),
                      );
                    },
                    child: Text(
                      "NEXT LEVEL",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Replay Button
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.amber, width: 2),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 25,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      resetGame();
                    },
                    child: Text(
                      "REPLAY",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resetGame() {
    setState(() {
      pegs = [
        [3, 2, 1],
        [],
        []
      ];
      isSolved = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(title: const Text("Tower of Annoy - Level 1"),backgroundColor: Colors.amber,),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(3, (pegIndex) {
                return DragTarget<int>(
                  onAccept: (fromPegIndex) => performMove(fromPegIndex, pegIndex),
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        image: const DecorationImage(image: AssetImage("assets/images/stand.png"),fit: BoxFit.fill),
                        border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(30),
                        color: Colors.amber,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: pegs[pegIndex]
                              .map((disk) => Draggable<int>(
                            data: pegIndex,
                            childWhenDragging: Opacity(opacity: 0.5, child: DiskWidget(size: disk)),
                            feedback: DiskWidget(size: disk),
                            child: DiskWidget(size: disk),
                          ))
                              .toList(),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
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
                onPressed: isSolved ? () => _showCongratsDialog() : null,
                child: Text(isSolved ? "Check" : "Go",style: const TextStyle(color: Colors.amber,fontSize: 20,fontWeight: FontWeight.bold,shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(2, 2),
                    blurRadius: 5,
                  ),
                ],),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


