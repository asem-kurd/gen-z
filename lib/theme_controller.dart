import 'package:flutter/material.dart';
import 'package:flutter_application_99/main.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  static const String themeKey = "ThemeMode";

  late ThemeMode currentThemeMode;

  @override
  void onInit() {
    super.onInit();
    _loadTheme(); // Load the theme during initialization
  }

  void _loadTheme() {
    final savedTheme = sharepref!.getString(themeKey);
    if (savedTheme == "dark") {
      currentThemeMode = ThemeMode.dark;
      Get.changeTheme(ThemeData.dark());
    } else {
      currentThemeMode = ThemeMode.light;
      Get.changeTheme(ThemeData.light());
    }
  }

  void toggleTheme() {
    if (currentThemeMode == ThemeMode.light) {
      currentThemeMode = ThemeMode.dark;
      sharepref!.setString(themeKey, "dark");
      Get.changeTheme(ThemeData.dark());
    } else {
      currentThemeMode = ThemeMode.light;
      sharepref!.setString(themeKey, "light");
      Get.changeTheme(ThemeData.light());
    }
    update(); // Notify listeners about the change
  }

  ThemeMode getThemeMode() {
    return currentThemeMode;
  }
}
