import 'package:flutter/material.dart';

class FilterEventsBtn extends StatelessWidget {
  const FilterEventsBtn(
      {super.key,
      required this.iconColor,
      required this.icon,
      required this.btnName});
  final Color iconColor;
  // Icon parameter in class
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
          minimumSize: const Size(160, 60),
          side: const BorderSide(
            color: Color.fromARGB(255, 24, 23, 23),
            width: 1.0,
          ),
          backgroundColor: const Color(0xffDDDBCF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: () {
          // Add action for volunteering
        },
        child: Row(
          children: [
            // icon in cercle
            CircleAvatar(
              radius: 13,
              backgroundColor: iconColor,
              child: CircleAvatar(
                backgroundColor: const Color(0xffDDDBCF),
                radius: 20,
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 25,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              btnName,
              style: const TextStyle(
                  color: Color(0xff676259),
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
