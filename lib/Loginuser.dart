import 'package:flutter/material.dart';
import 'package:flutter_application_99/Getx/AuthviewModel.dart';
import 'package:flutter_application_99/Repetitions/gradent%20circle.dart';
import 'package:flutter_application_99/create%20account/getcontroller.dart';
import 'package:flutter_application_99/create%20account/org.dart';
import 'package:flutter_application_99/user_reg.dart';
import 'package:flutter_application_99/user_profile.dart';
import 'dart:ui' as ui;
import 'package:get/get.dart';

// ignore: must_be_immutable
class CreateUser extends GetView<Authviewmodel> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Authviewmodel authviewmodel = Get.put(Authviewmodel());
  var visabile = false.obs;
  var isConfirmPasswordVisible = false.obs;
  final String text;
  RxBool isCheckedes = false.obs;
  CreateUser({
    super.key,
    this.text = "Please enter password correctly",
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Form(
      key: formKey,
      child: Scaffold(
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
                        ),
                        onSaved: (value) {
                          controller.email = value.toString();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email field cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: height * 0.06),
                      child: Obx(
                        () => TextFormField(
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
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 2.0),
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(
                                  visabile.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  visabile.value = !visabile.value;
                                }),
                          ),
                          obscureText: !visabile.value,
                          onSaved: (value) {
                            controller.password = value.toString();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              print("Please enter your password");
                            } else if (value.length <= 8) {
                              return "'Password must be at least 8 characters long";
                            } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                              return ("Password must contain at least one number.");
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.008),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.11),
                          child: Obx(
                            () => Checkbox(
                              value: isCheckedes.value,
                              onChanged: (bool? value) {
                                isCheckedes.value = value ?? false;
                                if (isCheckedes.value) {
                                  print(
                                      "Checkbox is checked Login organization");
                                } else {
                                  // إذا كان False
                                  print("Checkbox is unchecked Login user");
                                }
                              },
                            ),
                          ),
                        ),
                        const Text(
                          "Login as Organization",
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.04,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(width: width * 0.25),
                        Container(
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
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(width * 0.6, height * 0.064),
                          backgroundColor: const Color(0xFF7fa3ae)),
                      onPressed: () {
                        formKey.currentState!.save();
                        print(
                            "Email: ${controller.email}, Password: ${controller.password}");
                        if (formKey.currentState!.validate()) {
                          controller.signUpWithEmailAndPassword();
                        }
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
                          backgroundColor: const Color(0xFF949699)),
                      onPressed: () {
                        Get.to(() => Organiston());
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
              child: Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    // Add your logic here
                  },
                  child: const Text(
                    "Continue as Guest?",
                    style: TextStyle(
                      color: Color(0xFF5b5e63),
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
      ),
    );
  }
}
