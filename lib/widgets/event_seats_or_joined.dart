import 'package:flutter/material.dart';

class EventSeatsOrJoined extends StatelessWidget {
  final int number;
  final String name;
  const EventSeatsOrJoined({
    super.key,
    required this.number,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(fontSize: screenWidth * 0.035),
        ),
        SizedBox(height: screenHeight * 0.02),
        Container(
          width: screenWidth * 0.15,
          height: screenWidth * 0.15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
