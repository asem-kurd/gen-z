import 'package:flutter/material.dart';
import 'package:flutter_application_99/widgets/radio.dart';
import 'package:flutter_application_99/widgets/txtfiled.dart';
import 'package:flutter_application_99/create%20account/getcontroller.dart';
import 'package:flutter_application_99/create%20account/org.dart';
import 'package:get/get.dart';

class MyApp1 extends StatelessWidget {
  final RegistrationController controller = Get.put(RegistrationController());

  MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF887CB0), // Purple background color
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.02), // Padding for notch

                    // GEN-Z Title
                    const Text(
                      "GEN-Z",
                      style: TextStyle(
                        fontSize: 48.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: height * 0.02),

                    // Image Section
                    SizedBox(height: height * 0.02),

                    // First and Last Name Fields (Side by Side)
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // To evenly space the fields
                      children: [
                        const Expanded(child: Txtfiled(label: "First Name")),
                        SizedBox(width: width * 0.02),
                        const Expanded(
                            child: Txtfiled(
                          label: "Last Name",
                          text: "'Please enter your Last name'",
                        )),
                      ],
                    ),

                    SizedBox(height: height * 0.02),
                    // Email Address
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        const emailPattern =
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                        final regExp = RegExp(emailPattern);
                        if (!regExp.hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: height * 0.02),

                    // Gender Selection (Radio buttons)
                    Row(
                      children: [
                        const Text(
                          "Gender:",
                          style: TextStyle(color: Colors.white),
                        ),
                        GenderRadio(value: "Male", title: "Male"),
                        GenderRadio(value: "Female", title: "Female"),
                      ],
                    ),

                    SizedBox(height: height * 0.02),

                    // City Dropdown
                    Obx(() => DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'City',
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          value: controller.selectedCity.value,
                          dropdownColor:
                              const Color.fromARGB(255, 139, 125, 182),
                          items: controller.cities.map((String city) {
                            return DropdownMenuItem<String>(
                              value: city,
                              child: Text(
                                city,
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) =>
                              controller.selectedCity.value = newValue!,
                        )),

                    SizedBox(height: height * 0.02),

                    // Password Fields
                    // Password Field
                    Obx(() => TextFormField(
                          controller: controller.passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.white),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                controller.isPasswordVisible.value =
                                    !controller.isPasswordVisible.value;
                              },
                            ),
                          ),
                          obscureText: !controller.isPasswordVisible.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        )),

                    SizedBox(height: height * 0.02),

                    Obx(() => TextFormField(
                          controller: controller.confirmPasswordController,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            labelStyle: const TextStyle(color: Colors.white),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isConfirmPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                controller.isConfirmPasswordVisible.value =
                                    !controller.isConfirmPasswordVisible.value;
                              },
                            ),
                          ),
                          obscureText:
                              !controller.isConfirmPasswordVisible.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            } else if (value !=
                                controller.passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        )),

                    SizedBox(height: height * 0.02),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 50,
                        ),
                      ),
                      onPressed: () {
                        // Validate form fields
                        if (controller.formKey.currentState!.validate()) {
                          // Proceed with account creation
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Account created successfully!'),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Create your GEN-Z Account",
                        style: TextStyle(color: Color(0xFF5C5B80)),
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    ElevatedButton(
                      onPressed: () {
                        Get.to(const Org());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 25,
                        ),
                      ),
                      child: const Text(
                        "Go to Registration Org Page",
                        style:
                            TextStyle(color: Color(0xFF5C5B80), fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp1());
}
