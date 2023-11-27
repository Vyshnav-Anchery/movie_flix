import 'package:flutter/material.dart';

class AppConstants {
  static ThemeData appTheme = ThemeData(
    primaryColor: Colors.amber,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.orange),
    scaffoldBackgroundColor: Colors.orangeAccent,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.orange, elevation: 3),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
    useMaterial3: true,
  );
}
