import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/Getx/AuthviewModel.dart';
import 'package:flutter_application_99/Repetitions/gradent%20circle.dart';
import 'package:flutter_application_99/components/login_widget.dart';
import 'package:flutter_application_99/create%20account/getcontroller.dart';
import 'package:flutter_application_99/create%20account/org.dart';
import 'package:flutter_application_99/user_reg.dart';
import 'package:flutter_application_99/user_profile.dart';
import 'package:flutter_application_99/widget_Org/org_reg.dart';
import 'dart:ui' as ui;
import 'package:get/get.dart';

class CreateUser extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Authviewmodel authviewmodel = Get.put(Authviewmodel());
  var visabile = false.obs;
  var isConfirmPasswordVisible = false.obs;
  final String text;
  RxBool isChecked = false.obs;
  late bool CheckedOrg;

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
            CustomPaint(
              size: MediaQuery.of(context).size,
              painter: BackgroundPainter(),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: height * 0.1), // لإعطاء مساحة أسفل الصفحة
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.07),
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
                    CustomTextField(
                      controller: emailController,
                      hintText: 'Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email field cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        authviewmodel.email = value.toString();
                      },
                      isPassword: false,
                      toggleVisibility: () {},
                    ),
                    SizedBox(height: height * 0.02),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: height * 0.06),
                      child: Obx(
                        () => TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color(0xFF474448),
                                fontWeight: FontWeight.bold),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(
                                    visabile.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: const Color(0xff222222)),
                                onPressed: () {
                                  visabile.value = !visabile.value;
                                }),
                          ),
                          obscureText: !visabile.value,
                          onSaved: (value) {
                            authviewmodel.password = value.toString();
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
                              value: authviewmodel.isChecked.value,
                              onChanged: (bool? value) {
                                authviewmodel.isChecked.value = value ?? false;
                                if (authviewmodel.isChecked.value) {
                                  print(
                                      "Checkbox is checked: Login organization");
                                  CheckedOrg = true;
                                } else {
                                  print("Checkbox is unchecked: Login user");
                                  CheckedOrg = false;
                                }
                                print("CheckedOrg: $CheckedOrg");
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
                        SizedBox(width: width * 0.15),
                        Container(
                          child: InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                authviewmodel.resetPassword(
                                    context, emailController.text);
                              }
                            },
                            child: InkWell(
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
                              onTap: () async {
                                await FirebaseAuth.instance
                                    .sendPasswordResetEmail(
                                        email: authviewmodel.email);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(width * 0.6, height * 0.064),
                          backgroundColor: const Color(0xFF7fa3ae),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () async {
                        final admin = FirebaseFirestore.instance
                            .collection('Admin')
                            .limit(1)
                            .get();
                        formKey.currentState!.save();
                        if (formKey.currentState!.validate()) {
                          if (authviewmodel.isChecked.value) {
                            print("Searching in Org collection");
                            final result = await FirebaseFirestore.instance
                                .collection('Orgnaization')
                                .where('email', isEqualTo: authviewmodel.email)
                                .get();
                            if (result.docs.isNotEmpty) {
                              authviewmodel.signUpWithEmailAndPassword(context);
                            } else {
                              print("Organization not found");
                            }
                          } else if (authviewmodel.email == admin) {
                            print("Searching in Admin collection");
                            final result = await FirebaseFirestore.instance
                                .collection('Admin')
                                .where('email', isEqualTo: authviewmodel.email)
                                .get();
                            if (result.docs.isNotEmpty) {
                              authviewmodel.signUpWithEmailAndPassword(context);
                            } else {
                              print("Admin not found");
                            }
                          } else {
                            print("Searching in User collection");
                            final result = await FirebaseFirestore.instance
                                .collection('Users')
                                .where('email', isEqualTo: authviewmodel.email)
                                .get();
                            if (result.docs.isNotEmpty) {
                              authviewmodel.signUpWithEmailAndPassword(context);
                            } else {
                              print("User not found");
                            }
                          }
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(width * 0.6, height * 0.064),
                          backgroundColor: const Color(0xFF949699),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        Get.to(() => UserReg());
                      },
                      child: const Text(
                        "Create User Account",
                        style: TextStyle(
                            color: Colors.white, fontStyle: FontStyle.italic),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(width * 0.6, height * 0.064),
                          backgroundColor: const Color(0xFF949699),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        Get.to(() => OrgReg());
                      },
                      child: const Text(
                        "Create Organistion Account",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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

class CreateAccountButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback onPressed;

  const CreateAccountButton({
    required this.formKey,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(250, 60),
        backgroundColor: Colors.grey.shade800,
      ),
      onPressed: onPressed,
      child: const Text(
        "Create Organization Account",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
