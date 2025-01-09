// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'User Settings',
//       theme: ThemeData.light(),
//       darkTheme: ThemeData.dark(),
//       themeMode: ThemeMode.system,
//       home: UserSettings(),
//     );
//   }
// }

// class UserSettingsController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // Observable variables
//   final name = RxString("");
//   final age = RxInt(0);
//   final email = RxString("");
//   final selectedLanguage = RxString("English");
//   final isDarkMode = RxBool(false);

//   // TextEditingControllers for form fields
//   final nameController = TextEditingController();
//   final ageController = TextEditingController();
//   final emailController = TextEditingController();

//   @override
//   void onInit() {
//     super.onInit();
//     loadDarkMode().then((value) {
//       isDarkMode.value = value;
//       Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
//     });
//     fetchUserData();
//   }

//   // Validate age
//   bool _validateAge(String ageStr) {
//     final age = int.tryParse(ageStr);
//     return age != null && age >= 15 && age <= 55;
//   }

//   // Fetch user data from Firestore
//   Future<void> fetchUserData() async {
//     try {
//       User? currentUser = _auth.currentUser;
//       if (currentUser != null) {
//         String uid = currentUser.uid;
//         DocumentSnapshot userDoc =
//             await _firestore.collection('Users').doc(uid).get();

//         if (userDoc.exists) {
//           name.value = userDoc['name'] as String? ?? "";

//           // Handle age as double or int
//           dynamic ageValue = userDoc['age'];
//           if (ageValue is double) {
//             age.value = ageValue.toInt();
//           } else if (ageValue is int) {
//             age.value = ageValue;
//           } else {
//             age.value = 0;
//           }

//           email.value = userDoc['email'] as String? ?? "";

//           // Update TextEditingControllers with fetched data
//           nameController.text = name.value;
//           ageController.text = age.value.toString();
//           emailController.text = email.value;
//         }
//       } else {
//         Get.snackbar(
//           'Error',
//           'No user is currently logged in.',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red.withOpacity(0.1),
//           colorText: Colors.red,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Error fetching user data: $e',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red.withOpacity(0.1),
//         colorText: Colors.red,
//       );
//       print(e);
//     }
//   }

//   // Update user data in Firestore
//   Future<void> updateUserData() async {
//     // First validate the age
//     if (!_validateAge(ageController.text)) {
//       Get.snackbar(
//         'Error',
//         'Age must be between 15 and 55 years',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red.withOpacity(0.1),
//         colorText: Colors.red,
//       );
//       return;
//     }

//     try {
//       User? currentUser = _auth.currentUser;
//       if (currentUser != null) {
//         String uid = currentUser.uid;
//         await _firestore.collection('Users').doc(uid).update({
//           'name': nameController.text,
//           'age': int.parse(ageController.text),
//           'language': selectedLanguage.value,
//         });

//         Get.snackbar(
//           'Success',
//           'Profile updated successfully',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green.withOpacity(0.1),
//           colorText: Colors.green,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Error updating user data: $e',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red.withOpacity(0.1),
//         colorText: Colors.red,
//       );
//       print(e);
//     }
//   }

//   // Toggle dark mode and save preference
//   Future<void> toggleDarkMode(bool value) async {
//     isDarkMode.value = value;
//     Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isDarkMode', value);
//   }

//   // Load dark mode preference from SharedPreferences
//   Future<bool> loadDarkMode() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool('isDarkMode') ?? false;
//   }

//   // Logout user
//   void logout() async {
//     try {
//       await _auth.signOut();
//       Get.offAllNamed('/CreateUser');
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Error signing out: $e',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red.withOpacity(0.1),
//         colorText: Colors.red,
//       );
//       print(e);
//     }
//   }
// }

// class UserSettings extends StatelessWidget {
//   const UserSettings({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final UserSettingsController controller = Get.put(UserSettingsController());

//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.primary,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         title: const Text(
//           "Settings",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 20),
//             child: InkWell(
//               onTap: controller.updateUserData,
//               child: const Text(
//                 "Save",
//                 style: TextStyle(
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: screenWidth * 0.05,
//           vertical: screenHeight * 0.02,
//         ),
//         child: ListView(
//           children: [
//             SettingsTextField(
//               label: "Name",
//               controller: controller.nameController,
//             ),
//             SettingsTextField(
//               label: "Age",
//               controller: controller.ageController,
//               isNumber: true,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter your age';
//                 }
//                 final age = int.tryParse(value);
//                 if (age == null || age < 15 || age > 55) {
//                   return 'Age must be between 15 and 55';
//                 }
//                 return null;
//               },
//             ),
//             SettingsTextField(
//               label: "Email",
//               controller: controller.emailController,
//               disabledBorder: true,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 20),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 181, 125, 217),
//                 ),
//                 onPressed: () async {
//                   User? currentUser = FirebaseAuth.instance.currentUser;
//                   if (currentUser != null && currentUser.email != null) {
//                     try {
//                       await FirebaseAuth.instance.sendPasswordResetEmail(
//                         email: currentUser.email!,
//                       );
//                       Get.snackbar(
//                         'Success',
//                         'Password reset link has been sent to your email',
//                         snackPosition: SnackPosition.BOTTOM,
//                         backgroundColor: Colors.green.withOpacity(0.1),
//                         colorText: Colors.green,
//                       );
//                     } catch (e) {
//                       Get.snackbar(
//                         'Error',
//                         'Failed to send password reset email: ${e.toString()}',
//                         snackPosition: SnackPosition.BOTTOM,
//                         backgroundColor: Colors.red.withOpacity(0.1),
//                         colorText: Colors.red,
//                       );
//                     }
//                   } else {
//                     Get.snackbar(
//                       'Error',
//                       'No user is currently logged in or email is not available.',
//                       snackPosition: SnackPosition.BOTTOM,
//                       backgroundColor: Colors.red.withOpacity(0.1),
//                       colorText: Colors.red,
//                     );
//                   }
//                 },
//                 child: const Text("Reset Password"),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Divider(
//               color: Color.fromARGB(255, 181, 125, 217),
//             ),
//             const SizedBox(height: 20),
//             LanguageField(
//               label: "Language",
//               value: controller.selectedLanguage,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Dark Mode",
//                   style: TextStyle(
//                     fontSize: screenWidth * 0.06,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Obx(
//                   () => Switch(
//                     focusColor: const Color.fromARGB(255, 181, 125, 217),
//                     value: controller.isDarkMode.value,
//                     onChanged: (value) async {
//                       await controller.toggleDarkMode(value);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SettingsTextField extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   final bool isNumber;
//   final bool disabledBorder;
//   final String? Function(String?)? validator;

//   const SettingsTextField({
//     super.key,
//     required this.label,
//     required this.controller,
//     this.isNumber = false,
//     this.disabledBorder = false,
//     this.validator,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     const Color borderColor = Color.fromARGB(255, 181, 125, 217);

//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: screenWidth * 0.06,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 4),
//           TextFormField(
//             controller: controller,
//             keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//             enabled: !disabledBorder,
//             validator: validator,
//             decoration: InputDecoration(
//               border: const UnderlineInputBorder(
//                 borderSide: BorderSide(color: borderColor),
//               ),
//               enabledBorder: const UnderlineInputBorder(
//                 borderSide: BorderSide(color: borderColor),
//               ),
//               focusedBorder: const UnderlineInputBorder(
//                 borderSide: BorderSide(color: borderColor, width: 2),
//               ),
//               disabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: borderColor.withOpacity(0.5)),
//               ),
//               contentPadding: EdgeInsets.symmetric(
//                 vertical: screenWidth * 0.035,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class LanguageField extends StatelessWidget {
//   final String label;
//   final RxString value;

//   const LanguageField({
//     super.key,
//     required this.label,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     const Color borderColor = Color(0xFF918C94);

//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: screenWidth * 0.06,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Obx(
//             () => DropdownButtonFormField<String>(
//               focusColor: const Color.fromARGB(255, 181, 125, 217),
//               value: value.value,
//               items: const [
//                 DropdownMenuItem(
//                   value: "English",
//                   child: Text("English"),
//                 ),
//                 DropdownMenuItem(
//                   value: "عربي",
//                   child: Text("عربي"),
//                 ),
//               ],
//               onChanged: (newValue) {
//                 if (newValue != null) value.value = newValue;
//               },
//               decoration: InputDecoration(
//                 border: const UnderlineInputBorder(
//                   borderSide: BorderSide(color: borderColor),
//                 ),
//                 enabledBorder: const UnderlineInputBorder(
//                   borderSide: BorderSide(color: borderColor),
//                 ),
//                 focusedBorder: const UnderlineInputBorder(
//                   borderSide: BorderSide(color: borderColor, width: 2),
//                 ),
//                 contentPadding: EdgeInsets.symmetric(
//                   vertical: screenWidth * 0.035,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }













































import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'User Settings',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: UserSettings(),
    );
  }
}

class UserSettingsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Observable variables
  final name = RxString("");
  final age = RxInt(0);
  final email = RxString("");
  final selectedLanguage = RxString("English");
  final isDarkMode = RxBool(false);

  // TextEditingControllers for form fields
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadDarkMode().then((value) {
      isDarkMode.value = value;
      Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
    });
    fetchUserData();
  }

  // Validate age
  bool _validateAge(String ageStr) {
    final age = int.tryParse(ageStr);
    return age != null && age >= 15 && age <= 55;
  }

  // Fetch user data from Firestore
  Future<void> fetchUserData() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        String uid = currentUser.uid;
        DocumentSnapshot userDoc =
            await _firestore.collection('Users').doc(uid).get();

        if (userDoc.exists) {
          name.value = userDoc['name'] as String? ?? "";

          // Handle age as double or int
          dynamic ageValue = userDoc['age'];
          if (ageValue is double) {
            age.value = ageValue.toInt();
          } else if (ageValue is int) {
            age.value = ageValue;
          } else {
            age.value = 0;
          }

          email.value = userDoc['email'] as String? ?? "";

          // Update TextEditingControllers with fetched data
          nameController.text = name.value;
          ageController.text = age.value.toString();
          emailController.text = email.value;
        }
      } else {
        Get.snackbar(
          'Error',
          'No user is currently logged in.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error fetching user data: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      print(e);
    }
  }

  // Update user data in Firestore
  Future<void> updateUserData() async {
    // Validate name field
    if (nameController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your name',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return;
    }

    // Validate age field
    if (!_validateAge(ageController.text)) {
      Get.snackbar(
        'Error',
        'Age must be between 15 and 55 years',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return;
    }

    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        String uid = currentUser.uid;
        await _firestore.collection('Users').doc(uid).update({
          'name': nameController.text,
          'age': int.parse(ageController.text),
          'language': selectedLanguage.value,
        });

        Get.snackbar(
          'Success',
          'Profile updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error updating user data: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      print(e);
    }
  }

  // Toggle dark mode and save preference
  Future<void> toggleDarkMode(bool value) async {
    isDarkMode.value = value;
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
  }

  // Load dark mode preference from SharedPreferences
  Future<bool> loadDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDarkMode') ?? false;
  }

  // Logout user
  void logout() async {
    try {
      await _auth.signOut();
      Get.offAllNamed('/CreateUser');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error signing out: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      print(e);
    }
  }
}

class UserSettings extends StatelessWidget {
  const UserSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final UserSettingsController controller = Get.put(UserSettingsController());

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: controller.updateUserData,
              child: const Text(
                "Save",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
        child: ListView(
          children: [
            SettingsTextField(
              label: "Name",
              controller: controller.nameController,
            ),
            SettingsTextField(
              label: "Age",
              controller: controller.ageController,
              isNumber: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your age';
                }
                final age = int.tryParse(value);
                if (age == null || age < 15 || age > 55) {
                  return 'Age must be between 15 and 55';
                }
                return null;
              },
            ),
            SettingsTextField(
              label: "Email",
              controller: controller.emailController,
              disabledBorder: true,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 181, 125, 217),
                ),
                onPressed: () async {
                  User? currentUser = FirebaseAuth.instance.currentUser;
                  if (currentUser != null && currentUser.email != null) {
                    try {
                      await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: currentUser.email!,
                      );
                      Get.snackbar(
                        'Success',
                        'Password reset link has been sent to your email',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green.withOpacity(0.1),
                        colorText: Colors.green,
                      );
                    } catch (e) {
                      Get.snackbar(
                        'Error',
                        'Failed to send password reset email: ${e.toString()}',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red.withOpacity(0.1),
                        colorText: Colors.red,
                      );
                    }
                  } else {
                    Get.snackbar(
                      'Error',
                      'No user is currently logged in or email is not available.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red.withOpacity(0.1),
                      colorText: Colors.red,
                    );
                  }
                },
                child: const Text("Reset Password"),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(
              color: Color.fromARGB(255, 181, 125, 217),
            ),
            const SizedBox(height: 20),
            LanguageField(
              label: "Language",
              value: controller.selectedLanguage,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dark Mode",
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx(
                  () => Switch(
                    focusColor: const Color.fromARGB(255, 181, 125, 217),
                    value: controller.isDarkMode.value,
                    onChanged: (value) async {
                      await controller.toggleDarkMode(value);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class SettingsTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isNumber;
  final bool disabledBorder;
  final String? Function(String?)? validator;

  const SettingsTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isNumber = false,
    this.disabledBorder = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    const Color borderColor = Color.fromARGB(255, 181, 125, 217);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: screenWidth * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            enabled: !disabledBorder,
            validator: validator,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: borderColor),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: borderColor),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 2),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: borderColor.withOpacity(0.5)),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: screenWidth * 0.035,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LanguageField extends StatelessWidget {
  final String label;
  final RxString value;

  const LanguageField({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    const Color borderColor = Color(0xFF918C94);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: screenWidth * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Obx(
            () => DropdownButtonFormField<String>(
              focusColor: const Color.fromARGB(255, 181, 125, 217),
              value: value.value,
              items: const [
                DropdownMenuItem(
                  value: "English",
                  child: Text("English"),
                ),
                DropdownMenuItem(
                  value: "عربي",
                  child: Text("عربي"),
                ),
              ],
              onChanged: (newValue) {
                if (newValue != null) value.value = newValue;
              },
              decoration: InputDecoration(
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: borderColor, width: 2),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: screenWidth * 0.035,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}