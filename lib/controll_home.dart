// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_99/Getx/AuthviewModel.dart';
// import 'package:flutter_application_99/Loginuser.dart';
// import 'package:flutter_application_99/view_model/Home_view_model.dart';
// import 'package:get/get.dart';

// import 'package:flutter_application_99/Repetitions/theme_service.dart';

// import 'admin/controll_admin.dart';

// class controll_home extends StatelessWidget {
//   const controll_home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeViewModel>(
//       init: HomeViewModel(),
//       builder: (controller) => Scaffold(
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         body: controller.currentScreen,
//         bottomNavigationBar: bottomNavigationBar(),
//       ),
//     );
//   }
// }

// Widget bottomNavigationBar() {
//   return GetBuilder<HomeViewModel>(
//           // backgroundColor: Theme.of(context).colorScheme.primary,

//     builder: (controller) => BottomNavigationBar(
//             backgroundColor: Theme.of(context).colorScheme.primary,

//       items: [
//         BottomNavigationBarItem(
//           activeIcon: const Padding(
//             padding: EdgeInsets.only(top: 25),
//             child: Text("Home"),
//           ),
//           label: "",
//           icon: Padding(
//             padding: const EdgeInsets.only(top: 20),
//             child: Image.asset(
//               'assets/images/Image/home-05.png',
//               fit: BoxFit.contain,
//               width: 30,
//             ),
//           ),
//         ),
//         BottomNavigationBarItem(
//           activeIcon: const Padding(
//             padding: EdgeInsets.only(top: 25),
//             child: Text("Event"),
//           ),
//           label: "",
//           icon: Padding(
//             padding: const EdgeInsets.only(top: 20),
//             child: Image.asset(
//               'assets/images/Image/Calendar_duotone_line.png',
//               fit: BoxFit.contain,
//               width: 30,
//             ),
//           ),
//         ),
//         BottomNavigationBarItem(
//           activeIcon: const Padding(
//             padding: EdgeInsets.only(top: 25),
//             child: Text("Organization"),
//           ),
//           label: "",
//           icon: Padding(
//             padding: const EdgeInsets.only(top: 20),
//             child: Image.asset(
//               'assets/images/Image/server-02.png',
//               fit: BoxFit.contain,
//               width: 30,
//             ),
//           ),
//         ),
//         BottomNavigationBarItem(
//           activeIcon: const Padding(
//             padding: EdgeInsets.only(top: 25),
//             child: Text("User"),
//           ),
//           label: "",
//           icon: Padding(
//             padding: const EdgeInsets.only(top: 20),
//             child: Image.asset(
//               'assets/images/Image/User_scan_duotone_line.png',
//               fit: BoxFit.contain,
//               width: 30,
//             ),
//           ),
//         ),
//       ],
//       currentIndex: controller.navigatorValue,
//       onTap: (index) {
//         controller
//             .changeSelectedValue(index); // تحديث الشاشة عند الضغط على العنصر
//       },
//       elevation: 0,

//       //change the color of bottom nav bar based on theme dar
//       selectedItemColor: Colors.black,
//       // backgroundColor: Colors.transparent,
//       // التأكد من أن التدرج يظهر
//     ),
//   );
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/Getx/AuthviewModel.dart';
import 'package:flutter_application_99/Loginuser.dart';
import 'package:flutter_application_99/view_model/Home_view_model.dart';
import 'package:get/get.dart';
import 'package:flutter_application_99/Repetitions/theme_service.dart';
import 'admin/controll_admin.dart';

class controll_home extends StatelessWidget {
  const controll_home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: controller.currentScreen,
        bottomNavigationBar: bottomNavigationBar(context), // Pass context here
      ),
    );
  }
}

// Accept context as a parameter
Widget bottomNavigationBar(BuildContext context) {
  return GetBuilder<HomeViewModel>(
    builder: (controller) => BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.primary, // Now this works
      items: [
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).colorScheme.primary,
          activeIcon: const Padding(
            padding: EdgeInsets.only(top: 25),
            child: Text("Home"),
          ),
          label: "",
          icon: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.onSurface,
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
            child: Icon(
              Icons.event,
              color: Theme.of(context).colorScheme.onSurface,
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
            child: Icon(
              Icons.query_builder_sharp,
              color: Theme.of(context).colorScheme.onSurface,
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
            child: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ],
      currentIndex: controller.navigatorValue,
      onTap: (index) {
        controller.changeSelectedValue(index); // Update screen on tap
      },
      elevation: 0,
      selectedItemColor: Colors.black,
    ),
  );
}
