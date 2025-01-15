import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/controll_home.dart';
import 'package:flutter_application_99/service/event.dart';
import 'package:flutter_application_99/taple_firebase/user_taple.dart';
import 'package:flutter_application_99/view_model/Event_model.dart';
import 'package:flutter_application_99/widget_Org/control_home.dart';
import 'package:flutter_application_99/widget_Org/updata.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

import 'package:http/http.dart';
import 'package:rive/rive.dart';

class Smartorg extends StatefulWidget {
  const Smartorg({super.key});

  @override
  _Smartorg createState() => _Smartorg();
}

class _Smartorg extends State<Smartorg> {
  late String eventid;
  String title = "Loading...";
  String description = "Loading...";
  String startTime = "Loading...";
  String endTime = "Loading...";
  String requiredNumber = "Loading...";
  String orgId = "";
  bool isLoading = true;
  List<Map<String, dynamic>> events = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    eventid = Get.arguments as String;
    fetchEventDetails();
  }

  Future<void> fetchEventDetails() async {
    try {
      final querySnapshot = await _firestore
          .collection('events')
          .where('eventid', isEqualTo: eventid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var doc = querySnapshot.docs.first;
        setState(() {
          title = doc.data()['title'] ?? "Title not found";
          description = doc.data()['description'] ?? "Description not found";
          requiredNumber = doc.data()['required_number']?.toString() ??
              "Required number not found";
          startTime =
              (doc.data()['start_time'] as Timestamp?)?.toDate().toString() ??
                  "Start time not found";
          endTime =
              (doc.data()['end_time'] as Timestamp?)?.toDate().toString() ??
                  "End time not found";
          isLoading = false;
        });
      } else {
        setState(() {
          title = "Event not found";
          description = "Event not found";
          requiredNumber = "Event not found";
          startTime = "Event not found";
          endTime = "Event not found";
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching event details: $e");
    }
  }

  Future<void> deleteEventByEventId(String eventId) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        String uid = currentUser.uid;

        var eventSnapshot = await _firestore
            .collection('events')
            .where('eventid', isEqualTo: eventId)
            .get();

        if (eventSnapshot.docs.isNotEmpty) {
          var eventDoc = eventSnapshot.docs.first;
          await _firestore.collection('events').doc(eventDoc.id).delete();
          var orgEventSnapshot = await _firestore
              .collection('Orgnaization')
              .doc(currentUser.uid)
              .get(); // الحصول على مستند المنظمة

          if (orgEventSnapshot.exists) {
            var orgEventDoc = orgEventSnapshot.data()?['My_Events'] ??
                {}; // الوصول إلى الـ Map داخل المستند

            if (orgEventDoc.containsKey(eventDoc.id)) {
              await _firestore
                  .collection('Orgnaization')
                  .doc(currentUser.uid)
                  .update({
                'My_Events.${eventDoc.id}':
                    FieldValue.delete() // حذف الحدث من الـ Map
              });
            }
          }
          Get.snackbar("Success", "Event deleted successfully");
        } else {
          print("Event not found");
          Get.snackbar("Error", "Event not found");
        }
      }
      Get.back();
    } catch (e) {
      print("Error deleting event: $e");
      setState(() {
        title = "Error deleting event";
        description = "Error deleting event";
        requiredNumber = "Error deleting event";
        startTime = "Error deleting event";
        endTime = "Error deleting event";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(70),
                        bottomRight: Radius.circular(10)),
                    child: Container(
                      width: double.infinity,
                      height: screenHeight * 0.35,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/Image/finger maker.png',
                          ),
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.05,
                    left: 20,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.25,
                    left: 20,
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : AutoSizeText(
                            title,
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            minFontSize: 20,
                          ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.calendar_today_outlined),
                              const SizedBox(width: 4),
                              Text(startTime,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 4),
                              const Icon(Icons.access_time),
                              Text(endTime,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    isLoading
                        ? const CircularProgressIndicator()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Description',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  description,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text('Required number'),
                            const SizedBox(height: 8),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey[300],
                              child: Text(
                                requiredNumber,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Under approval'),
                            const SizedBox(height: 8),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey[300],
                              child: const Text(
                                '15',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 75),
                    if (!isLoading)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(Updataevent(), arguments: eventid);
                                print(eventid);
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                splashFactory: NoSplash.splashFactory,
                                shadowColor: Colors.transparent,
                                elevation: 0,
                                backgroundColor: Color(0xFFb1b3b5),
                              ),
                              child: Container(
                                constraints: const BoxConstraints(
                                    minWidth: 140, minHeight: 40),
                                alignment: Alignment.center,
                                child: const Text(
                                  "Updata Event",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily:
                                        'Arial', // تم تصحيح اسم عائلة الخط
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                deleteEventByEventId(eventid);
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                splashFactory: NoSplash.splashFactory,
                                shadowColor: Colors.transparent,
                                elevation: 0,
                                backgroundColor: Color(0xFFb1b3b5),
                              ),
                              child: Container(
                                constraints: const BoxConstraints(
                                    minWidth: 130, minHeight: 40),
                                alignment: Alignment.center,
                                child: const Text(
                                  "Delete Event",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily:
                                        'Arial', // تم تصحيح اسم عائلة الخط
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
