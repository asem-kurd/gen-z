// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// class ThemeService {
//   final lightTheme = ThemeData.light().copyWith(
//     primaryColor: const Color(0xffFCDFC8),
//     appBarTheme: const AppBarTheme(),
//     dividerColor: Colors.black,
//   );

//   final darkTheme = ThemeData.dark().copyWith(
//     primaryColor: Colors.blue,
//     appBarTheme: const AppBarTheme(),
//     dividerColor: Colors.white,
//   );

//   final _getStorage = GetStorage();
//   final _darkThemeKey = 'isDarkTheme';

//   void saveThemeData(bool isDarkMode) {
//     _getStorage.write(_darkThemeKey, isDarkMode);
//   }

//   bool isSavedDarkMode() {
//     return _getStorage.read(_darkThemeKey) ?? false;
//   }

//   ThemeMode getThemeMode() {
//     return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
//   }

//   void changeTheme() {
//     Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
//     saveThemeData(!isSavedDarkMode());
//   }
// }







import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  /// ********************LIGHT THEME************************************
  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFFFFFF), // White app bar
      foregroundColor: Colors.black, // Black text/icons
    ),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFFFFFFF), // White primary color
      secondary: Color(0xFF332B2A), // Deep brown secondary color
      surface: Color(0xFFE0E0E0), // Text/icons on background
      onPrimary: Colors.black, // Text/icons on primary
      onSecondary: Colors.white, // Text/icons on secondary
      onSurface: Colors.black, // Text/icons on surface
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black), // Body text
    ),
  );
  /**********************LIGHT THEME*************************************/

  /// ********************DARK THEME************************************
  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1C1C1E), // Dark grey app bar
      foregroundColor: Colors.white, // White text/icons
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF221F25), // Dark grey primary color
      secondary: Color(0xFF332B2A), // Deep brown secondary color
      surface: Color(0xFF373737), // Text/icons on background
      onPrimary: Colors.white, // Text/icons on primary
      onSecondary: Colors.black, // Text/icons on secondary
      onSurface: Colors.white, // Text/icons on surface
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white), // Body text
    ),
  );
  /// ********************DARK THEME************************************

  final _getStorage = GetStorage();
  final _darkThemeKey = 'isDarkTheme';

  void saveThemeData(bool isDarkMode) {
    _getStorage.write(_darkThemeKey, isDarkMode);
  }

  bool isSavedDarkMode() {
    return _getStorage.read(_darkThemeKey) ?? false;
  }

  ThemeMode getThemeMode() {
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  void changeTheme() {
    bool isDarkMode = isSavedDarkMode();
    Get.changeThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
    saveThemeData(!isDarkMode);
  }
}