import 'package:flutter/material.dart';
import 'package:flutter_application_99/widgets/appbar.dart';
import 'package:flutter_application_99/repetitions/icon_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetching the screen dimensions for responsive design
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: ListView(
            padding: const EdgeInsets.all(16), // Consistent padding
            children: [
              Column(
                children: [
                  const CustomAppBar1(),
                  const CircleAvatar(
                    radius: 70,
                    // backgroundImage: AssetImage("assets/imgs/profile.jpeg"),requiset firebase storage
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Asem Alkurdi",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff5A5D62),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: Size(screenWidth * 0.5, screenHeight * 0.06),
                    ),
                    onPressed: () {},
                    child: const Text("Volunteer"),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    color: const Color(0xffE6F3F3),
                    height: screenHeight * 0.07, // Responsive height
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.map_outlined,
                              size: 25,
                              color: Color(0xff52A8A8),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            const Text(
                              "  Ma'an Station, Ma'an",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 30,
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            const Text(
                              "33 Points",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ), //getbuilder()
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Hours and Requests
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Color(0xFFebe9f2),
                      Color(0xFFfaead6),
                    ])),
                    height: screenHeight * 0.1, // Responsive height
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const FittedBox(
                          fit: BoxFit
                              .scaleDown, // Adjust text based on available space
                          child: Text(
                            "Hours Completed: 03\nRequests: 00",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
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

                  SizedBox(
                      height:
                          screenHeight * 0.02), // Space before the card section
                  const Text("Completed Activity",
                      style: TextStyle(fontSize: 30)),
                  const SizedBox(height: 50), // Space before the card section

                  // Horizontally Scrollable Cards
                  SizedBox(
                    height:
                        screenHeight * 0.3, // Adjust card height dynamically
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal, // Horizontal scrolling
                      itemCount: 5, //هون لازم counter يستقبله من فير بيس
                      itemBuilder: (context, index) {
                        return Container(
                          width: screenWidth * 0.5, // Responsive card width
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Color(0xFFebe9f2),
                              Color(0xFFfaead6),
                            ]),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 55, // Keep the avatar size fixed
                                // backgroundImage:
                                //      AssetImage("assets/imgs/logo.png"),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Org name',
                                style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.04,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  // قم بوضع الكود الخاص بك هنا
                                },
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      EdgeInsets.zero, // إزالة الحشوة تمامًا
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  splashFactory: NoSplash
                                      .splashFactory, // لإزالة تأثير الضغط
                                  shadowColor: Colors.transparent,
                                  elevation: 0,
                                  backgroundColor: Colors
                                      .transparent, // إزالة الخلفية الافتراضية
                                ),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFebe9f2),
                                        Color(0xFFfaead6),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      minWidth: 150,
                                      minHeight: 50,
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Volunteer Certificate",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
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
          bottomNavigationBar: const CustomBottomAppBar(),
        ),
      ),
    );
  }
}
