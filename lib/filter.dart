import 'package:flutter/material.dart';
import 'package:flutter_application_99/Getx/EventController.dart';
import 'package:get/get.dart';

class FilterEventsScreen extends StatelessWidget {
  final EventController controllerfillter = Get.put(EventController());
  FilterEventsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final EventController controllerfillter = Get.put(EventController());
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFebe9f2),
                Color(0xFFfaead6),
              ],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          iconSize: 37,
                          onPressed: () {},
                          icon: const Icon(Icons.menu),
                        ),
                        const Text(
                          'GEN-Z ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Arial Rounded MT Bold',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff65625E),
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      iconSize: 37,
                      onPressed: () {},
                      icon: const Icon(Icons.language),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Color(0xff65625E),
                thickness: 2,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: screenHeight * 0.05,
                  right: screenWidth * 0.5,
                ),
                child: const Text(
                  "Filter Events",
                  style: TextStyle(
                      color: Color(0xff65625E),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),

              // Filter Buttons Section
              Container(
                margin: const EdgeInsets.only(right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFilterButton(
                      type: 'Help',
                      iconColor: const Color(0xffE4AB56),
                      icon: Icons.help_outline,
                      btnName: "Help",
                    ),
                    _buildFilterButton(
                      type: 'Education',
                      iconColor: const Color(0xff4584C5),
                      icon: Icons.school,
                      btnName: "Education",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFilterButton(
                      type: 'Technology',
                      iconColor: const Color(0xff97CA4F),
                      icon: Icons.code,
                      btnName: "Technology",
                    ),
                    _buildFilterButton(
                      type: 'Sports',
                      iconColor: const Color(0xffC6986E),
                      icon: Icons.sports_basketball_sharp,
                      btnName: "Sports",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFilterButton(
                      type: 'Health',
                      iconColor: const Color(0xffB978B3),
                      icon: Icons.health_and_safety,
                      btnName: "Health",
                    ),
                    _buildFilterButton(
                      type: 'Entertainment',
                      iconColor: const Color(0xff176824),
                      icon: Icons.grass,
                      btnName: "Entertainment",
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30, left: 30, bottom: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "#News",
                    style: TextStyle(
                      color: Color(0xff676259),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 150,
                child: Obx(() {
                  if (controllerfillter.isLoading.value) {
                    return const CircularProgressIndicator();
                  }

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controllerfillter.orgData2.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: Stack(
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  image: AssetImage('assets/event.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              left: 5,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                color: Colors.black54,
                                child: Text(
                                  controllerfillter.orgData2[index].title,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(
      {required Color iconColor,
      required IconData icon,
      required String btnName,
      required String type}) {
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
          minimumSize: const Size(180, 55),
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
          controllerfillter.fetchEventsFilter(type);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: iconColor,
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            Text(
              btnName,
              style: const TextStyle(
                  color: Color(0xff676259),
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
