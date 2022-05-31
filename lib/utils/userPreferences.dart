// ignore_for_file: constant_identifier_names, camel_case_types, file_names

import 'package:diabetes_assistant/model/user.dart';

class userPreferences {
  static const myUser = User(
    imagePath:'assets/defaultProfileImg.jpg',
    name:'Eddy Cardona',
    email:'magdaniel@uninorte.edu.co',
    about:'Me divierto en mis tiempos libres y mi meta es llegar a tener algun dia el peso ideal utilizando esta maravillosa herramienta como pie de apoyo.',
    birthday: '2000-07-01',
    height: 183,
    weight: 75,
    isDarkMode:false,
  );
}