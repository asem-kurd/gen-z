import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/Getx/AuthviewModel.dart';
import 'package:flutter_application_99/Repetitions/gradent%20circle.dart';
import 'package:flutter_application_99/Repetitions/textfiledsign.dart';
import 'package:flutter_application_99/Repetitions/txtfiled.dart';
import 'package:flutter_application_99/Loginuser.dart';
import 'package:flutter_application_99/package/drowdown.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Org_reg extends GetView<Authviewmodel> {
  final TextEditingController countryController = TextEditingController();
  final TextEditingController interestController = TextEditingController();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  Org_reg({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Form(
        key: formKey2,
        child: Stack(
          children: [
            CustomPaint(
              size: MediaQuery.of(context).size,
              painter: BackgroundPainter(),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: height * 0.1,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.02),
                    Container(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Text(
                      "GEN-Z",
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        fontFamily: "RussoOne",
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    const Text(
                      "Your Journey Begins Here,",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Welcome to GEN-Z,",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: height * 0.013),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: height * 0.06),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: const TextStyle(
                              color: Color(0xFF474448),
                              fontWeight: FontWeight.bold),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 2.0),
                          ),
                        ),
                        onSaved: (value) {
                          controller.name = value.toString();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "name  field cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: height * 0.013),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: height * 0.06),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: const TextStyle(
                              color: Color(0xFF474448),
                              fontWeight: FontWeight.bold),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 2.0),
                          ),
                        ),
                        onSaved: (value) {
                          controller.email = value.toString();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email  field cannot be empty";
                          }
                          if (!RegExp(
                                  r"^^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                              .hasMatch(value)) {
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: height * 0.013),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: height * 0.06),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                              color: Color(0xFF474448),
                              fontWeight: FontWeight.bold),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 2.0),
                          ),
                        ),
                        obscureText: true,
                        onSaved: (value) {
                          controller.password = value.toString();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            print("Error");
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: height * 0.013),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: height * 0.06),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Phone number',
                          hintStyle: const TextStyle(
                              color: Color(0xFF474448),
                              fontWeight: FontWeight.bold),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 2.0),
                          ),
                        ),
                        keyboardType: TextInputType
                            .phone, // Set keyboard type for phone input
                        onSaved: (value) {
                          controller.phone = double.tryParse(value ?? '') ??
                              0.0; // Save the phone number to the controller
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Phone number cannot be empty";
                          } else if (!RegExp(r'^\+?[0-9]{7,15}$')
                              .hasMatch(value)) {
                            return "Enter a valid phone number";
                          }
                          if (double.tryParse(value) == null) {
                            return "Please enter a valid phone number";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: height * 0.06),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'URL',
                          hintStyle: const TextStyle(
                              color: Color(0xFF474448),
                              fontWeight: FontWeight.bold),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 2.0),
                          ),
                        ),
                        onSaved: (value) {
                          controller.url = value.toString();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "name  field cannot be empty";
                          } else if (RegExp(
                                  r'^(https?|ftp)://[^\s/$.?#].[^\s]*$')
                              .hasMatch(value)) {
                            return "Please enter a valid URL";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: height * 0.1),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(250, 60),
                        backgroundColor: Colors.grey.shade800,
                      ),
                      onPressed: () {
                        if (formKey2.currentState!.validate()) {
                          formKey2.currentState!.save();
                          controller.createOrgWithEmailAndPassword();
                          // Call the correct method
                        }
                      },
                      child: const Text(
                        "Create your GEN-Z Account",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
