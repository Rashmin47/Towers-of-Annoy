import 'package:flutter/material.dart';
import '../widgets/disk_widget.dart';
import 'dart:math';

class Level2Hanoi extends StatefulWidget {
  @override
  _Level2HanoiState createState() => _Level2HanoiState();
}

class _Level2HanoiState extends State<Level2Hanoi> {
  List<List<int>> pegs = [
    [3, 2, 1],
    [],
    []
  ];
  bool isSolved = false;
  final _random = Random();
  final _roastMessages = [
    "You call that a move? 🤣",
    "Are you even trying?",
    "Why are you so bad at this?",
    "Pegs are laughing at you!",
    "You're making this harder than it needs to be!",
    "What's wrong with you? 😂",
    "This is embarrassing...",
    "Pegs are trolling you!",
    "You're so close... to losing!",
    "Why bother? You'll fail anyway!",
  ];

  void performMove(int fromPegIndex, int toPegIndex) {
    setState(() {
      if (pegs[fromPegIndex].isEmpty) return;

      final fromDisk = pegs[fromPegIndex].last;
      final toDisk = pegs[toPegIndex].isEmpty ? null : pegs[toPegIndex].last;

      if (toDisk == null || fromDisk < toDisk) {
        pegs[toPegIndex].add(pegs[fromPegIndex].removeLast());
        checkForCompletion();

        // Random chaos
        if (_random.nextDouble() < 0.3) {
          _randomizePegs();
          _showRoast();
        }
      }
    });
  }

  void _randomizePegs() {
    setState(() {
      pegs = pegs.map((peg) => peg.toList()).toList();
      pegs.shuffle();
      pegs = pegs.map((peg) => peg.reversed.toList()).toList();
    });
  }

  void _showRoast() {
    final message = _roastMessages[_random.nextInt(_roastMessages.length)];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void checkForCompletion() {
    setState(() {
      isSolved = pegs[2].length == 3 &&
          pegs[2][0] == 3 &&
          pegs[2][1] == 2 &&
          pegs[2][2] == 1;
    });
  }

  void _fakeVictory() {
    setState(() {
      isSolved = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isSolved = false;
        _randomizePegs();
      });
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
      appBar: AppBar(title: const Text("Tower of Annoy - Level 2 (Chaos Edition!)"),backgroundColor: Colors.amber,),
      body: Column(
        children: [
          Text(
            "WARNING: Pegs may randomly shuffle!",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
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
                        image: const DecorationImage(image: AssetImage("assets/images/funny image.png"),fit: BoxFit.cover),
                        border: Border.all(color: Colors.black),
                        color: Colors.red,
                      ),
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
                    );
                  },
                );
              }),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isSolved)
                    Column(
                      children: [
                        Text(
                          "CONGRATULATIONS!",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _fakeVictory,
                          child: Text("YOU WIN"),
                        ),
                      ],
                    ),
                  ElevatedButton(
                    onPressed: isSolved ? null : resetGame,
                    child: Text(isSolved ? "Restart" : "Go",style: TextStyle(color: Colors.amber,fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
