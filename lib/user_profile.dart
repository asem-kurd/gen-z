import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/Repetitions/appbarmenu.dart';
import 'package:flutter_application_99/user_settings.dart';
import 'package:get/get.dart';
import 'package:flutter_application_99/Repetitions/theme_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _imageUrl;
  var titles = <String>[].obs;
  final RxInt selectedIndex = (-1).obs;
  String? name;

  List<Map<String, dynamic>> events = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> fetchUserData() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        String uid = currentUser.uid;
        DocumentSnapshot userDoc =
            await _firestore.collection('Users').doc(uid).get();
        if (userDoc.exists) {
          setState(() {
            name = userDoc['name'] as String?;
          });
        }
      } else {
        print("No user is currently logged in.");
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> fetchEventsData() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        String uid = currentUser.uid;
        QuerySnapshot eventDocs = await _firestore
            .collection('Users')
            .doc(uid)
            .collection('events')
            .get();
        titles.value =
            eventDocs.docs.map((doc) => doc['title'] as String).toList();
        events = eventDocs.docs.map((doc) {
          return {'id': doc.id, 'title': doc['title']};
        }).toList();
      }
    } catch (e) {
      print("Error fetching events data: $e");
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        String uid = currentUser.uid;
        await _firestore
            .collection('Users')
            .doc(uid)
            .collection('events')
            .doc(eventId)
            .delete();

        setState(() {
          titles.removeWhere((title) =>
              events.firstWhere((event) => event['id'] == eventId)['title'] ==
              title);
          events.removeWhere((event) => event['id'] == eventId);
        });

        fetchEventsData();
      }
    } catch (e) {
      print("Error deleting event: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchEventsData();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final iconColor = theme.colorScheme.onSurface;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            leading: IconButton(
              icon: Icon(
                Icons.settings,
                color: iconColor,
              ),
              onPressed: () {
                Get.to(() => UserSettings());
              },
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Column(
                children: [
                  // CustomAppBar1(),
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      name ?? "User Name",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 50),
                  Container(
                    width: double.infinity,
                    color: theme.colorScheme.surface,
                    height: screenHeight * 0.07,
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
                            Text(
                              "  Ma’an Station, Ma’an",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: textColor,
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
                            Text(
                              "33 Points",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 13),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface, // لون الخلفية
                          borderRadius: BorderRadius.circular(15), // زاوية الزر
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.1), // تأثير الظل
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3), // اتجاه الظل
                            ),
                          ],
                        ),
                        child: Text(
                          'Registered Events',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  SizedBox(
                    height: screenHeight * 0.25,
                    child: Obx(
                      () {
                        if (titles.isEmpty) {
                          return Center(
                            child: AnimatedOpacity(
                              opacity: 1.0,
                              duration: const Duration(seconds: 1),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.warning_amber_outlined,
                                    size: 40,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "No events available.",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: titles.length,
                          itemBuilder: (context, index) {
                            return Container(
                                // ... rest of the item code
                                );
                          },
                        );
                      },
                    ),
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
