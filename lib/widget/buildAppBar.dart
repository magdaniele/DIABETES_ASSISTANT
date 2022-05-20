// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:diabetes_assistant/model/user.dart';
import 'package:diabetes_assistant/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  const icon = CupertinoIcons.moon_stars;
  return AppBar(
    leading: BackButton(
    color: isDarkMode? Colors.white:Colors.black,
    onPressed: ()=> {
            Navigator.pop(context)
          },),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      ThemeSwitcher(
        builder: (context) => IconButton(
          icon: Icon(icon, color: isDarkMode? Colors.white:Colors.black,),
          onPressed: () {
            final theme = isDarkMode ? MyThemes.lightTheme : MyThemes.darkTheme;
            final switcher = ThemeSwitcher.of(context);
            switcher.changeTheme(theme: theme);
          },
        ),
      ),
    ],
  );
}
