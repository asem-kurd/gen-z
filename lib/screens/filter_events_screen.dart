import 'package:flutter/material.dart';
import 'package:gen_z/models/app_bar2.dart';

class FilterEventsScreen extends StatelessWidget {
  const FilterEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const CustomAppBar2(toolbarHeight: 600 * 0.09),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 130, left: 30, bottom: 50),
              child: Text(
                "Filter Events",
                style: TextStyle(color: Color(0xff676259), fontSize: 25),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff5A5D62),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        minimumSize: const Size(
                            200 * 0.5, 300 * 0.06), // Dynamic button size
                      ),
                      onPressed: () {
                        // Add action for volunteering
                      },
                      child: const Text("Volunteer"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff5A5D62),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        minimumSize: const Size(
                            200 * 0.5, 300 * 0.06), // Dynamic button size
                      ),
                      onPressed: () {
                        // Add action for volunteering
                      },
                      child: const Text("Volunteer"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff5A5D62),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        minimumSize: const Size(
                            200 * 0.5, 300 * 0.06), // Dynamic button size
                      ),
                      onPressed: () {
                        // Add action for volunteering
                      },
                      child: const Text("Volunteer"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff5A5D62),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        minimumSize: const Size(
                            200 * 0.5, 300 * 0.06), // Dynamic button size
                      ),
                      onPressed: () {
                        // Add action for volunteering
                      },
                      child: const Text("Volunteer"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff5A5D62),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        minimumSize: const Size(
                            200 * 0.5, 300 * 0.06), // Dynamic button size
                      ),
                      onPressed: () {
                        // Add action for volunteering
                      },
                      child: const Text("Volunteer"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff5A5D62),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        minimumSize: const Size(
                            200 * 0.5, 300 * 0.06), // Dynamic button size
                      ),
                      onPressed: () {
                        // Add action for volunteering
                      },
                      child: const Text("Volunteer"),
                    ),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 50, left: 10, bottom: 50),
              child: Text(
                "#News",
                style: TextStyle(color: Color(0xff676259), fontSize: 25),
              ),
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const Padding(padding: EdgeInsets.only(right: 30)),
                  Stack(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          'assets/imgs/logo.png',
                          height: 200,
                        ),
                      ),
                      const Text(
                        "data",
                        style: TextStyle(color: Colors.black, fontSize: 40),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 250, right: 30)),
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Image.asset(
                        'assets/imgs/logo.png',
                        height: 200,
                      ),
                      const Text(
                        "data",
                        style: TextStyle(color: Colors.black, fontSize: 40),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 250, right: 30)),
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Image.asset(
                        'assets/imgs/logo.png',
                        height: 200,
                      ),
                      const Text(
                        "data",
                        style: TextStyle(color: Colors.black, fontSize: 40),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 250, right: 30)),
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Image.asset(
                        'assets/imgs/logo.png',
                        height: 200,
                      ),
                      const Text(
                        "data",
                        style: TextStyle(color: Colors.black, fontSize: 40),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
