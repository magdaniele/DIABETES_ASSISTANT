// ignore_for_file: use_full_hex_values_for_flutter_colors, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:diabetes_assistant/utils/alarmData.dart';
import 'package:diabetes_assistant/widget/navigationDrawer.dart';
import 'package:dotted_border/dotted_border.dart';
//import 'package:diabetes_assistant/model/user.dart';
//import 'package:diabetes_assistant/utils/userPreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alarm extends StatelessWidget {
  const Alarm({Key? key}) : super(key: key);
  //final User user = userPreferences.myUser;
  final icon = CupertinoIcons.moon_stars;

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Alarm'),
            backgroundColor: const Color(0xff8215466),
          ),
          drawer: const NavigationDrawer(),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /* const Text(
                  'Alarm',
                  style: TextStyle(
                      fontFamily: 'avenir',
                      fontWeight: FontWeight.w700,
                      fontSize: 24),
                ), */
                Expanded(
                  child: ListView(
                    children: alarms.map<Widget>((alarm) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 32),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: alarm.gradientColors),
                          boxShadow: [
                            BoxShadow(
                              color: alarm.gradientColors.last.withOpacity(0.4),
                              blurRadius: 8,
                              spreadRadius:  2,
                              offset: Offset(4,4)
                            )
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.label,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          alarm.description,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'avenir'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Switch(
                                  value: true,
                                  onChanged: (bool value) {},
                                  activeColor: Colors.white,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Mon-Fri',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'avenir')),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('07:00 AM',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'avenir',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24)),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).followedBy([
                      DottedBorder(
                        color: Color(0xFFAECFF),
                        strokeWidth: 3,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(24),
                        dashPattern: [5,4],
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                          color: Color(0xFF245466),
                            borderRadius: BorderRadius.all(Radius.circular(24))
                          ),
                          child: FlatButton(
                            padding: const EdgeInsets.symmetric(
                            horizontal: 32, 
                            vertical: 8),
                            onPressed: (){}, 
                          child: Column(
                            children: <Widget>[
                              Image.asset('assets/AddIcon.png',
                              scale: 1.5,
                              ),
                              SizedBox(height: 8,),
                              Text(
                                'Add Alarm',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'avenir',
                                ),
                              )
                            ],
                          ),
                          ),
                        ),
                      )
                    ]).toList(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
