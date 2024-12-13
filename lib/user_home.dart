import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/Getx/controllview.dart';
import 'package:flutter_application_99/user_profile.dart';
import 'package:flutter_application_99/view_model/Home_view_model.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            width: screenWidth,
            height: screenHeight * 0.25,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(71, 136, 124, 176),
                  Color.fromARGB(48, 194, 130, 27),
                  Color.fromARGB(55, 251, 134, 0),
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.circular(23),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.04),
                      child: const Text(
                        "GEN-Z",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.04),
                      child: InkWell(
                        onTap: () {}, 
                        child: const Icon(Icons.notifications,
                            color: Color(0xff575a60)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                SizedBox(
                  width: screenWidth * 0.83,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: const TextStyle(color: Color(0xffb2b0ab)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon:
                          const Icon(Icons.search, color: Color(0xff696969)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Special Section
          const Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "#SpecialForYou",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Arial",
                  ),
                ),
                Text(
                  "See All",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(
            width: screenWidth * 0.9,
            height: screenHeight * 0.2,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(), // إلغاء التمرير
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    onTap: () {
                      print("Image pressed");
                    },
                    child: Container(
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                          image: AssetImage(
                              "assets/images/Image/Logo.png"), // Ensure images are added to pubspec.yaml
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    onTap: () {
                      print("Image pressed");
                    },
                    child: Container(
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                          image: AssetImage(
                              "assets/images/Image/Logo.png"), // Ensure images are added to pubspec.yaml
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Upcoming Events Section
          const Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "#Upcoming Events",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Arial",
                  ),
                ),
                Text(
                  "See All",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(
            width: screenWidth * 0.9,
            height: screenHeight * 0.2,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(), // إلغاء التمرير
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    onTap: () {
                      print("Image pressed");
                    },
                    child: Container(
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                          image: AssetImage(
                              "assets/images/Image/Logo.png"), // Ensure images are added to pubspec.yaml
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    onTap: () {
                      print("Image pressed");
                    },
                    child: Container(
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                          image: AssetImage(
                              "assets/images/Image/Logo.png"), // Ensure images are added to pubspec.yaml
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
