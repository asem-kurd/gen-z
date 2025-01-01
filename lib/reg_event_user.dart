import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/controll_home.dart';
import 'package:flutter_application_99/service/event.dart';
import 'package:flutter_application_99/service/firestoreOrg.dart';
import 'package:flutter_application_99/taple_firebase/user_taple.dart';
import 'package:flutter_application_99/view_model/Event_model.dart';
import 'package:flutter_application_99/view_model/org_model.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

import 'package:http/http.dart';
import 'package:rive/rive.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key});

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  late String eventid;
  String title = "Loading..."; // تعيين قيم مبدئية
  String description = "Loading...";
  String startTime = "Loading...";
  String endTime = "Loading...";
  String requiredNumber = "Loading...";
  String orgId = "";
  bool isLoading = true;
  String eventLocation = "Online";

  @override
  void initState() {
    super.initState();
    eventid = Get.arguments as String;
    fetchEventDetails();
  }

  Future<void> fetchEventDetails() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
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
          startTime = doc.data()['start_time']?.toDate().toString() ??
              "Start time not found";
          endTime = doc.data()['end_time']?.toDate().toString() ??
              "End time not found";
          eventLocation =
              doc.data()['eventLocation'] ?? "Online"; // استرجاع eventLocation
          isLoading = false;
        });
      } else {
        setState(() {
          title = "Event not found";
          description = "Event not found";
          requiredNumber = "Event not found";
          startTime = "Event not found";
          endTime = "Event not found";
          eventLocation = "Event not found"; // تعيين القيمة الافتراضية
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        title = "Error fetching event";
        description = "Error fetching event";
        requiredNumber = "Error fetching event";
        startTime = "Error fetching event";
        endTime = "Error fetching event";
        eventLocation = "Error fetching event"; // في حالة حدوث خطأ
        isLoading = false;
      });
    }
  }

  Future<void> deleteEvent() async {
    try {
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;
      if (currentUserId != orgId) {
        Get.snackbar(
          'Error',
          'You are not authorized to delete this event.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
        return;
      }

      await FirebaseFirestore.instance
          .collection('events')
          .doc(eventid)
          .delete();

      Get.snackbar(
        'Success',
        'Event deleted successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
      );

      // الانتقال إلى الصفحة الرئيسية
      Get.to(const controll_home());
    } catch (e) {
      print("Error deleting event: $e");
      Get.snackbar(
        'Error',
        'There was an error deleting the event.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> saveuser() async {
    String userId =
        FirebaseAuth.instance.currentUser!.uid; // معرف المستخدم الحالي

    try {
      // جلب بيانات المستخدم الحالي
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users') // مجموعة المستخدمين
          .doc(userId)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic>? userData =
            userDoc.data() as Map<String, dynamic>?;

        print("User saved successfully.");
      } else {
        print("User not found.");
      }
    } catch (e) {
      print("Error saving user: $e");
      rethrow; // لإظهار الخطأ عند حدوث مشكلة
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
                    const SizedBox(height: 16),
                    isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                            eventLocation,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
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
                    // وصف الحدث
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
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              fixedSize: const Size(85, 40),
                              side: const BorderSide(
                                  color: Color(0xFF586e74), width: 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () async {
                              String userId1 =
                                  FirebaseAuth.instance.currentUser!.uid;
                              try {
                                var eventSnapshot = await FirebaseFirestore
                                    .instance
                                    .collection('Users')
                                    .doc(userId1)
                                    .collection('events')
                                    .doc(eventid)
                                    .get();

                                if (eventSnapshot.exists) {
                                  Get.snackbar(
                                    'Already Registered',
                                    'You have already joined this event.',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                  );
                                } else {
                                  await FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(userId1)
                                      .collection('events')
                                      .doc(eventid)
                                      .set({
                                    'title': title,
                                    'startTime': startTime,
                                    'endTime': endTime,
                                    'description': description,
                                    'eventId': eventid,
                                    'userId': userId1,
                                    'joinedAt': FieldValue.serverTimestamp(),
                                  });

                                  Get.snackbar(
                                    'Success',
                                    'You have successfully joined the event',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.green,
                                  );
                                }
                              } catch (e) {
                                print("Error saving event: $e");
                                Get.snackbar(
                                  'Error',
                                  'There was an error joining the event',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                );
                              }
                              // الانتقال إلى الصفحة الرئيسية
                              Get.to(const controll_home());
                            },
                            child: const Text("Add"),
                          ),
                        ),
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

//
class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // الخلفية المتدرجة
    Paint backgroundPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(size.width * 0.5, 0),
        Offset(size.width * 0.5, size.height),
        [const Color(0xff226579), const Color(0xFF908b92)],
      );
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      backgroundPaint,
    );

    // رسم منحنى مقوس في أسفل الشاشة
    Path curvePath = Path();
    curvePath.moveTo(0, size.height * 0.8); // بدء المسار من أسفل اليسار
    curvePath.quadraticBezierTo(
      size.width * 0.5, // النقطة الوسطى
      size.height, // الارتفاع
      size.width, // النقطة النهائية
      size.height * 0.8, // ارتفاع نهاية المنحنى
    );
    curvePath.lineTo(size.width, size.height); // إغلاق المسار يمينًا
    curvePath.lineTo(0, size.height); // إغلاق المسار يسارًا
    curvePath.close();

    Paint curvePaint = Paint()..color = Colors.white;
    canvas.drawPath(curvePath, curvePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height); // يمتد المسار إلى أسفل الشاشة
    path.lineTo(size.width, size.height); // يمتد إلى عرض الشاشة
    path.lineTo(size.width, 0); // يعود إلى أعلى الشاشة
    path.close(); // يغلق المسار
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

void main() {
  runApp(const EventDetails());
}
