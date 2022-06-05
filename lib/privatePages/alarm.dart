// ignore_for_file: use_full_hex_values_for_flutter_colors, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, unused_local_variable

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:diabetes_assistant/main.dart';
import 'package:diabetes_assistant/utils/alarmData.dart';
import 'package:diabetes_assistant/widget/navigationDrawer.dart';
import 'package:dotted_border/dotted_border.dart';
//import 'package:diabetes_assistant/model/user.dart';
//import 'package:diabetes_assistant/utils/userPreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
          drawer: NavigationDrawer(),
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
                          gradient:
                              LinearGradient(colors: alarm.gradientColors),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    alarm.gradientColors.last.withOpacity(0.4),
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: Offset(4, 4))
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
                        dashPattern: [5, 4],
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xFF245466),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24))),
                          child: MaterialButton(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 8),
                            onPressed: () {
                              scheduleAlarm();
                            },
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/AddIcon.png',
                                  scale: 1.5,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
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

  Future<void> scheduleAlarm() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 10));

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'Channel for Alarm notification',
      icon: '@mipmap/ic_launcher',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      sound: 'a_long_cold_sting.mp3',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    var platfromChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Hora de la insulina',
        'Ya es hora de que tomes 15 mg de insulina',
        scheduledNotificationDateTime,
        platfromChannelSpecifics);
  }
}
