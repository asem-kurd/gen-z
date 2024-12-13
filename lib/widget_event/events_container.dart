import 'package:flutter/material.dart';

class EventContainer extends StatelessWidget {
  final String imgPath;
  final String eventName;
  final String eventTime;

  const EventContainer({
    super.key,
    required this.imgPath,
    required this.eventName,
    required this.eventTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: const Color(0xffDEE1D2),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CircleAvatar(
                radius: 46, // Keep the avatar size fixed
                backgroundImage: AssetImage(imgPath),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                children: [
                  Text(
                    eventName,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3D4349),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                  ),
                  Text(
                    eventTime,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3D4349),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 7)),
                  const Padding(
                    padding: EdgeInsets.only(right: 25, left: 80),
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          color: Color.fromARGB(255, 47, 129, 80),
                          size: 15,
                        ),
                        Text(
                          "Online",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff3D4349),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}