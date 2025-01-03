import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_99/Repetitions/appbar2.dart';
import 'package:path/path.dart';

class UserSettingsController extends GetxController {
  final name = "Rama".obs;
  final age = "20".obs;
  final email = "ramannjh@gmail.com".obs;
  final password = "".obs;
  final selectedLanguage = "English".obs;

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed('/CreateUser');
  }
}

class UserSettings extends StatelessWidget {
  final UserSettingsController controller = Get.put(UserSettingsController());

  UserSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: CustomAppBar2(
        toolbarHeight: screenHeight * 0.1,
        appBarName: "Settings",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              label: "Name",
              value: controller.name,
            ),
            TextField(
              label: "Age",
              value: controller.age,
            ),
            TextField(
              label: "Email",
              value: controller.email,
            ),
            TextField(
              label: "Password",
              value: controller.password,
              isPassword: true,
            ),
            LanguageField(
              label: "Language",
              value: controller.selectedLanguage,
            ),
            ListTile(
              leading: Text(
                "Dark Mode",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                ),
              ),
              trailing: Switch(
                value: Get.isDarkMode,
                onChanged: (value) {
                  Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                },
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.015,
                    horizontal: screenWidth * 0.04,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: controller.logout,
                icon: const Icon(Icons.logout),
                label: const Text("Log out"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextField extends StatelessWidget {
  final String label;
  final RxString value;
  final bool isPassword;

  const TextField({
    super.key,
    required this.label,
    required this.value,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Obx(
            () => TextFormField(
              initialValue: value.value,
              obscureText: isPassword,
              onChanged: (newValue) => value.value = newValue,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
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

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Obx(
            () => DropdownButtonFormField<String>(
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
                  borderSide: BorderSide(color: Colors.grey),
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
