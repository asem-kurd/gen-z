import 'package:flutter/material.dart';
import 'package:flutter_application_99/Repetitions/gradent%20circle.dart';
import 'package:flutter_application_99/create%20account/org.dart';
import 'package:flutter_application_99/organiston.dart';
import 'package:flutter_application_99/profile.dart';
import 'dart:ui' as ui;
import 'package:get/get.dart';

class CreateUser extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final String text;

  CreateUser({
    super.key,
    this.text = "Please enter password correctly",
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // خلفية مخصصة (CustomPaint) تغطي كامل الشاشة
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: BackgroundPainter(),
          ),
          // باقي المحتوى داخل الـ SingleChildScrollView
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: height * 0.1), // لإعطاء مساحة أسفل الصفحة
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
                  const SizedBox(height: 10),
                  const Text(
                    "Sign in with your GEN-Z Member",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "or Organization",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: height * 0.06),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: height * 0.06),
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Colors.grey),
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
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2.0),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.visibility,
                              color: Colors.black,
                            ),
                            onPressed: () {},
                          )),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return text.isNotEmpty
                              ? text
                              : 'This field is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: height * 0.003),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.47),
                    child: InkWell(
                      onTap: () {
                        // Action for "Forgot password?"
                      },
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.04,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(width * 0.6, height * 0.064),
                      backgroundColor:
                          Color.fromARGB((0.31 * 255).toInt(), 255, 255, 0),
                    ),
                    onPressed: () {
                      // Add navigation logic here
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(width * 0.6, height * 0.064),
                        backgroundColor: Colors.grey.shade800),
                    onPressed: () {
                      Get.to(() => const ProfileScreen());
                      // Add account creation logic here
                    },
                    child: const Text(
                      "Create your GEN-Z Account",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft, // المحاذاة إلى أسفل اليسار
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
              child: InkWell(
                onTap: () {
                  // Add your logic here
                },
                child: const Text(
                  "Continue as Guest?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
