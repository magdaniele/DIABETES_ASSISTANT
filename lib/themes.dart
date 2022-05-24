// ignore_for_file: prefer_const_declarations

import 'package:flutter/material.dart';

class MyThemes {
  static final primary = Colors.blueAccent;
  static final primaryColor = Colors.blue.shade300;

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColorDark: primaryColor,
    colorScheme: ColorScheme.dark(primary: primary),
    dividerColor: Colors.white,
    
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColorDark: primaryColor,
    colorScheme: ColorScheme.light(primary: primary),
    dividerColor: Colors.black,
  );
  
}

class GradientColors {
  static List<Color> sky = [Color(0XFF6448FE), Color(0xFF5FC6FF)];
  static List<Color> suncet = [Color(0XFFFE6197), Color(0xFFFFB463)];
  static List<Color> sea = [Color(0XFFFFA738), Color(0xFF63FFD5)];
  static List<Color> sfire = [Color(0XFFFF5DCD), Color(0xFFFF8484)];
}