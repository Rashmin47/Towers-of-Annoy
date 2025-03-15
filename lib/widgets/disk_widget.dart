import 'package:flutter/material.dart';

class DiskWidget extends StatelessWidget {
  final int size;

  const DiskWidget({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      width: size * 40.0,
      height: 20.0,
      decoration: BoxDecoration(
        // Red/amber gradient background
        gradient: LinearGradient(
          colors: [
            Colors.red.withOpacity(0.8),
            Colors.amber.withOpacity(0.8),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        // Amber border
        border: Border.all(color: Colors.amber, width: 2),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
    );
  }
}
