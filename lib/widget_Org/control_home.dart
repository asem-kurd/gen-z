import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/Repetitions/appbarmenu.dart';
import 'package:flutter_application_99/Repetitions/grawer__list.dart';
import 'package:flutter_application_99/view_model/Home_view_model.dart';
import 'package:get/get.dart';

class ControllHomeOrg extends GetWidget<HomeViewModel> {
  const ControllHomeOrg({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) => Scaffold(
        body: controller.currentScreen2,
        bottomNavigationBar: bottomNavigationBar2(),
      ),
    );
  }
}

Widget bottomNavigationBar2() {
  final FirebaseAuth auth2 = FirebaseAuth.instance;

  return GetBuilder<HomeViewModel>(
    init: HomeViewModel(),
    builder: (controller) => Stack(
      children: [
        Positioned.fill(
          child: Container(
            height: 1, // تقليل الارتفاع لجعل الحجم أصغر
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(71, 136, 124, 176),
                  Color.fromARGB(48, 194, 130, 27),
                  Color.fromARGB(55, 251, 134, 0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        // الـ BottomNavigationBar
        SafeArea(
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                activeIcon: const Padding(
                  padding: EdgeInsets.only(top: 15), // تقليل المسافة العلوية
                  child: Text(
                    "ADD Event",
                    style: TextStyle(fontSize: 12), // تصغير النص
                  ),
                ),
                label: "",
                icon: Padding(
                  padding:
                      const EdgeInsets.only(top: 15), // تقليل المسافة العلوية
                  child: Image.asset(
                    'assets/images/Image/dell_square.png',
                    fit: BoxFit.contain,
                    width: 20, // تصغير الأيقونة
                  ),
                ),
              ),
              BottomNavigationBarItem(
                activeIcon: const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    "All Organization",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                label: "",
                icon: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Image.asset(
                    'assets/images/Image/Calendar_duotone_line.png',
                    fit: BoxFit.contain,
                    width: 20,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                activeIcon: const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    "Profile",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                label: "",
                icon: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Image.asset(
                    'assets/images/Image/User_scan_duotone_line.png',
                    fit: BoxFit.contain,
                    width: 20,
                  ),
                ),
              ),
            ],
            currentIndex: controller.navigatorValue,
            onTap: (index) async {
              controller.changeSelectedValue_org(index);
            },
            elevation: 0,
            selectedItemColor: Colors.black,
            backgroundColor: Colors.transparent,
          ),
        ),
      ],
    ),
  );
}
