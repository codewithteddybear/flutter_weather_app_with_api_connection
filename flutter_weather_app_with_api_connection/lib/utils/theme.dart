import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.dark(
      brightness: Brightness.light,
      primary: Colors.blue[400]!,
      secondary: Colors.blue[700]!),
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 65),
    titleMedium: TextStyle(fontSize: 43),
    titleSmall: TextStyle(fontSize: 28),
    labelMedium: TextStyle(fontSize: 24),
    labelSmall: TextStyle(fontSize: 20),
  ),
  primaryColor: Colors.white,
  scaffoldBackgroundColor: const Color(0x010A19FF),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
    size: 42,
  ),
  primaryColorDark: const Color(0x010A19FF),
  useMaterial3: true,
);
