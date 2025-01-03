import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/Getx/Binding.dart';
import 'package:flutter_application_99/Loginuser.dart';
import 'package:flutter_application_99/Repetitions/theme_service.dart';
import 'package:flutter_application_99/admin/DisplayOrg_admin.dart';
import 'package:flutter_application_99/admin/controll_admin.dart';
import 'package:flutter_application_99/admin/delete_member.dart';
import 'package:flutter_application_99/controll_home.dart';
import 'package:flutter_application_99/theme/light_theme.dart';
import 'package:flutter_application_99/theme/dark_theme.dart';
import 'package:flutter_application_99/widget_Org/control_home.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
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
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> determineUserHome() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return CreateUser(); // إذا لم يكن هناك مستخدم مسجل الدخول
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final orgDoc = await FirebaseFirestore.instance
          .collection('Orgnaization')
          .doc(user.uid)
          .get();

      if (orgDoc.exists) {
        await prefs.setString('userType', 'organization');
        return const ControllHomeOrg(); // إذا كان المستخدم في مجموعة Organization
      }

      // تحقق من أن المستخدم هو في Users
      final userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        // حفظ حالة User في SharedPreferences
        await prefs.setString('userType', 'User');
        return const controll_home(); // إذا كان المستخدم في مجموعة Users
      }
      final adminDoc = await FirebaseFirestore.instance
          .collection('Admin')
          .doc(user.uid)
          .get();
      if (adminDoc.exists) {
        await prefs.setString('userType', 'Admin');
        return const ControllHomeadmin();
      }
    } catch (e) {
      debugPrint('Error fetching user data: $e');
    }

    return CreateUser(); // إذا لم يكن في أي من المجموعات
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeService().getThemeMode(),
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      home: FutureBuilder<Widget>(
        future: determineUserHome(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text('حدث خطأ أثناء تحميل البيانات.'),
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Scaffold(
              body: Center(
                child: Text('لا توجد بيانات متاحة.'),
              ),
            );
          }
          return snapshot.data!;
        },
      ),
      getPages: [
        GetPage(name: '/CreateUser', page: () => CreateUser()),
        GetPage(name: '/controll_home', page: () => const controll_home()),
        GetPage(name: '/ControllHomeOrg', page: () => const ControllHomeOrg()),
        GetPage(
            name: '/ControllHomeadmin', page: () => const ControllHomeadmin()),
      ],
    );
  }
}
