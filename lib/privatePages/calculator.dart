// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:diabetes_assistant/privatePages/home.dart';
//import 'package:diabetes_assistant/model/user.dart';
//import 'package:diabetes_assistant/themes.dart';
import 'package:diabetes_assistant/utils/userPreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calculator extends StatelessWidget{
  const Calculator({Key? key}) : super(key: key);
  final user = userPreferences.myUser;
    final icon = CupertinoIcons.moon_stars;


  @override
  Widget build (BuildContext context){ 
    return ThemeSwitchingArea(
        child: Builder(
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text('Calculator'),
                backgroundColor: const Color(0xFF8215466),
              ),
               drawer: const NavigationDrawer(),
              body: const Text('Calculator Page'),
            ),
            ),
            );}
}