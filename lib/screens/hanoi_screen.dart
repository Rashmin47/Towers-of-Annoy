import 'package:flutter/material.dart';
import '../widgets/disk_widget.dart';

class HanoiScreen extends StatefulWidget {
  const HanoiScreen({super.key});

  @override
  _HanoiScreenState createState() => _HanoiScreenState();
}

class _HanoiScreenState extends State<HanoiScreen> {
  List<List<int>> pegs = [
    [3, 2, 1], // Peg A (Starting)
    [], // Peg B
    [] // Peg C (Goal)
  ];

  void moveDisk(int from, int to) {
    if (pegs[from].isNotEmpty &&
        (pegs[to].isEmpty || pegs[from].last < pegs[to].last)) {
      setState(() {
        pegs[to].add(pegs[from].removeLast());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tower of Annoy - Level 1")),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(3, (pegIndex) {
          return DragTarget<int>(
            onAccept: (fromPeg) => moveDisk(fromPeg, pegIndex),
            builder: (context, candidateData, rejectedData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: pegs[pegIndex]
                    .map((disk) => Draggable<int>(
                  data: pegIndex,
                  feedback: DiskWidget(size: disk),
                  child: DiskWidget(size: disk),
                ))
                    .toList(),
              );
            },
          );
        }),
      ),
    );
  }
}
