import 'package:flutter/material.dart';

class DiskWidget extends StatelessWidget {
  final int size;

  DiskWidget({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      width: size * 40.0,
      height: 20.0,
      decoration: BoxDecoration(
        color: Colors.blue[size * 100],
        borderRadius: BorderRadius.circular(8),

      ),
    );
  }
}
