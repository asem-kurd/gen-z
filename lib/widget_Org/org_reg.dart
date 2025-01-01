import 'package:flutter/material.dart';
import 'package:flutter_application_99/Getx/AuthviewModel.dart';
import 'package:flutter_application_99/components/Reg_Org.dart';
import 'package:flutter_application_99/reg_event_user.dart';

import 'package:get/get.dart';

class OrgReg extends GetView<Authviewmodel> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  OrgReg({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Form(
        key: formKey,
        child: Stack(
          children: [
            CustomPaint(
              size: MediaQuery.of(context).size,
              painter: BackgroundPainter(),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: height * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.02),
                    _buildBackButton(),
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
                    InputField(
                      hintText: "Name",
                      onSaved: (value) => controller.name = value ?? '',
                      validator: (value) => value?.isEmpty ?? true
                          ? "Name cannot be empty"
                          : null,
                    ),
                    SizedBox(height: height * 0.013),
                    InputField(
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) => controller.email = value ?? '',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email cannot be empty";
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                            .hasMatch(value)) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.013),
                    InputField(
                      hintText: "Password",
                      obscureText: true,
                      onSaved: (value) => controller.password = value ?? '',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password cannot be empty";
                        } else if (value.length < 8) {
                          return "Password must be at least 8 characters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.013),
                    InputField(
                      hintText: "Phone Number",
                      keyboardType: TextInputType.phone,
                      onSaved: (value) => controller.phone =
                          double.tryParse(value ?? '') ?? 0.0,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Phone number cannot be empty";
                        }
                        if (!RegExp(r"^\+?[0-9]{7,15}$").hasMatch(value)) {
                          return "Please enter a valid phone number";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.013),
                    InputField(
                      hintText: "URL",
                      onSaved: (value) => controller.url = value ?? '',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "URL cannot be empty";
                        }
                        if (!RegExp(r"^(https?|ftp)://[^\s/$.?#].[^\s]*$")
                            .hasMatch(value)) {
                          return "Please enter a valid URL";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.06),
                    CreateAccountButton(
                      formKey: formKey,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          controller.createOrgWithEmailAndPassword();
                        }
                      },
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

  Widget _buildBackButton() {
    return Container(
      alignment: Alignment.topLeft,
      child: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back, color: Colors.white),
      ),
    );
  }
}
