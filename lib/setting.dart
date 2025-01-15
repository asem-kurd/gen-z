import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_99/locale/locale_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'User Settings',
      home: UserSettings(),
    );
  }
}

class UserSettingsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final name = RxString("");
  final age = RxInt(0);
  final email = RxString("");
  final selectedLanguage = RxString("English");
  final isDarkMode = RxBool(false);

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  bool _validateAge(String ageStr) {
    final age = int.tryParse(ageStr);
    return age != null && age >= 15 && age <= 55;
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
          dynamic ageValue = userDoc['age'];
          age.value = (ageValue is double) ? ageValue.toInt() : (ageValue ?? 0);
          email.value = userDoc['email'] as String? ?? "";

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

  Future<void> updateUserData() async {
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
}

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  List<String> languages = ['English', 'العربية'];
  String? _selectedLanguage;
  bool _isDarkMode = false;
  final MyLocaleController _localeController = Get.put(MyLocaleController());

  @override
  void initState() {
    super.initState();
    getSelectedPref();
  }

  void getSelectedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _selectedLanguage = prefs.getString('Language') ?? languages.first;
        _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      });
      Get.changeThemeMode(_isDarkMode ? ThemeMode.dark : ThemeMode.light);
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserSettingsController controller = Get.put(UserSettingsController());

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Settings",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: controller.updateUserData,
              child: Text(
                "Save",
                style: const TextStyle(fontSize: 20),
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
            ListTile(
              title: const Text("Change Language"),
              leading: const Icon(Icons.language, color: Colors.purple),
              trailing: DropdownButton(
                value: _selectedLanguage,
                onChanged: (newValue) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('Language', newValue!);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      _selectedLanguage = newValue;
                    });
                    _localeController
                        .changeLanguage(newValue == 'English' ? 'en' : 'ar');
                  });
                },
                items: languages.map((language) {
                  return DropdownMenuItem(
                    value: language,
                    child: Text(language),
                  );
                }).toList(),
              ),
            ),
            ListTile(
              title: const Text("Dark Mode"),
              leading: const Icon(Icons.dark_mode, color: Colors.purple),
              trailing: Switch(
                value: _isDarkMode,
                onChanged: (val) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('isDarkMode', val);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      _isDarkMode = val;
                    });
                    Get.changeThemeMode(val ? ThemeMode.dark : ThemeMode.light);
                  });
                },
              ),
            ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          TextFormField(
            controller: controller,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            enabled: !disabledBorder,
            validator: validator,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
