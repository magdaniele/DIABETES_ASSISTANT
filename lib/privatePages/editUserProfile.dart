// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:diabetes_assistant/utils/userPreferences.dart';
import 'package:diabetes_assistant/widget/buildAppBar.dart';
import 'package:diabetes_assistant/widget/profileWidget.dart';
import 'package:diabetes_assistant/widget/textFieldWidget.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class EditUserProfile extends StatefulWidget {
  @override
  _EditUserProfileState createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  User user = userPreferences.myUser;

  @override
  Widget build(BuildContext context) => ThemeSwitchingArea(
          child: Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(context),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 32),
            physics: BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                  imagePath: user.imagePath,
                  isEdit: true,
                  onClicked: () async {}),
              const SizedBox(
                height: 24,
              ),
              TextFieldWidget(
                label: 'Full Name',
                text: user.name,
                onChanged: (name) {},
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldWidget(
                label: 'Email',
                text: user.email,
                onChanged: (email) {},
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldWidget(
                label: 'About',
                text: user.about,
                maxLines: 5,
                onChanged: (about) {},
              ),
            ],
          ),
        ),
      ));
}
