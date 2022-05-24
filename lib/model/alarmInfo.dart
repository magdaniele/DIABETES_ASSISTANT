// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AlarmInfo {
  DateTime alarmDateTime;
  String description;
  bool isActive =false;
  List<Color> gradientColors;

  AlarmInfo(this.alarmDateTime, {required this.description, required this.gradientColors});
}