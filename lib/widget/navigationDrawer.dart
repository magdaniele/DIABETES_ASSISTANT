// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, file_names, unused_import
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:diabetes_assistant/model/user.dart';
import 'package:diabetes_assistant/pages/login.dart';
import 'package:diabetes_assistant/privatePages/alarm.dart';
import 'package:diabetes_assistant/privatePages/appointment.dart';
import 'package:diabetes_assistant/privatePages/calculator.dart';
//import 'package:diabetes_assistant/privatePages/alarm.dart';
import 'package:diabetes_assistant/privatePages/diet.dart';
import 'package:diabetes_assistant/privatePages/home.dart';
import 'package:diabetes_assistant/privatePages/profile.dart';
import 'package:diabetes_assistant/privatePages/settings.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diabetes_assistant/utils/userPreferences.dart';
import 'package:provider/provider.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            builderHeader(context),
            builderMenuItems(context),
          ],
        )),
      );

  Widget builderHeader(BuildContext context) => Material(
        color: Color(0xFF8215466),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const userProfile()));
          },
          child: Container(
            color: Color(0xFF8215466),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
            child: Consumer<UserPreferences>(
                builder: (context, userPreferences, child) {
              UserModel user = userPreferences.user!;
              return Column(children: [
                SizedBox(
                  height: 24,
                ),
                CircleAvatar(
                  radius: 51.5,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      user.imagePath! == ''
                          ? 'assets/defaultProfileImg.jpg'
                          : user.imagePath!,
                    ),
                    radius: 50.0,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  user.firstName! + ' ' + user.secondName!,
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
                Text(
                  user.email!,
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                SizedBox(
                  height: 24,
                ),
              ]);
            }),
          ),
        ),
      );

  Widget builderMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Consejos'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Perfil'),
            onTap: () => {
              Navigator.pop(context),
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const userProfile()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.brunch_dining),
            title: const Text('Glucemia diaria'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => DietPage(child: build(context))),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.alarm),
            title: const Text('Alarmas'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Alarm()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.calculate_outlined),
            title: const Text('Calculadora'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Calculator()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat_outlined),
            title: const Text('Habla con tu doctor'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Appointment()),
              );
            },
          ),
          const Divider(color: Colors.black),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar sesión'),
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) => {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: ((context) => Login())))
                  });
            },
          ),
        ],
      ));
}
