// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_99/Getx/AuthviewModel.dart';
// import 'package:flutter_application_99/Loginuser.dart';
// import 'package:flutter_application_99/view_model/Home_view_model.dart';
// import 'package:get/get.dart';

// class controll_home extends StatelessWidget {
//   const controll_home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeViewModel>(
//       init: HomeViewModel(),
//       builder: (controller) => Scaffold(
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         body: controller.currentScreen,
//         bottomNavigationBar: bottomNavigationBar(context), // Pass context here
//       ),
//     );
//   }
// }

// // Accept context as a parameter
// Widget bottomNavigationBar(BuildContext context) {
//   return GetBuilder<HomeViewModel>(
//     builder: (controller) => BottomNavigationBar(
//       backgroundColor: Theme.of(context).colorScheme.primary, // Now this works
//       items: [
//         BottomNavigationBarItem(
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           activeIcon: const Padding(
//             padding: EdgeInsets.only(top: 25),
//             child: Text("Home"),
//           ),
//           label: "",
//           icon: Padding(
//             padding: const EdgeInsets.only(top: 20),
//             child: Icon(
//               Icons.home,
//               color: Theme.of(context).colorScheme.onSurface,
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
//             child: Icon(
//               Icons.event,
//               color: Theme.of(context).colorScheme.onSurface,
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
//             child: Icon(
//               Icons.query_builder_sharp,
//               color: Theme.of(context).colorScheme.onSurface,
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
//             child: Icon(
//               Icons.person,
//               color: Theme.of(context).colorScheme.onSurface,
//             ),
//           ),
//         ),
//       ],
//       currentIndex: controller.navigatorValue,
//       onTap: (index) {
//         controller.changeSelectedValue(index); // Update screen on tap
//       },
//       elevation: 0,
//       selectedItemColor: Colors.black,
//     ),
//   );
// }




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
            child: Text("Filter"),
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
