import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/createuser.dart';
import 'package:flutter_application_99/filter.dart';
import 'package:flutter_application_99/login.dart';
import 'package:flutter_application_99/organiston.dart';
import 'package:flutter_application_99/organiztion_screen.dart';
import 'package:flutter_application_99/profile.dart';
import 'package:get/get.dart';
// Uncommenting SharedPreferences if needed later
// import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences sharedpref = await SharedPreferences.getInstance();

  runApp(DevicePreview(
      enabled: !kReleaseMode, builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/Login',
      getPages: [
        GetPage(name: '/Login', page: () => const Login()),
        GetPage(name: '/CreateUser', page: () => CreateUser()),
        GetPage(name: '/Organiston', page: () => Organiston()),
        GetPage(name: '/ProfileScreen', page: () => const ProfileScreen()),
        GetPage(
            name: '/OrganizationScreen',
            page: () => const OrganizationScreen()),
        GetPage(
            name: '/FilterEventsScreen',
            page: () => const FilterEventsScreen()),
      ],
    );
  }
}
