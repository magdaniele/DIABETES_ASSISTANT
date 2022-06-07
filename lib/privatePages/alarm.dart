// ignore_for_file: use_full_hex_values_for_flutter_colors, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, unused_local_variable, unused_field

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:diabetes_assistant/main.dart';
import 'package:diabetes_assistant/model/alarmInfo.dart';
import 'package:diabetes_assistant/themes.dart';
import 'package:diabetes_assistant/utils/alarmData.dart';
import 'package:diabetes_assistant/widget/navigationDrawer.dart';
import 'package:dotted_border/dotted_border.dart';
//import 'package:diabetes_assistant/model/user.dart';
//import 'package:diabetes_assistant/utils/userPreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class Alarm extends StatefulWidget {
  const Alarm({Key? key}) : super(key: key);
  @override
  _Alarm createState() => _Alarm();
  //final User user = userPreferences.myUser;
  final icon = CupertinoIcons.moon_stars;
}

class _Alarm extends State<Alarm> {
  DateTime? _alarmTime;
  String? _alarmTimeString;
  Future<List<AlarmInfo>>? _alarms;
  List<AlarmInfo>? _currentAlarms;
  bool isInstructionView = false;

  @override
  void initState() {
    _alarmTime = DateTime.now();
    loadAlarms();
    super.initState();
  }

  void loadAlarms() {
    _alarms = getAlarms();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Notificar medicamento'),
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
                      var alarmTime =
                          DateFormat('hh:mm a').format(alarm.alarmDateTime!);
                      var gradientColor = GradientTemplate
                          .gradientTemplate[alarm.gradientColorIndex!].colors;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 32),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: gradientColor),
                          boxShadow: [
                            BoxShadow(
                                color: gradientColor.last.withOpacity(0.4),
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
                                          alarm.title!,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'avenir'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Switch(
                                  value: alarm.isActive!,
                                  onChanged: (bool value) {
                                    setState(() {
                                      alarm.isActive = value;
                                    });
                                  },
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
                                IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Colors.white,
                                    onPressed: () {
                                      deleteAlarm(alarm.alarmId!);
                                    }),
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
                              _alarmTimeString =
                                  DateFormat('HH:mm').format(DateTime.now());
                              showModalBottomSheet(
                                useRootNavigator: true,
                                context: context,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(24),
                                  ),
                                ),
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context, setModalState) {
                                      return Container(
                                        padding: const EdgeInsets.all(32),
                                        color: const Color(0xffE5F3F5),
                                        child: Column(
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary:
                                                      const Color(0xff8215466)),
                                              onPressed: () async {
                                                var selectedTime =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                );
                                                if (selectedTime != null) {
                                                  final now = DateTime.now();
                                                  var selectedDateTime =
                                                      DateTime(
                                                          now.year,
                                                          now.month,
                                                          now.day,
                                                          selectedTime.hour,
                                                          selectedTime.minute);
                                                  _alarmTime = selectedDateTime;
                                                  setModalState(() {
                                                    _alarmTimeString =
                                                        DateFormat('HH:mm')
                                                            .format(
                                                                selectedDateTime);
                                                  });
                                                }
                                              },
                                              child: Text(
                                                _alarmTimeString!,
                                                style: TextStyle(fontSize: 32),
                                              ),
                                            ),
                                            ListTile(
                                              title: Text('Repeat'),
                                              trailing:
                                                  Icon(Icons.arrow_forward_ios),
                                            ),
                                            ListTile(
                                              title: Text('Sound'),
                                              trailing:
                                                  Icon(Icons.arrow_forward_ios),
                                            ),
                                            ListTile(
                                              title: Text('Title'),
                                              trailing:
                                                  Icon(Icons.arrow_forward_ios),
                                            ),
                                            FloatingActionButton.extended(
                                              onPressed: onSaveAlarm,
                                              icon: Icon(Icons.alarm),
                                              label: Text('Save'),
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  const Color(0xff8215466),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
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

  Future<List<AlarmInfo>> getAlarms() async {
    List<AlarmInfo> _alarms = [];
    return _alarms;
  }

  void onSaveAlarm() {
    scheduleAlarm();
/*    DateTime scheduleAlarmDateTime;
     if (_alarmTime.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else
      scheduleAlarmDateTime = _alarmTime.add(Duration(days: 1));

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: _currentAlarms.length,
      title: 'alarm',
    );
    _alarmHelper.insertAlarm(alarmInfo);
    scheduleAlarm(scheduleAlarmDateTime, alarmInfo);
    Navigator.pop(context);
    loadAlarms(); */
  }

  void deleteAlarm(String id) {
/*     _alarmHelper.delete(id);
    //unsubscribe for notification
    loadAlarms(); */
  }
}
