import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_99/Getx/EventController.dart';
import 'package:flutter_application_99/admin/admin.dart';
import 'package:flutter_application_99/admin/delete_member.dart';
import 'package:flutter_application_99/admin/delete_member2.dart';
import 'package:flutter_application_99/events_screen.dart';
import 'package:flutter_application_99/filter.dart';
import 'package:flutter_application_99/taple_firebase/user_taple.dart';
import 'package:flutter_application_99/user_home.dart';
import 'package:flutter_application_99/user_profile.dart';
import 'package:flutter_application_99/view_model/org_profile.dart';
import 'package:flutter_application_99/widget_Org/Add_event.dart';
import 'package:flutter_application_99/widget_Org/Org_desplay.dart';
import 'package:flutter_application_99/widget_Org/display_org.dart';
import 'package:flutter_application_99/widget_Org/home_org.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  int _navigatorValue = 0;

  get navigatorValue => _navigatorValue;

  Widget currentScreen = Home();
  Widget currentScreen2 = AddEvent();
  Widget currentScreen3 = Admin();

  void changeSelectedValue(int selectedValue) {
    _navigatorValue = selectedValue;
    switch (selectedValue) {
      case 0:
        currentScreen = Home(); // تأكد من أن هذه الشاشة موجودة
        break;
      case 1:
        currentScreen = const EventsScreen();
        break;
      case 2:
        currentScreen = DisplayOrg();
        break;
      case 3:
        currentScreen =  ProfileScreen();
        break;
      default:
        currentScreen = Home();
    }
    update(); // تأكد من استدعاء update هنا لتحديث الواجهة
    print(currentScreen); // للتأكد من أن الشاشة تم تغييرها
  }

  void changeSelectedValue_org(int selectedValue2) {
    _navigatorValue = selectedValue2;
    User? currentUser = FirebaseAuth.instance.currentUser;
    String? userId = currentUser?.uid;

    switch (selectedValue2) {
      case 0:
        currentScreen2 = AddEvent();
        break;
      case 1:
        currentScreen2 = DisplayOrg_user();
        break;
      case 2:
        if (userId != null) {
          currentScreen2 = OrgProfile(userId: userId);
        } else {
          Get.snackbar("Error", "User ID is null");
        }
        break;
      default:
        currentScreen2 = AddEvent();
    }
    update();
    print(currentScreen2);
  }

  void changeSelectedValue_admin(int selectedValue3) {
    _navigatorValue = selectedValue3;
    switch (selectedValue3) {
      case 0:
        currentScreen3 = Admin();
        break;
      case 1:
        currentScreen3 = MemberScreen2();
        break;

      default:
        currentScreen3 = Admin();
    }
    update();
    print(currentScreen3);
  }
}
