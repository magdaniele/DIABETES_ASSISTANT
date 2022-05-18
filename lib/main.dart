// ignore_for_file: prefer_const_constructors, prefer_const_declarations, use_key_in_widget_constructors

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
//import 'package:diabetes_assistant/pages/login.dart';
//import 'package:diabetes_assistant/privatePages/editUserProfile.dart';
import 'package:diabetes_assistant/privatePages/profile.dart';
import 'package:diabetes_assistant/themes.dart';
import 'package:diabetes_assistant/utils/userPreferences.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = userPreferences.myUser;
    return ThemeProvider(
      initTheme: user.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
        child: Builder(
            builder: (context) => MaterialApp(
              debugShowCheckedModeBanner: false,
                  theme: user.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
                  title: 'Login Demo',
                  home: userProfile(),
                  scrollBehavior: ScrollBehavior(),
                )));
  }
}
