import 'package:flutter/cupertino.dart';
import 'package:flutter_application_99/events_screen.dart';
import 'package:flutter_application_99/user_home.dart'; // الواجهة الرئيسية
import 'package:flutter_application_99/filter.dart'; // واجهة الفلترة
import 'package:flutter_application_99/user_profile.dart'; // واجهة الملف الشخصي
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  int _navigatorValue = 0;

  get navigatorValue => _navigatorValue;

  Widget currentScreen = const Home();

  void changeSelectedValue(int selectedValue) {
    _navigatorValue = selectedValue;
    switch (selectedValue) {
      case 0:
        currentScreen = const Home();
        break;
      case 1:
        currentScreen = const EventsScreen();
        break;
      case 2:
        currentScreen = const FilterEventsScreen();
        break;
      case 3:
        currentScreen =  ProfileScreen();
        break;
      default:
        currentScreen = const Home();
    }
    update(); //
    print(currentScreen);
  }
}
