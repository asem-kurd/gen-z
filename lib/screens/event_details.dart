import 'package:flutter/material.dart';
import 'package:flutter_application_99/widgets/event_seats_or_joined.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.all(screenWidth * 0.04), // Adjust padding dynamically
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      // Implement back button functionality
                    },
                  ),
                  actions: const [],
                ),
                Text(
                  'Smart Writer',
                  style: TextStyle(
                    fontSize: screenWidth * 0.08, // Responsive font size
                  ),
                ),
                SizedBox(height: screenHeight * 0.01), // Dynamic spacing
                Row(
                  children: [
                    Text(
                      'Avaliable',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: screenWidth * 0.04, // Responsive font size
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.06), // Dynamic spacing
                Text(
                  'Participation Hours: 4',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045, // Responsive font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01), // Dynamic spacing
                Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff989A9D),
                      width: 2,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: screenWidth * 0.01,
                        blurRadius: screenWidth * 0.02,
                        offset: Offset(0, screenHeight * 0.005),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.06),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_today),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              'Sun, 12 Sep',
                              style: TextStyle(fontSize: screenWidth * 0.04),
                            ),
                            SizedBox(width: screenWidth * 0.04),
                            const Icon(Icons.access_time),
                            Text(
                              '13:00 to 15:00 PM',
                              style: TextStyle(fontSize: screenWidth * 0.04),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              'Sun, 13 Sep',
                              style: TextStyle(fontSize: screenWidth * 0.04),
                            ),
                            SizedBox(width: screenWidth * 0.04),
                            const Icon(Icons.access_time),
                            Text(
                              '13:00 to 15:00 PM',
                              style: TextStyle(fontSize: screenWidth * 0.04),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Dynamic spacing
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045, // Responsive font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01), // Dynamic spacing
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff989A9D),
                      width: 2,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: screenWidth * 0.01,
                        blurRadius: screenWidth * 0.02,
                        offset: Offset(0, screenHeight * 0.005),
                      ),
                    ],
                  ),
                  height: screenHeight * 0.15, // Responsive height
                  width: screenWidth * 0.9, // Responsive width
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.06),
                    child: const Text(
                      "details kjfkjfldsfdsfdsfdfdsafdsfdsfdsfdsfdsfsdfdsfsdfdsafasd",
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04), // Dynamic spacing
                // ignore: prefer_const_constructors
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    EventSeatsOrJoined(
                      name: "Avaliable Seats",
                      number: 60,
                    ),
                    EventSeatsOrJoined(
                      name: "Joined",
                      number: 60,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.015), // Dynamic spacing
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xff5A5D62),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                      minimumSize: Size(
                        screenWidth * 0.3, // Dynamic button width
                        screenHeight * 0.05, // Dynamic button height
                      ),
                    ),
                    onPressed: () {
                      // Add hours or requests action
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(fontSize: screenWidth * 0.045),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
