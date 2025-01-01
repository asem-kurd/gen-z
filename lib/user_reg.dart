import 'package:flutter/material.dart';
import 'package:flutter_application_99/Getx/AuthviewModel.dart';
import 'package:flutter_application_99/Loginuser.dart';
import 'package:flutter_application_99/components/Reg_User_List.dart';
import 'package:flutter_application_99/components/Reg_user_Textfiled.dart';
import 'package:flutter_application_99/reg_event_user.dart';
import 'package:get/get.dart';

class UserReg extends GetView<Authviewmodel> {
  final TextEditingController countryController = TextEditingController();
  final TextEditingController interestController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var visabile = false.obs;

  String? selectedGender; // Define the selected value for gender

  UserReg({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
                    RegUserTextfiled(
                      hintText: 'Name',
                      controller: controller.nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name field cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        controller.name = value ?? '';
                      },
                    ),
                    SizedBox(height: height * 0.013),
                    RegUserTextfiled(
                      hintText: 'Email',
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email field cannot be empty";
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+$")
                            .hasMatch(value)) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        controller.email = value ?? '';
                      },
                    ),
                    SizedBox(height: height * 0.013),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: height * 0.06),
                      child: Obx(
                        () => TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                              color: Color(0xFF474448),
                              fontStyle: FontStyle.italic,
                            ),
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
                    SizedBox(height: height * 0.013),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: height * 0.06),
                      child: Obx(
                        () => TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle: const TextStyle(
                              color: Color(0xFF474448),
                              fontStyle: FontStyle.italic,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
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
                    SizedBox(height: height * 0.013),
                    RegUserTextfiled(
                      hintText: 'Phone number',
                      controller: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Phone number cannot be empty";
                        } else if (!RegExp(r'^\+?[0-9]{10}$').hasMatch(value)) {
                          return "Enter a valid phone number";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        controller.phone = double.tryParse(value ?? '') ?? 0.0;
                      },
                    ),
                    SizedBox(height: height * 0.013),
                    RegUserTextfiled(
                      hintText: 'Age',
                      controller: controller.ageController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Age field cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        controller.age = double.tryParse(value ?? '') ?? 0.0;
                      },
                    ),
                    SizedBox(height: height * 0.013),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: height * 0.06),
                      child: DropdownButtonFormField<String>(
                        value: selectedGender, // Use the selectedGender
                        onChanged: (value) {
                          selectedGender = value; // Update the value
                        },
                        items: [
                          DropdownMenuItem<String>(
                            value: 'Male',
                            child: Container(child: const Text('Male')),
                          ),
                          const DropdownMenuItem<String>(
                            value: 'Female',
                            child: Text('Female'),
                          ),
                        ],
                        decoration: InputDecoration(
                          hintText: 'Select Gender',
                          hintStyle: const TextStyle(
                            color: Color(0xFF474448),
                            fontStyle: FontStyle.italic,
                          ),
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
                        onSaved: (newValue) {
                          controller.gender = newValue ?? '';
                        },
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(250, 60),
                        backgroundColor: const Color(0xFF474448),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          controller.createUserWithEmailAndPassword();
                          // بعد إنشاء الحساب، إعادة تعيين القيم إلى null
                          controller.nameController.clear();
                          controller.emailController.clear();
                          controller.passwordController.clear();
                          controller.phoneController.clear();
                          controller.ageController.clear();
                          selectedGender = null; // إعادة تعيين الجنس
                          // يمكنك إضافة أي قيم أخرى حسب الحاجة
                          Get.to(CreateUser());
                        }
                      },
                      child: const Text(
                        "Create User",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
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
