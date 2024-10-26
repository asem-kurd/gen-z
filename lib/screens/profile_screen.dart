import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetching the screen dimensions for responsive design
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: screenHeight * 0.12, // Responsive toolbar height
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                size: 40,
              ),
              tooltip: 'Open Menu',
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.language,
                  size: 40,
                ),
                tooltip: 'Change Language',
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16), // Consistent padding
            children: [
              Column(
                children: [
                  // Profile Picture and Name
                  const CircleAvatar(
                    radius: 80, // Keep the avatar size fixed
                    backgroundImage: AssetImage("assets/imgs/logo.png"),
                  ),
                  const SizedBox(height: 16), // Space between image and text
                  const FittedBox(
                    fit: BoxFit
                        .scaleDown, // Ensures text scales based on the screen size
                    child: Text(
                      "Asem Alkurdi",
                      style: TextStyle(
                        fontSize: 30, // Scales dynamically on different screens
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16), // Space between text and button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff5A5D62),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: Size(screenWidth * 0.5,
                          screenHeight * 0.06), // Dynamic button size
                    ),
                    onPressed: () {
                      // Add action for volunteering
                    },
                    child: const Text("Volunteer"),
                  ),
                  const SizedBox(
                      height: 50), // Added space before the next section
                  // Location and Points
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    color: const Color(0xffE6F3F3),
                    height: screenHeight * 0.07, // Responsive height
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.map_outlined,
                              size: 25,
                              color: Color(0xff52A8A8),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Ma'an Station, Ma'an",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 30,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "33 Points",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20), // Space between sections

                  // Hours and Requests
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    color: const Color(0xffFEE9D1),
                    height: screenHeight * 0.1, // Responsive height
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const FittedBox(
                          fit: BoxFit
                              .scaleDown, // Adjust text based on available space
                          child: Text(
                            "Hours Completed: 03\nRequests: 00",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff5A5D62),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            minimumSize: Size(screenWidth * 0.3,
                                screenHeight * 0.05), // Dynamic button size
                          ),
                          onPressed: () {
                            // Add hours or requests action
                          },
                          child: const Text("Add"),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50), // Space before the card section
                  const Text("Completed Activity",
                      style: TextStyle(fontSize: 30)),
                  const SizedBox(height: 50), // Space before the card section

                  // Horizontally Scrollable Cards
                  SizedBox(
                    height:
                        screenHeight * 0.25, // Adjust card height dynamically
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal, // Horizontal scrolling
                      itemCount: 5, // Number of cards
                      itemBuilder: (context, index) {
                        return Container(
                          width: screenWidth * 0.5, // Responsive card width
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 30, // Keep the avatar size fixed
                                backgroundImage:
                                    AssetImage("assets/imgs/logo.png"),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Org name',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  // Action for each card button
                                },
                                child: const Text(
                                  "Volunteer Certificate",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Footer Section
          bottomNavigationBar: BottomAppBar(
            color: const Color(0xffEBE9F2), // Background color for the footer
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Home button or other icons can go here
                  IconButton(
                    icon: const Icon(Icons.home_outlined,
                        size: 30, color: Color(0xff5A5D62)),
                    onPressed: () {
                      // Navigate to home screen or other action
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.event, color: Color(0xff5A5D62)),
                    onPressed: () {
                      // Navigate to home screen or other action
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.build_outlined,
                        color: Color(0xff5A5D62)),
                    onPressed: () {
                      // Navigate to home screen or other action
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.person_2_outlined,
                        color: Color(0xff5A5D62)),
                    onPressed: () {
                      // Navigate to home screen or other action
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
