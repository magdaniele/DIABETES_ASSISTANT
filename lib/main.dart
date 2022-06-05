// ignore_for_file: prefer_const_constructors, prefer_const_declarations, use_key_in_widget_constructors

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:diabetes_assistant/pages/login.dart';
//import 'package:diabetes_assistant/privatePages/home.dart';
//import 'package:diabetes_assistant/privatePages/diet.dart';
//import 'package:diabetes_assistant/privatePages/alarm.dart';
//import 'package:diabetes_assistant/privatePages/editUserProfile.dart';
//import 'package:diabetes_assistant/privatePages/editUserProfile.dart';
//import 'package:diabetes_assistant/privatePages/profile.dart';
import 'package:diabetes_assistant/themes.dart';
import 'package:diabetes_assistant/utils/userPreferences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'privatePages/home.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int? id, String? title, String? body, String? payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });
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
                  theme: user.isDarkMode
                      ? MyThemes.darkTheme
                      : MyThemes.lightTheme,
                  title: 'Diabetes Assistant',
                  home: StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData && (!snapshot.data!.isAnonymous)) {
                        return HomePage();
                      } else {
                        return Login();
                      }
                    },
                  ),
                  scrollBehavior: ScrollBehavior(),
                )));
  }
}
