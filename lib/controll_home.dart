import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/Getx/AuthviewModel.dart';
import 'package:flutter_application_99/Loginuser.dart';
import 'package:flutter_application_99/view_model/Home_view_model.dart';
import 'package:get/get.dart';

class controll_home extends GetWidget<HomeViewModel> {
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
    init: HomeViewModel(),
    builder: (controller) => Stack(
      children: [
        // خلفية التدرج اللوني
        Container(
          height: 70, // نفس ارتفاع الـ BottomNavigationBar
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
        // الـ BottomNavigationBar
        BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: EdgeInsets.only(top: 25),
                child: Text("25".tr),
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
              activeIcon: Padding(
                padding: EdgeInsets.only(top: 25),
                child: Text("33".tr),
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
              activeIcon: Padding(
                padding: EdgeInsets.only(top: 25),
                child: Text("34".tr),
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
              activeIcon: Padding(
                padding: EdgeInsets.only(top: 25),
                child: Text("35".tr),
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
            controller.changeSelectedValue(index);
            print(controller.navigatorValue);
          },
          elevation: 0,
          selectedItemColor: Colors.black,
          backgroundColor: Colors.transparent, // مهم لجعل التدرج يظهر
        ),
      ],
    ),
  );
}
