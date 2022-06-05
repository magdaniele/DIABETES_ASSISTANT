// ignore_for_file: prefer_const_constructors, file_names, sized_box_for_whitespace

import 'package:diabetes_assistant/model/user.dart';
import 'package:diabetes_assistant/utils/userPreferences.dart';
import 'package:flutter/material.dart';

class NumbersWidget extends StatelessWidget {
  const NumbersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel user = userPreferences.myUser;
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, '22', 'Edad'),
          buildDivider(),
          buildButton(context, user.height.toString(), 'Estatura'),
          buildDivider(),
          buildButton(context, user.weight.toString(), 'Peso'),
        ],
      ),
    );
  }

  Widget buildDivider() => Container(height: 24, child: VerticalDivider());

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      );
}
