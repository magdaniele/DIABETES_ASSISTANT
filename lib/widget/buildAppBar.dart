// ignore_for_file: prefer_const_literals_to_create_immutables, file_names, use_full_hex_values_for_flutter_colors

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:diabetes_assistant/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  const icon = CupertinoIcons.moon_stars;
  return AppBar(
    /* leading: BackButton(
    color: isDarkMode? Colors.white:Colors.black,
    onPressed: ()=> {
            Navigator.pop(context)
          },), */
    backgroundColor: const Color(0xff8215466),
    elevation: 0,
    actions: [
      ThemeSwitcher(
        builder: (context) => IconButton(
          icon: const Icon(icon, color: Colors.white),
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
