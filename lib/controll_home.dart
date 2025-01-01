import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/Getx/AuthviewModel.dart';
import 'package:flutter_application_99/Loginuser.dart';
import 'package:flutter_application_99/view_model/Home_view_model.dart';
import 'package:get/get.dart';

class controll_home extends StatelessWidget {
  const controll_home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) => Scaffold(
        body: controller.currentScreen,
        bottomNavigationBar: bottomNavigationBar(),
      ),
    );
  }
}

Widget bottomNavigationBar() {
  return GetBuilder<HomeViewModel>(
    builder: (controller) => BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          activeIcon: const Padding(
            padding: EdgeInsets.only(top: 25),
            child: Text("Home"),
          ),
          label: "",
          icon: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Image.asset(
              'assets/images/Image/home-05.png',
              fit: BoxFit.contain,
              width: 30,
            ),
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: const Padding(
            padding: EdgeInsets.only(top: 25),
            child: Text("Event"),
          ),
          label: "",
          icon: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Image.asset(
              'assets/images/Image/Calendar_duotone_line.png',
              fit: BoxFit.contain,
              width: 30,
            ),
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: const Padding(
            padding: EdgeInsets.only(top: 25),
            child: Text("Organization"),
          ),
          label: "",
          icon: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Image.asset(
              'assets/images/Image/server-02.png',
              fit: BoxFit.contain,
              width: 30,
            ),
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: const Padding(
            padding: EdgeInsets.only(top: 25),
            child: Text("User"),
          ),
          label: "",
          icon: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Image.asset(
              'assets/images/Image/User_scan_duotone_line.png',
              fit: BoxFit.contain,
              width: 30,
            ),
          ),
        ),
      ],
      currentIndex: controller.navigatorValue,
      onTap: (index) {
        controller
            .changeSelectedValue(index); // تحديث الشاشة عند الضغط على العنصر
      },
      elevation: 0,
      selectedItemColor: Colors.black,
      backgroundColor: Colors.transparent, // التأكد من أن التدرج يظهر
    ),
  );
}
