// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_99/Getx/EventController.dart';
// import 'package:get/get.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   EventController controller = Get.put(EventController());
//   String? _imageUrl;
//   var titles = <String>[].obs;
//   final RxInt selectedIndex = (-1).obs;
//   String? name;

//   List<Map<String, dynamic>> events = [];

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // دالة جلب بيانات المستخدم
//   Future<void> fetchUserData() async {
//     try {
//       User? currentUser = _auth.currentUser;
//       if (currentUser != null) {
//         String uid = currentUser.uid;
//         DocumentSnapshot userDoc =
//             await _firestore.collection('Users').doc(uid).get();
//         if (userDoc.exists) {
//           setState(() {
//             name = userDoc['name'] as String?;
//           });
//         }
//       } else {
//         print("No user is currently logged in.");
//       }
//     } catch (e) {
//       print('Error fetching user data: $e');
//     }
//   }

//   Future<void> fetchEventsData() async {
//     try {
//       User? currentUser = _auth.currentUser;
//       if (currentUser != null) {
//         String uid = currentUser.uid;
//         QuerySnapshot eventDocs = await _firestore
//             .collection('Users')
//             .doc(uid)
//             .collection('events')
//             .get();
//         titles.value =
//             eventDocs.docs.map((doc) => doc['title'] as String).toList();
//         events = eventDocs.docs.map((doc) {
//           return {'id': doc.id, 'title': doc['title']};
//         }).toList();
//       }
//     } catch (e) {
//       print("Error fetching events data: $e");
//     }
//   }

//   Future<void> deleteEvent(String eventId) async {
//     try {
//       User? currentUser = _auth.currentUser;
//       if (currentUser != null) {
//         String uid = currentUser.uid;

//         // حذف الحدث من مجموعة المستخدم
//         DocumentReference userEventDoc = _firestore
//             .collection('Users')
//             .doc(uid)
//             .collection('events')
//             .doc(eventId);

//         var userEventSnapshot = await userEventDoc.get();
//         if (userEventSnapshot.exists) {
//           // حذف الحدث من مجموعة المستخدم
//           await userEventDoc.delete();

//           setState(() {
//             titles.removeWhere((title) =>
//                 events.firstWhere((event) => event['id'] == eventId)['title'] ==
//                 title);
//             events.removeWhere((event) => event['id'] == eventId);
//           });

//           // تحديث مجموعة الأحداث العامة
//           final querySnapshot = await FirebaseFirestore.instance
//               .collection('events') // تعديل حسب الهيكل
//               .where('eventid', isEqualTo: eventId)
//               .get();

//           if (querySnapshot.docs.isNotEmpty) {
//             for (var doc in querySnapshot.docs) {
//               await doc.reference.update({
//                 'registerd_user_reg':
//                     (doc.data()['registerd_user_reg'] ?? 0) > 0
//                         ? (doc.data()['registerd_user_reg'] ?? 0) - 1
//                         : 0, // التأكد من أن القيمة لا تصبح سالبة
//                 'registered_users_list': FieldValue.arrayRemove([uid]),
//               });
//             }
//           } else {
//             print("No documents found with eventid equal to $eventId");
//           }

//           fetchEventsData();
//           print("Event deleted successfully.");
//         } else {
//           print("Event not found for this user.");
//         }
//       }
//     } catch (e) {
//       print("Error deleting event: $e");
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//     fetchEventsData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SafeArea(
//         child: Scaffold(
//           body: ListView(
//             padding: const EdgeInsets.all(16),
//             children: [
//               Column(
//                 children: [
//                   // الصورة الشخصية
//                   SizedBox(height: screenHeight * 0.02),
//                   FittedBox(
//                     fit: BoxFit.scaleDown,
//                     child: Text(
//                       name ?? "User Name",
//                       style: const TextStyle(
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xff5A5D62),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       minimumSize: Size(screenWidth * 0.5, screenHeight * 0.06),
//                     ),
//                     onPressed: () {},
//                     child: const Text("Volunteer"),
//                   ),
//                   const SizedBox(height: 50),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     color: const Color(0xffE6F3F3),
//                     height: screenHeight * 0.07,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             const Icon(
//                               Icons.map_outlined,
//                               size: 25,
//                               color: Color(0xff52A8A8),
//                             ),
//                             SizedBox(width: screenWidth * 0.02),
//                             const Text(
//                               "  Ma’an Station, Ma’an",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             const Icon(
//                               Icons.star,
//                               color: Colors.amber,
//                               size: 30,
//                             ),
//                             SizedBox(width: screenWidth * 0.02),
//                             const Text(
//                               "33 Points",
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: screenHeight * 0.02),
//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 13),
//                         decoration: BoxDecoration(
//                           color: Colors.grey, // لون الخلفية
//                           borderRadius: BorderRadius.circular(15), // زاوية الزر
//                           boxShadow: [
//                             BoxShadow(
//                               color:
//                                   Colors.black.withOpacity(0.1), // تأثير الظل
//                               spreadRadius: 2,
//                               blurRadius: 5,
//                               offset: const Offset(0, 3), // اتجاه الظل
//                             ),
//                           ],
//                         ),
//                         child: const Text(
//                           'Registered Events',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   SizedBox(
//                     height: screenHeight * 0.25,
//                     child: Obx(
//                       () {
//                         if (titles.isEmpty) {
//                           return Center(
//                             child: AnimatedOpacity(
//                               opacity: titles.isEmpty ? 1.0 : 0.0,
//                               duration: const Duration(seconds: 1),
//                               child: const Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(
//                                     Icons.warning_amber_outlined,
//                                     size: 40,
//                                     color: Colors.red,
//                                   ),
//                                   SizedBox(height: 10),
//                                   Text(
//                                     "No events available.",
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }
//                         return ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: titles.length,
//                           itemBuilder: (context, index) {
//                             bool isSelected = selectedIndex.value == index;
//                             return GestureDetector(
//                               onTap: () {
//                                 selectedIndex.value = isSelected ? -1 : index;
//                               },
//                               child: AnimatedContainer(
//                                 duration: const Duration(milliseconds: 300),
//                                 margin:
//                                     const EdgeInsets.symmetric(horizontal: 8),
//                                 width: isSelected
//                                     ? screenWidth * 0.6
//                                     : screenWidth * 0.5,
//                                 decoration: BoxDecoration(
//                                   gradient: const LinearGradient(
//                                     colors: [
//                                       Color(0xFFebe9f2),
//                                       Color(0xFFfaead6),
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(40),
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const CircleAvatar(
//                                       radius: 55,
//                                     ),
//                                     const SizedBox(height: 10),
//                                     Text(
//                                       titles[index],
//                                       style: const TextStyle(
//                                         fontFamily: 'Arial',
//                                         fontSize: 17,
//                                         fontWeight: FontWeight.w700,
//                                         letterSpacing: -0.04,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 10),
//                                     ElevatedButton(
//                                       onPressed: () {
//                                         String eventId = events[index]['id'];
//                                         deleteEvent(eventId);

//                                         Get.snackbar(
//                                           'Successful Delete',
//                                           'Completed delete this event',
//                                           snackPosition: SnackPosition.BOTTOM,
//                                           backgroundColor: Colors.green,
//                                           colorText: Colors.white,
//                                           borderRadius: 20,
//                                           margin: const EdgeInsets.all(15),
//                                           padding: const EdgeInsets.symmetric(
//                                               vertical: 15, horizontal: 25),
//                                           boxShadows: [
//                                             BoxShadow(
//                                               color:
//                                                   Colors.black.withOpacity(0.1),
//                                               blurRadius: 10,
//                                               spreadRadius: 2,
//                                               offset: const Offset(0, 4),
//                                             ),
//                                           ],
//                                           duration: const Duration(seconds: 3),
//                                           animationDuration:
//                                               const Duration(milliseconds: 400),
//                                           isDismissible: true,
//                                           onTap: (snack) {
//                                             print("Snackbar tapped");
//                                           },
//                                           // Customizing the title text
//                                           titleText: AnimatedContainer(
//                                             duration: const Duration(
//                                                 milliseconds: 300),
//                                             curve: Curves.easeIn,
//                                             child: const Text(
//                                               'Successful Delete',
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 18,
//                                                 fontFamily: 'Arial',
//                                                 color: Colors.white,
//                                               ),
//                                             ),
//                                           ),
//                                           messageText: AnimatedContainer(
//                                             duration: const Duration(
//                                                 milliseconds: 300),
//                                             curve: Curves.easeOut,
//                                             child: const Text(
//                                               'Completed delete this event',
//                                               style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontFamily: 'Arial',
//                                                 color: Colors.white,
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                         padding: EdgeInsets.zero,
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(40),
//                                         ),
//                                         splashFactory: NoSplash.splashFactory,
//                                         shadowColor: Colors.transparent,
//                                         elevation: 0,
//                                         backgroundColor: Colors.transparent,
//                                       ),
//                                       child: Ink(
//                                         decoration: BoxDecoration(
//                                           gradient: const LinearGradient(
//                                             colors: [
//                                               Color(0xFFebe9f2),
//                                               Color(0xFFfaead6),
//                                             ],
//                                           ),
//                                           borderRadius:
//                                               BorderRadius.circular(40),
//                                         ),
//                                         child: Container(
//                                           constraints: const BoxConstraints(
//                                               minWidth: 150, minHeight: 50),
//                                           alignment: Alignment.center,
//                                           child: const Text(
//                                             "Delete Event",
//                                             style:
//                                                 TextStyle(color: Colors.black),
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



















import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String img_path = "assets/images/avatar/male.png"; // Default to male image
  var titles = <String>[].obs;
  final RxInt selectedIndex = (-1).obs;
  String? name;

  List<Map<String, dynamic>> events = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Focus node for managing input focus
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchEventsData();
    fetchUserGender();
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Dispose the focus node
    super.dispose();
  }

  // Fetch user data
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

  // Fetch events data
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

  // Fetch user gender and set image path
  Future<void> fetchUserGender() async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) return;

      final String uid = currentUser.uid;
      final DocumentSnapshot userDoc =
          await _firestore.collection('Users').doc(uid).get();

      if (userDoc.exists) {
        final String? gender = userDoc['gender'] as String?;
        setState(() {
          img_path = gender == "Male"
              ? 'assets/images/avatar/male.png'
              : 'assets/images/avatar/female.png';
        });
      } else {
        print("User document not found.");
        setState(() {
          img_path = 'assets/images/avatar/male.png'; // Default to male image
        });
      }
    } catch (e) {
      print('Error fetching user gender: $e');
      setState(() {
        img_path = 'assets/images/avatar/male.png'; // Default to male image
      });
    }
  }

  // Delete an event
  Future<void> deleteEvent(String eventId) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        String uid = currentUser.uid;

        // Delete the event from the user's collection
        DocumentReference userEventDoc = _firestore
            .collection('Users')
            .doc(uid)
            .collection('events')
            .doc(eventId);

        var userEventSnapshot = await userEventDoc.get();
        if (userEventSnapshot.exists) {
          await userEventDoc.delete();

          setState(() {
            titles.removeWhere((title) =>
                events.firstWhere((event) => event['id'] == eventId)['title'] ==
                title);
            events.removeWhere((event) => event['id'] == eventId);
          });

          // Update the general events collection
          final querySnapshot = await FirebaseFirestore.instance
              .collection('events')
              .where('eventid', isEqualTo: eventId)
              .get();

          if (querySnapshot.docs.isNotEmpty) {
            for (var doc in querySnapshot.docs) {
              await doc.reference.update({
                'registerd_user_reg':
                    (doc.data()['registerd_user_reg'] ?? 0) > 0
                        ? (doc.data()['registerd_user_reg'] ?? 0) - 1
                        : 0,
                'registered_users_list': FieldValue.arrayRemove([uid]),
              });
            }
          } else {
            print("No documents found with eventid equal to $eventId");
          }

          fetchEventsData();
          print("Event deleted successfully.");
        } else {
          print("Event not found for this user.");
        }
      }
    } catch (e) {
      print("Error deleting event: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Column(
                children: [
                  const SizedBox(height: 16),
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage(img_path),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      name ?? "User Name",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 13),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Text(
                          'Registered Events',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
                              opacity: titles.isEmpty ? 1.0 : 0.0,
                              duration: const Duration(seconds: 1),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.warning_amber_outlined,
                                    size: 40,
                                    color: Colors.red,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "No events available.",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
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
                            bool isSelected = selectedIndex.value == index;
                            return GestureDetector(
                              onTap: () {
                                selectedIndex.value = isSelected ? -1 : index;
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                width: isSelected
                                    ? screenWidth * 0.6
                                    : screenWidth * 0.5,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 138, 131, 163),
                                      Color.fromARGB(255, 140, 136, 141),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CircleAvatar(
                                      radius: 35,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      titles[index],
                                      style: const TextStyle(
                                        fontFamily: 'Arial',
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.04,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        String eventId = events[index]['id'];
                                        deleteEvent(eventId);
                                        Get.snackbar(
                                          'Successful Delete',
                                          'Completed delete this event',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.green,
                                          colorText: Colors.white,
                                          borderRadius: 20,
                                          margin: const EdgeInsets.all(15),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 25),
                                          boxShadows: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 10,
                                              spreadRadius: 2,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                          duration: const Duration(seconds: 3),
                                          animationDuration:
                                              const Duration(milliseconds: 400),
                                          isDismissible: true,
                                          onTap: (snack) {
                                            print("Snackbar tapped");
                                          },
                                          titleText: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeIn,
                                            child: const Text(
                                              'Successful Delete',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                fontFamily: 'Arial',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          messageText: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeOut,
                                            child: const Text(
                                              'Completed delete this event',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Arial',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        splashFactory: NoSplash.splashFactory,
                                        shadowColor: Colors.transparent,
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                      ),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFFebe9f2),
                                              Color(0xFFfaead6),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 100, minHeight: 50),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            "Delete Event",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}