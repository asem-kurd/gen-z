import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/Getx/EventController.dart';
import 'package:flutter_application_99/user_profile.dart';
import 'package:flutter_application_99/view_model/Event_model.dart';
import 'package:flutter_application_99/view_model/org_model.dart';
import 'package:flutter_application_99/view_model/org_profile.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class DisplayorgAdmin extends StatelessWidget {
  final EventController myorg = Get.put(EventController());
  DisplayorgAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                padding: EdgeInsets.only(
                  top: screenHeight * 0.15,
                  left: screenWidth * 0.1,
                ),
                child: const Text(
                  'Organisation',
                  style: TextStyle(
                    fontSize: 35,
                    color: Color(0xFF78797d),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Obx(() {
                      if (myorg.myorganization.isEmpty) {
                        return const Center(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              padding: const EdgeInsets.only(
                                                  left: 50),
                                              child: InkWell(
                                                onTap: () async {
                                                  var eventId = myorg.orgData;
                                                  print(eventId);
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                          'Orgnaization')
                                                      .doc()
                                                      .get();
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xff3d4349)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18),
                                                    color:
                                                        const Color(0xff3d4349),
                                                  ),
                                                  child: const Text(
                                                    "Delete",
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
                    })),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
