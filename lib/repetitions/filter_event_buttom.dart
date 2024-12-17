import 'package:flutter/material.dart';

class FilterEventsBtn extends StatelessWidget {
  const FilterEventsBtn(
      {super.key,
      required this.iconColor,
      required this.icon,
      required this.btnName});

  final Color iconColor; // Icon parameter in class
  final IconData icon;
  final String btnName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffB4B3B5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(1, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(180, 55), // Fixed size for consistency
          side: const BorderSide(
            color: Color.fromARGB(255, 24, 23, 23),
            width: 1.0,
          ),
          backgroundColor: const Color(0xffdce5e1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: () {
          // Add action for volunteering
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Centers the contents
          children: [
            // Icon in circle
            CircleAvatar(
              radius: 18,
              backgroundColor: iconColor,
              child: Icon(
                icon,
                color: Colors
                    .white, // Ensure icon color is always white for visibility
                size: 20, // Consistent icon size
              ),
            ),
            // Button name, without the SizedBox in between
            Text(
              btnName,
              style:  TextStyle(
                  color: Color(0xff676259),
                  fontSize: 14, // Adjust font size for better visibility
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
