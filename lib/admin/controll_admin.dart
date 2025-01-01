import 'package:flutter/material.dart';
import 'package:flutter_application_99/view_model/Home_view_model.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class ControllHomeadmin extends GetWidget<HomeViewModel> {
  const ControllHomeadmin({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) => Scaffold(
        body:
            controller.currentScreen3, // سيتم عرض هذه الشاشة بناءً على الاختيار
        bottomNavigationBar:
            bottomNavigationBar3(controller), // تم تمرير الـ controller هنا
      ),
    );
  }
}

Widget bottomNavigationBar3(HomeViewModel controller) {
  return GetBuilder<HomeViewModel>(
    init: HomeViewModel(),
    builder: (controller) => Stack(
      children: [
        Positioned.fill(
          child: Container(
            height: 1,
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
        SafeArea(
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                activeIcon: const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    "ADD Event",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                label: "",
                icon: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Image.asset(
                    'assets/images/Image/dell_square.png',
                    fit: BoxFit.contain,
                    width: 20,
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
            ],
            currentIndex: controller.navigatorValue,
            onTap: (index) {
              controller.changeSelectedValue_admin(index);
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
