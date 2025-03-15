import 'package:flutter/material.dart';

import '../widgets/disk_widget.dart';

class Level1Hanoi extends StatefulWidget {
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
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                onPressed: isSolved ? resetGame : null,
                child: Text(isSolved ? "Restart" : "Go",style: TextStyle(color: Colors.amber,fontSize: 20,fontWeight: FontWeight.bold),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


