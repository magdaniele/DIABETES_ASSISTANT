// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:diabetes_assistant/privatePages/home.dart';
//import 'package:diabetes_assistant/model/user.dart';
//import 'package:diabetes_assistant/utils/userPreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Appointment extends StatelessWidget{
  const Appointment({Key? key}) : super(key: key);
  //final User user = userPreferences.myUser;
  final icon = CupertinoIcons.moon_stars;


  @override
  Widget build (BuildContext context){ 
    return ThemeSwitchingArea(
        child: Builder(
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text('Appointments'),
                backgroundColor: const Color(0xff8215466),
              ),
              body: const Text('Appointments Page'),
              drawer: const NavigationDrawer()
            ),
            ),
            );}
}