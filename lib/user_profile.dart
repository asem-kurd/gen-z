import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/SetProfilePicture.dart';
import 'package:flutter_application_99/locale/locale_controller.dart';
import 'package:flutter_application_99/repetitions/appbar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _imageUrl;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyLocaleController controllerLanguage = Get.find();
    final user = Supabase.instance.client.auth.currentUser;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    String name = user?.userMetadata?['full_name'] ?? "No name found";

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: ListView(
            padding: const EdgeInsets.only(top: 30, right: 16, left: 16),
            children: [
              CustomAppBar1(),
              Column(
                children: [
                  SetProfilePicture(
                    imageUrl: _imageUrl ?? '',
                    onUpload: (imageUrl) async {
                      setState(() {
                        _imageUrl = imageUrl;
                      });
                      final userId = FirebaseAuth.instance.currentUser!.uid;
                      await Supabase.instance.client.from('profile').update({
                        'avatar_url': imageUrl,
                      }).eq('id', userId);
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.06,
                    decoration: BoxDecoration(
                      color: const Color(0xff5A5D62), // Background color
                      borderRadius:
                          BorderRadius.circular(10.0), // Rounded corners
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Volunteer",
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 16, // Adjust font size if needed
                        fontWeight:
                            FontWeight.w500, // Optional: adjust font weight
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    color: const Color(0xffE6F3F3),
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
                            const Text(
                              "  Ma’an Station, Ma’an",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
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
                              "33 " + "30".tr,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: screenHeight * 0.02),
                  // Container(
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  //   decoration: const BoxDecoration(
                  //     gradient: LinearGradient(colors: [
                  //       Color(0xFFebe9f2),
                  //       Color(0xFFfaead6),
                  //     ]),
                  //   ),
                  //   height: screenHeight * 0.1,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       const FittedBox(
                  //         fit: BoxFit.scaleDown,
                  //         child: Text(
                  //           "Hours Completed: 03\nRequests: 00",
                  //           style: TextStyle(
                  //               fontSize: 16, fontWeight: FontWeight.bold),
                  //         ),
                  //       ),
                  //       ElevatedButton(
                  //         style: ElevatedButton.styleFrom(
                  //           backgroundColor: const Color(0xff5A5D62),
                  //           foregroundColor: Colors.white,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10.0),
                  //           ),
                  //           minimumSize:
                  //               Size(screenWidth * 0.3, screenHeight * 0.05),
                  //         ),
                  //         onPressed: () {},
                  //         child: const Text("Add"),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: screenHeight * 0.05),
                  Text("31".tr, style: TextStyle(fontSize: 30)),
                  const SizedBox(height: 50),
                  SizedBox(
                    height: screenHeight * 0.25,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5, // Replace with dynamic data
                      itemBuilder: (context, index) {
                        return Container(
                          width: screenWidth * 0.5,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Color(0xFFebe9f2),
                              Color(0xFFfaead6),
                            ]),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 55,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Org name',
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.04,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
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
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      minWidth: 150,
                                      minHeight: 50,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "32".tr,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
