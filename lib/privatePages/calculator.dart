// ignore_for_file: use_full_hex_values_for_flutter_colors, avoid_unnecessary_containers
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:diabetes_assistant/privatePages/home.dart';
import 'package:diabetes_assistant/utils/foodData.dart';
//import 'package:diabetes_assistant/model/user.dart';
//import 'package:diabetes_assistant/themes.dart';
import 'package:diabetes_assistant/utils/userPreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class Calculator extends StatelessWidget {
  Calculator({Key? key}) : super(key: key);
  final user = userPreferences.myUser;
  final icon = CupertinoIcons.moon_stars;
  final foodController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Calculator'),
            backgroundColor: const Color(0xFF8215466),
          ),
          drawer: const NavigationDrawer(),
          body: Container(
            child: Column(children: [
              const SizedBox(
                height: 12,
              ),
              buildFood()
            ]),
          ),
        ),
      ),
    );
  }

Widget buildFood() => Padding(
  padding: EdgeInsets.all(20),
  child: TypeAheadFormField<String?>(
  textFieldConfiguration: TextFieldConfiguration(
    controller: foodController,
    decoration: const InputDecoration(
      label: Text('Dishes'),
      border: OutlineInputBorder()
    )
  ),
  suggestionsCallback: FoodData.getSuggestions,
  itemBuilder: (context, String? suggestion) => ListTile(
    title: Text(suggestion!),
  ),
  onSuggestionSelected: (String? suggestion) => foodController.text = suggestion!,
  ));

}

