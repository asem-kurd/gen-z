import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/Getx/EventController.dart';
import 'package:flutter_application_99/Repetitions/appbar.dart';
import 'package:flutter_application_99/Repetitions/grawer__list.dart';
import 'package:flutter_application_99/Repetitions/theme_service.dart';
import 'package:flutter_application_99/filter.dart';
import 'package:flutter_application_99/reg_event_user.dart';
import 'package:flutter_application_99/user_settings.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatelessWidget {
  final EventController eventController = Get.put(EventController());

  // Key for controlling the Scaffold's drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,

      key: _scaffoldKey, // Add the key here to control the scaffold's state
      body: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            width: screenWidth,
            height: screenHeight * 0.25,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(70, 221, 219, 224),
                  Color.fromARGB(47, 104, 102, 98),
                  Color.fromARGB(55, 171, 153, 132),
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
                      child: IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          _scaffoldKey.currentState
                              ?.openDrawer(); // Open the drawer when button is pressed
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.04),
                      child: InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.notifications,
                        ),
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
          //

          Container(
            // change background color depend on theme
            // color:
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "#SpecialForYou",
                    style: TextStyle(
                      fontSize: 18,
                      // color: Theme.of(context).colorScheme.onPrimary,
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
          ),
          // List of Events
          SizedBox(
            width: screenWidth * 0.9,
            height: screenHeight * 0.2,
            child: Obx(() {
              if (eventController.events.isEmpty) {
                return const Center(
                  child: Text('No events at this time.'),
                );
              }
              return ListView.builder(
                itemCount: eventController.events.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final event = eventController.events[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      onTap: () {
                        var eventid = eventController.events
                            .elementAt(index)
                            .eventid
                            .toString();
                        print(eventid);
                        Get.to(const EventDetails(), arguments: eventid);
                      },
                      child: Container(
                        width: screenWidth * 0.8,
                        height: screenHeight * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          // image: DecorationImage(
                          //  // image: NetworkImage(event.imageUrl),
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              color: Colors.grey,
                              child: Text(
                                event.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "#News",
                  style: TextStyle(
                    fontSize: 18,
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
        ],
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'GEN-Z',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial'),
                ),
                const SizedBox(
                  width: 190,
                ),
                GestureDetector(
                  onTap: () {
                    print('Share button pressed');
                  },
                  child: const Icon(
                    Icons.share,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.filter_alt,
                  ),
                  title: const Text('Filter events',
                      style: TextStyle(fontSize: 16)),
                  onTap: () {
                    Get.to(() => FilterEventsScreen()); // Close the drawer
                  },
                ),
                const Divider(thickness: 1, color: Colors.grey),
                // ListTile(
                //   leading: const Icon(
                //     Icons.settings,
                //   ),
                //   title: const Text('Settings', style: TextStyle(fontSize: 16)),
                //   onTap: () {
                //     Get.to(() => UserSettings()); // Close the drawer
                //   },
                // ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                  ),
                  title: const Text('Logout', style: TextStyle(fontSize: 16)),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/CreateUser',
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
