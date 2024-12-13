import 'package:flutter/material.dart';
import 'package:flutter_application_99/Getx/AuthviewModel.dart';
import 'package:flutter_application_99/Loginuser.dart';
import 'package:flutter_application_99/user_home.dart';
import 'package:flutter_application_99/view_model/Home_view_model.dart';
import 'package:get/get.dart';

class Controllview extends GetView<Authviewmodel> {
  const Controllview({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<Authviewmodel>().user.value == null)
          ? CreateUser()
          : GetBuilder<HomeViewModel>(
              builder: (controller) => Scaffold(
                body: controller.currentScreen,
                bottomNavigationBar: bottomNavigationBar(),
              ),
            );
    });
  }

  Widget bottomNavigationBar() {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
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
          controller.changeSelectedValue(index);
          print(controller.navigatorValue);
        },
        elevation: 0,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.grey.shade50,
      ),
    );
  }
}
   // : GetBuilder<HomeViewModel>(
      //     builder: (controller) => Scaffold(
      //           body: controller.currentScreen, // الشاشة الحالية
      //           bottomNavigationBar: GetBuilder<HomeViewModel>(
      //             init: HomeViewModel(),
      //             builder: (controller) => BottomNavigationBar(
      //               items: [
      //                 BottomNavigationBarItem(
      //                   activeIcon: const Padding(
      //                     padding: EdgeInsets.only(top: 25),
      //                     child: Text("Home"),
      //                   ),
      //                   label: "",
      //                   icon: Padding(
      //                     padding: const EdgeInsets.only(top: 20),
      //                     child: Image.asset(
      //                       'assets/images/Image/home-05.png',
      //                       fit: BoxFit.contain,
      //                       width: 30,
      //                     ),
      //                   ),
      //                 ),
      //                 BottomNavigationBarItem(
      //                   activeIcon: const Padding(
      //                     padding: EdgeInsets.only(top: 25),
      //                     child: Text("Event"),
      //                   ),
      //                   label: "",
      //                   icon: Padding(
      //                     padding: const EdgeInsets.only(top: 20),
      //                     child: Image.asset(
      //                       'assets/images/Image/Calendar_duotone_line.png',
      //                       fit: BoxFit.contain,
      //                       width: 30,
      //                     ),
      //                   ),
      //                 ),
      //                 BottomNavigationBarItem(
      //                   activeIcon: const Padding(
      //                     padding: EdgeInsets.only(top: 25),
      //                     child: Text("Organization"),
      //                   ),
      //                   label: "",
      //                   icon: Padding(
      //                     padding: const EdgeInsets.only(top: 20),
      //                     child: Image.asset(
      //                       'assets/images/Image/server-02.png',
      //                       fit: BoxFit.contain,
      //                       width: 30,
      //                     ),
      //                   ),
      //                 ),
      //                 BottomNavigationBarItem(
      //                   activeIcon: const Padding(
      //                     padding: EdgeInsets.only(top: 25),
      //                     child: Text("User"),
      //                   ),
      //                   label: "",
      //                   icon: Padding(
      //                     padding: const EdgeInsets.only(top: 20),
      //                     child: Image.asset(
      //                       'assets/images/Image/User_scan_duotone_line.png',
      //                       fit: BoxFit.contain,
      //                       width: 30,
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //               currentIndex: controller.navigatorValue,
      //               onTap: (index) {
      //                 controller.ChangeSelectedValue(index);
      //               },
      //               elevation: 0,
      //               selectedItemColor: Colors.black,
      //               backgroundColor: Colors.grey.shade50,
      //             ),
      //           ),
      //         ));
