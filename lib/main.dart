import 'package:diabetes_assistant/pages/login.dart';
import 'package:flutter/material.dart';

void main(){
  runApp (MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData( primarySwatch: Colors.blue,),
      home: Login(),
    );
  }
}