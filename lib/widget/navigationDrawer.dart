// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, file_names, unused_import
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:diabetes_assistant/privatePages/alarm.dart';
import 'package:diabetes_assistant/privatePages/appointment.dart';
import 'package:diabetes_assistant/privatePages/calculator.dart';
//import 'package:diabetes_assistant/privatePages/alarm.dart';
import 'package:diabetes_assistant/privatePages/diet.dart';
import 'package:diabetes_assistant/privatePages/home.dart';
import 'package:diabetes_assistant/privatePages/profile.dart';
import 'package:diabetes_assistant/privatePages/settings.dart';
import 'package:flutter/material.dart';
import 'package:diabetes_assistant/utils/userPreferences.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);
  final user = userPreferences.myUser;
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
            child: Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                CircleAvatar(
                    radius: 51.5,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(user.imagePath),
                      radius: 50.0,
                    ),
                    ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  user.name,
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
                Text(
                  user.email,
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      );

  Widget builderMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Profile'),
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
                  MaterialPageRoute(builder: (context) =>DietPage(child: build(context),))
                  );
            },
          ),
          ListTile(
            leading: const Icon(Icons.alarm),
            title: const Text('Notificar Medicamento'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Alarm())
                  );
            },
          ),
          ListTile(
            leading: const Icon(Icons.calculate_outlined),
            title: const Text('Calculator'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Calculator())
                  );
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat_outlined),
            title: const Text('Chat with your doctor'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Appointment())
                  );
            },
          ),
          const Divider(color: Colors.black),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Configuration'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Settings())
                  );
            },
          ),
        ],
      ));
}
