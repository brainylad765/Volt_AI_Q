import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xFF0A0E1A),
    primaryColor: const Color(0xFF1B4F8A),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF1B4F8A),
      secondary: Color(0xFF00BCD4),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0A0E1A),
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
    ),
  );
}