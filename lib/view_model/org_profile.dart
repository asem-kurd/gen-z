import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/Getx/EventController.dart';
import 'package:flutter_application_99/Repetitions/smart.dart';
import 'package:flutter_application_99/Repetitions/theme_service.dart';
import 'package:get/get.dart';

class OrgProfile extends StatefulWidget {
  final String userId;
  const OrgProfile({super.key, required this.userId});

  @override
  State<OrgProfile> createState() => _OrgProfileState();
}

class _OrgProfileState extends State<OrgProfile> {
  final EventController controller = Get.put(EventController());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    controller.fetchEventsForUser(widget.userId);
    controller.fetchOrganizationData(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        body: Obx(() {
          var orgDataList = controller.orgData.value.toList();
          if (orgDataList.isEmpty) {
            return const Center(
              child: Text('No Organization at this time.'),
            );
          }
          final Myevent = orgDataList.first;

          return RefreshIndicator(
            onRefresh: () async {
              controller.fetchEventsForUser(widget.userId);
              controller.fetchOrganizationData(widget.userId);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.05, left: screenWidth * 0.05),
                        child: IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.05,
                            right: screenWidth * 0.05),
                        child: InkWell(
                          onTap: () {},
                          child: const Icon(Icons.notifications,
                              color: Color(0xff575a60)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.05),
                        child: const CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage(
                              'assets/images/Image/Polygon 1.png'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Text(
                                Myevent.name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.phone),
                                  const SizedBox(width: 4),
                                  Text(
                                    Myevent.phone.toString(),
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Row(
                                children: [
                                  Icon(Icons.location_pin),
                                  SizedBox(width: 4),
                                  Text('Ma,an'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(thickness: 1, color: Colors.grey),
                  const SizedBox(height: 10),
                  Obx(() {
                    if (controller.orgData2.isEmpty) {
                      return const Center(child: Text("No events available"));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.orgData2.length,
                      itemBuilder: (context, index) {
                        final eventorg = controller.orgData2[index];
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xffdde5ec),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              var eventid =
                                  controller.orgData2[index].eventid.toString();
                              print(eventid);
                              Get.to(const Smartorg(), arguments: eventid);
                            },
                            child: Container(
                              height: screenHeight * 0.15,
                              width: screenWidth * 0.9,
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 45,
                                    backgroundImage: AssetImage(
                                        'assets/images/Image/Logo.png'),
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        eventorg.title,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2A2A2A),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Colors.blue,
                                            child: Icon(
                                              Icons.phone,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            eventorg.phone.toString(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF78797d),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          );
        }),
        drawer: Drawer(
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'GEN-Z',
                    style: TextStyle(
                        color: Color(0xFF42454b),
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
                    child: const Image(
                      image: AssetImage('assets/images/Image/share.png'),
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
                    leading: Image.asset('assets/images/Image/Icon (3).png'),
                    title: const Text('Profile',
                        style:
                            TextStyle(color: Color(0xFF1B1F26), fontSize: 16)),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                    },
                  ),
                  ListTile(
                    leading: Image.asset('assets/images/Image/Icon (4).png'),
                    title: const Text('Home',
                        style:
                            TextStyle(color: Color(0xFF1B1F26), fontSize: 16)),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                    },
                  ),
                  ListTile(
                    leading:
                        Image.asset('assets/images/Image/Date_fill@3x.png'),
                    title: const Text('Events',
                        style:
                            TextStyle(color: Color(0xFF1B1F26), fontSize: 16)),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                    },
                  ),
                  ListTile(
                    leading:
                        Image.asset('assets/images/Image/server-02 (1).png'),
                    title: const Text('Organization',
                        style:
                            TextStyle(color: Color(0xFF1B1F26), fontSize: 16)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Image.asset('assets/images/Image/globe-01.png'),
                    title: const Text('DarkMode',
                        style:
                            TextStyle(color: Color(0xFF1B1F26), fontSize: 16)),
                    onTap: () {
                      ThemeService().changeTheme();
                    },
                  ),
                  ListTile(
                    leading: Image.asset('assets/images/Image/Filter.png'),
                    title: const Text('Filter events',
                        style:
                            TextStyle(color: Color(0xFF1B1F26), fontSize: 16)),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                    },
                  ),
                  const Divider(thickness: 1, color: Colors.grey),
                  ListTile(
                    leading: Image.asset('assets/images/Image/Icon (1).png'),
                    title: const Text('Settings',
                        style:
                            TextStyle(color: Color(0xFF1B1F26), fontSize: 16)),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                    },
                  ),
                  ListTile(
                    leading: Image.asset('assets/images/Image/Icon (2).png'),
                    title: const Text('Logout',
                        style:
                            TextStyle(color: Color(0xFF1B1F26), fontSize: 16)),
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
      ),
    );
  }
}
