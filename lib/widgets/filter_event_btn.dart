import 'package:flutter/material.dart';

class FilterEventsBtn extends StatelessWidget {
  final Color iconColor; // Icon parameter in class
  final IconData icon;
  final String btnName;

  const FilterEventsBtn(
      {super.key,
      required this.iconColor,
      required this.icon,
      required this.btnName});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.02),
      child: ElevatedButton.icon(
        onPressed: () {},
        label: Text(
          btnName,
          style: const TextStyle(
              color: Color(0xff676259),
              fontSize: 15, // Adjust font size for better visibility
              fontWeight: FontWeight.bold),
        ),
        icon: CircleAvatar(
          radius: 17,
          backgroundColor: iconColor,
          child: Icon(
            icon,
            color: Colors
                .white, // Ensure icon color is always white for visibility
            size: 20, // Consistent icon size
          ),
        ),
        style: ElevatedButton.styleFrom(
          shadowColor: const Color(0xffB4B3B5),
          elevation: 5,
          fixedSize: Size(
            screenWidth * 0.415,
            screenHeight * 0.07,
          ), // Fixed size for consistency
          side: const BorderSide(
            color: Color.fromARGB(255, 24, 23, 23),
            width: 1.0,
          ),
          backgroundColor: const Color(0xffdce5e1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
