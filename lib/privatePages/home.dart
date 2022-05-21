// ignore_for_file: prefer_const_constructors

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:diabetes_assistant/privatePages/profile.dart';
import 'package:flutter/material.dart';
import 'package:diabetes_assistant/utils/userPreferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ThemeSwitchingArea(
        child: Builder(
            builder: (context) =>Scaffold(
        appBar: AppBar(
            title: const Text('Home'), backgroundColor: Color(0xFF8215466)),
        drawer: const NavigationDrawer(),
      ),
      ),
      );
}

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
            onTap: () {},
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
            leading: const Icon(Icons.calculate_outlined),
            title: const Text('Calculator'),
            onTap: () {},
          ),
          const Divider(color: Colors.black),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Configuration'),
            onTap: () {},
          ),
        ],
      ));
}
