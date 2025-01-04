import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_99/Repetitions/appbar2.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class UserSettingsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final name = RxString("");
  final age = RxString("");
  // final email = RxString("ramannjh@gmail.com");
  // final password = RxString("");
  final selectedLanguage = RxString("English");

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        String uid = currentUser.uid;
        DocumentSnapshot userDoc =
            await _firestore.collection('Users').doc(uid).get();

        if (userDoc.exists) {
          name.value = userDoc['name'] as String? ?? "";
          age.value = userDoc['age'] as String? ?? "";
          // email.value = userDoc['email'] as String? ?? "";
          // selectedLanguage.value = userDoc['language'] as String? ?? "English";
        }
      } else {
        Get.snackbar('Error', 'No user is currently logged in.',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Error fetching user data: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> updateUserData() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        String uid = currentUser.uid;
        await _firestore.collection('Users').doc(uid).update({
          'name': name.value,
          'age': age.value,
        });

        Get.snackbar('Success', 'Profile updated successfully',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Error updating user data: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void logout() async {
    try {
      await _auth.signOut();
      Get.offAllNamed('/CreateUser');
    } catch (e) {
      Get.snackbar('Error', 'Error signing out: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}

class UserSettings extends GetView<UserSettingsController> {
  const UserSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserSettingsController());
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
              value: controller.name,
            ),
            SettingsTextField(
              label: "Age",
              value: controller.age,
            ),
            // SettingsTextField(
            //   label: "Email",
            //   value: controller.email,
            //   disabledBorder: true,
            // ),
            // SettingsTextField(
            //   label: "Password",
            //   value: controller.password,
            //   isPassword: true,
            // ),
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
                Switch(
                  focusColor: const Color.fromARGB(255, 181, 125, 217),
                  value: Get.isDarkMode,
                  onChanged: (value) {
                    Get.changeThemeMode(
                        value ? ThemeMode.dark : ThemeMode.light);
                  },
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
  final RxString value;
  final bool isPassword;
  final bool disabledBorder;

  const SettingsTextField({
    super.key,
    required this.label,
    required this.value,
    this.disabledBorder = false,
    this.isPassword = false,
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
          Obx(
            () => TextFormField(
              initialValue: value.value,
              obscureText: isPassword,
              enabled: !disabledBorder,
              onChanged: (newValue) => value.value = newValue,
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: UnderlineInputBorder(
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
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: UnderlineInputBorder(
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
