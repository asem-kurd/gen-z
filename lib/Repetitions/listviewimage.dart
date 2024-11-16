import 'package:flutter/material.dart';

class EventImageStack extends StatelessWidget {
  const EventImageStack({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // Fixed height to avoid unbounded error
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15), // Set border radius here
            child: Image.asset(
              'assets/images/Image/Logo.png',
              height: 152,
              width: 314,
              fit: BoxFit
                  .cover, // Ensures the image covers the area with rounded corners
            ),
          ),
        ],
      ),
    );
  }
}
