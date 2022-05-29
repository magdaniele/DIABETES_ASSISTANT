// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, camel_case_types

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:diabetes_assistant/model/user.dart';
import 'package:diabetes_assistant/privatePages/editUserProfile.dart';
import 'package:diabetes_assistant/utils/userPreferences.dart';
import 'package:diabetes_assistant/widget/navigationDrawer.dart';
import 'package:diabetes_assistant/widget/numbersWidget.dart';
import 'package:flutter/material.dart';
import 'package:diabetes_assistant/widget/buildAppBar.dart';
import 'package:diabetes_assistant/widget/profileWidget.dart ';
import 'package:diabetes_assistant/widget/buttonWidget.dart';

class userProfile extends StatelessWidget {
  const userProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const user = userPreferences.myUser;
    return ThemeSwitchingArea(
        child: Builder(
            builder: (context) => Scaffold(
                  appBar: buildAppBar(context),
                  body: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      ProfileWidget(
                        imagePath: user.imagePath,
                        onClicked: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => EditUserProfile()),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      buildName(user),
                      const SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: buildUpgradeButton(),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      NumbersWidget(),
                      const SizedBox(
                        height: 48,
                      ),
                      buildAbout(user),
                    ],
                  ),
              drawer: const NavigationDrawer()
                ),
                ));
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Make something latter',
        onClicked: () {},
      );

  Widget buildAbout(User user) => Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'About',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          user.about,
          style: TextStyle(fontSize: 16, height: 1.4),
        )
      ]));
}
