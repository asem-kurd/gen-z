import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/Getx/EventController.dart';
import 'package:flutter_application_99/controll_home.dart';
import 'package:flutter_application_99/user_profile.dart';
import 'package:flutter_application_99/view_model/Event_model.dart';
import 'package:flutter_application_99/view_model/org_model.dart';
import 'package:flutter_application_99/view_model/org_profile.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class DisplayorgAdmin extends StatelessWidget {
  final EventController myorg = Get.put(EventController());
  DisplayorgAdmin({super.key});

  Future<void> deleteAllOrganizationEvents(String organizationUserId) async {
    try {
      print(
          "Starting to delete all events for organization: $organizationUserId");

      // جلب جميع الأحداث المرتبطة بالمؤسسة
      var organizationEventsSnapshot = await FirebaseFirestore.instance
          .collection('events')
          .where('userId', isEqualTo: organizationUserId)
          .get();

      for (var eventDoc in organizationEventsSnapshot.docs) {
        // جلب eventId من داخل المستند
        String eventId = eventDoc.data()['eventid'];
        print("Processing event with eventId: $eventId");

        // حذف الحدث من مجموعة "events"
        await FirebaseFirestore.instance
            .collection('events')
            .doc(eventDoc.id)
            .delete();
        print("Deleted event $eventId from events collection.");

        // حذف الحدث من جميع المستخدمين
        var usersSnapshot =
            await FirebaseFirestore.instance.collection('Users').get();
        print("Fetched ${usersSnapshot.docs.length} users.");

        for (var userDoc in usersSnapshot.docs) {
          var userId = userDoc.id;

          // الوصول إلى مجموعة "events" الفرعية للمستخدم
          var userEventSnapshot = await FirebaseFirestore.instance
              .collection('Users')
              .doc(userId)
              .collection('events')
              .where(FieldPath.documentId, isEqualTo: eventId)
              .get();

          print(
              "Found ${userEventSnapshot.docs.length} events for user $userId to delete.");

          for (var userEventDoc in userEventSnapshot.docs) {
            await FirebaseFirestore.instance
                .collection('Users')
                .doc(userId)
                .collection('events')
                .doc(userEventDoc.id)
                .delete();
            print("Deleted event $eventId from user $userId's events.");
          }
        }
      }

      // حذف الأحداث من المؤسسة
      await FirebaseFirestore.instance
          .collection('Orgnaization')
          .doc(organizationUserId)
          .update({
        'My_Events': FieldValue.delete(),
      });
      print(
          "Deleted all events for organization $organizationUserId from Orgnaization collection.");

      // حذف المؤسسة نفسها
      await FirebaseFirestore.instance
          .collection('Orgnaization')
          .doc(organizationUserId)
          .delete();
      print(
          "Deleted organization $organizationUserId from Orgnaization collection.");

      print(
          "All events and the organization $organizationUserId have been deleted.");
    } catch (e) {
      print("Error deleting organization events or organization: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(136, 124, 176, 0.17),
                Color.fromRGBO(194, 131, 27, 0.15),
                Color.fromRGBO(251, 133, 0, 0.18),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 10),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.1,
                  left: screenWidth * 0.1,
                ),
                child: const Text(
                  'Organisation',
                  style: TextStyle(
                    fontSize: 35,
                    // color: Color(0xFF78797d),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Obx(() {
                    if (myorg.myorganization.isEmpty) {
                      return Center(
                        child: Text('No organizations at this time'),
                      );
                    }
                    return ListView.builder(
                      itemCount: myorg.myorganization.length,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final orgs = myorg.myorganization[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: Container(
                            height: screenHeight * 0.15,
                            width: screenWidth * 0.9,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(0, 128, 128, 0.1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 20),
                                const CircleAvatar(
                                  radius: 45,
                                  backgroundImage: AssetImage(
                                      'assets/images/Image/Logo.png'),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        orgs.name,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF78797d),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 10,
                                            child: Icon(
                                              Icons.error_outline,
                                              color: Color(0xFF78797d),
                                              size: 16,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Non-profit-organization',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF78797d),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Colors.green,
                                            child: Icon(
                                              Icons.phone,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            orgs.phone.toInt().toString(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF78797d),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 50),
                                            child: InkWell(
                                              onTap: () async {
                                                await deleteAllOrganizationEvents(
                                                    orgs.userid);
                                                print(
                                                    "All events for organization ${orgs.userid} have been deleted.");
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xff3d4349)),
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                  color:
                                                      const Color(0xff3d4349),
                                                ),
                                                child: const Text(
                                                  "Delete Org",
                                                  style: TextStyle(
                                                      color: Colors.white),
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
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
