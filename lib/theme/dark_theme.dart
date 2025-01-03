import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
  ),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xff221F25),
    secondary: Color(0xFF332B2A),
    surface: Color(0xff4E4755),
  ),
  //text color
  textTheme: const TextTheme(
    titleMedium: TextStyle(color: Colors.white),
  ),
);
