import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_99/Getx/Binding.dart';
import 'package:flutter_application_99/Getx/controllview.dart';
import 'package:flutter_application_99/Repetitions/grawer__list.dart';
import 'package:flutter_application_99/SetProfilePicture.dart';
import 'package:flutter_application_99/controll_home.dart';
import 'package:flutter_application_99/org_reg.dart';
import 'package:flutter_application_99/test_add_updata.dart';
import 'package:flutter_application_99/user_home.dart';
import 'package:flutter_application_99/Loginuser.dart';
import 'package:flutter_application_99/filter.dart';
import 'package:flutter_application_99/user_reg.dart';
import 'package:flutter_application_99/user_profile.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ytphxgjkdgxnxruyvabg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl0cGh4Z2prZGd4bnhydXl2YWJnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI5MDA5NzAsImV4cCI6MjA0ODQ3Njk3MH0.w0kLk6umPbLzIeTCBXZkCkkUXCsaCxt7aQ2GCALqxlw',
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAn087P6e8cw3ZzxUjmTIALbJB16FEAtB8",
      appId: "1:174277723262:android:e36b695589a729a0eb042f",
      messagingSenderId: "174277723262",
      projectId: "gen-z2024",
    ),
  );
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Enable DevicePreview only in debug mode
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
      initialBinding: InitialBinding(),
      home: Scaffold(
        body: CreateUser(),
      ),
      theme: ThemeData(
        fontFamily: 'SourceSans',
      ),
    );
  }
}
