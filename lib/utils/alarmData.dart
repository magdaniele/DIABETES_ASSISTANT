 // ignore_for_file: prefer_const_constructors, file_names

 import 'package:diabetes_assistant/model/alarmInfo.dart';

List<AlarmInfo> alarms =[
  AlarmInfo(alarmDateTime: DateTime.now().add(Duration(hours: 1)), title: '8 mg insulina', gradientColorIndex: 1, isActive: true),
  AlarmInfo(alarmDateTime: DateTime.now().add(Duration(hours: 2)), title: '5 mg insulina', gradientColorIndex: 2, isActive: true),
];