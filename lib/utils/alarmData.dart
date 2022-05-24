 // ignore_for_file: prefer_const_constructors

 import 'package:diabetes_assistant/model/alarmInfo.dart';
import 'package:diabetes_assistant/themes.dart';

List<AlarmInfo> alarms =[
  AlarmInfo(DateTime.now().add(Duration(hours: 1)), description: '8 mg insulina', gradientColors: GradientColors.sky),
  AlarmInfo(DateTime.now().add(Duration(hours: 2)), description: '5 mg insulina', gradientColors: GradientColors.sea),
];