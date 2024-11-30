import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/create%20account/add_events.dart';
import 'package:flutter_application_99/screens/event_details.dart';
import 'package:flutter_application_99/screens/events_screen.dart';
import 'package:flutter_application_99/screens/filter_events_screen.dart';
import 'package:flutter_application_99/screens/home_screen.dart';
import 'package:flutter_application_99/screens/sign_In_screen.dart';
import 'package:flutter_application_99/screens/organiston_registrar_screen.dart';
import 'package:flutter_application_99/screens/organiztion_screen.dart';
import 'package:flutter_application_99/screens/profile_screen.dart';
import 'package:get/get.dart';
// Uncommenting SharedPreferences if needed later
// import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences sharedpref = await SharedPreferences.getInstance();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/EventDetails',
      getPages: [
        GetPage(
          name: '/HomeScreen',
          page: () => HomeScreen(),
        ),
        GetPage(
          name: '/SignInScreen',
          page: () => const SignInScreen(),
        ),
        GetPage(
          name: '/ProfileScreen',
          page: () => const ProfileScreen(),
        ),
        GetPage(
          name: '/OrganizationScreen',
          page: () => const OrganizationScreen(),
        ),
        GetPage(
          name: '/FilterEventsScreen',
          page: () => const FilterEventsScreen(),
        ),
        GetPage(
          name: '/OrganistonRegistrarScreen',
          page: () => OrganistonRegistrarScreen(),
        ),
        GetPage(
          name: '/EventsScreen',
          page: () => const EventsScreen(),
        ),
        GetPage(
          name: '/AddEvents',
          page: () => const AddEvents(),
        ),
        GetPage(
          name: '/EventDetails',
          page: () => const EventDetails(),
        ),
      ],
    );
  }
}
