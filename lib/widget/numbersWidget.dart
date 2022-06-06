// ignore_for_file: prefer_const_constructors, file_names, sized_box_for_whitespace

import 'package:diabetes_assistant/model/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NumbersWidget extends StatelessWidget {
  final UserModel user;
  const NumbersWidget(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    calculateAge(DateTime birthDate) {
      DateTime currentDate = DateTime.now();
      int age = currentDate.year - birthDate.year;
      int month1 = currentDate.month;
      int month2 = birthDate.month;
      if (month2 > month1) {
        age--;
      } else if (month1 == month2) {
        int day1 = currentDate.day;
        int day2 = birthDate.day;
        if (day2 > day1) {
          age--;
        }
      }
      return age.toString();
    }

    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(
              context,
              calculateAge(DateFormat("dd/MM/yyyy").parse(user.birthday!)),
              'Edad'),
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
