// ignore_for_file: use_full_hex_values_for_flutter_colors, avoid_unnecessary_containers, prefer_const_constructors
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:diabetes_assistant/utils/foodData.dart';
//import 'package:diabetes_assistant/model/user.dart';
//import 'package:diabetes_assistant/themes.dart';
//import 'package:diabetes_assistant/utils/userPreferences.dart';
import 'package:diabetes_assistant/widget/navigationDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'dart:math';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State {
  final rand = Random();
  final icon = CupertinoIcons.moon_stars;
  final caloriesMax = 2800;
  final carbohydratesMax = 350;

  final foodController = TextEditingController();
  final weightController = TextEditingController();
  Map<String, List<Food>> foods = {
    "Lunes": [],
    "Martes": [],
    "Miércoles": [],
    "Jueves": [],
    "Viernes": [],
    "Sábado": [],
    "Domingo": [],
  };
  late String selectedDay = foods.keys.elementAt(DateTime.now().weekday - 1);

  late double Function() totalCalories = () => foods[selectedDay]!
      .fold<double>(0, (a, b) => a + b.calories * b.weight / 100);
  late double Function() totalCarbohydrates = () => foods[selectedDay]!
      .fold<double>(0, (a, b) => a + b.carbohydrates * b.weight / 100);

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Calculadora'),
            backgroundColor: const Color(0xFF8215466),
          ),
          drawer: NavigationDrawer(),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(children: [
              Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(children: [
                      SizedBox(
                          width: 100,
                          child: Text(
                            "Max. Calorías Recomendadas",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      Text("$caloriesMax kcal"),
                    ]),
                    SizedBox(width: 20),
                    Column(children: [
                      SizedBox(
                          width: 100,
                          child: Text(
                            "Max. Carbohidratos Recomendados",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      Text("$carbohydratesMax g"),
                    ]),
                  ],
                ),
              ),
              SizedBox(height: 20),
              DropdownButton(
                value: selectedDay,
                items: foods.keys
                    .map<DropdownMenuItem>((day) => DropdownMenuItem<String>(
                          value: day,
                          child: Text(day),
                        ))
                    .toList(),
                icon: Icon(Icons.calendar_view_week),
                onChanged: (dynamic day) {
                  setState(() {
                    selectedDay = day;
                  });
                },
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey,
                  ),
                  itemCount: foods[selectedDay]!.length,
                  itemBuilder: (context, index) {
                    Food food = foods[selectedDay]![index];
                    return SizedBox(
                        height: 90,
                        child: ListTile(
                          title: Text(food.name),
                          trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                foods[selectedDay]!.removeAt(index);
                              });
                            },
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Peso a comer: ${food.weight.toStringAsFixed(2)} g"),
                              Text(
                                  "Calorías: ${(food.carbohydrates * food.weight / 100).toStringAsFixed(2)} kcal (${(food.calories / 100).toStringAsFixed(2)} kcal/g)"),
                              Text(
                                  "Carbohidratos: ${(food.carbohydrates * food.weight / 100).toStringAsFixed(2)} g (${food.carbohydrates.toStringAsFixed(2)}%)"),
                            ],
                          ),
                        ));
                  },
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(children: [
                        Text(
                          "Calorías Totales",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("${totalCalories().toStringAsFixed(2)} kcal",
                            style: TextStyle(fontSize: 18)),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(children: [
                        Text(
                          "Carbohidratos Totales",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${totalCarbohydrates().toStringAsFixed(2)} g",
                          style: TextStyle(fontSize: 18),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              buildfood(),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200.0,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: weightController,
                      decoration: const InputDecoration(
                        label: Text('Peso (gramos)'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      double? weight = double.tryParse(weightController.text);
                      double carbs = 30 * rand.nextDouble();
                      double calories = 70 * rand.nextDouble();
                      if (weight == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Por favor digite el peso de la porción a comer.",
                              style: TextStyle(fontSize: 16)),
                        ));
                      } else if (carbohydratesMax <
                              totalCarbohydrates() + carbs * weight / 100 ||
                          caloriesMax <
                              totalCalories() + calories * weight / 100) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "No puedes agregar este plato porque está por encima de tu límite diario recomendado.",
                              style: TextStyle(fontSize: 16)),
                        ));
                      } else {
                        setState(() {
                          foods[selectedDay]!.add(Food(
                            foodController.text,
                            carbs,
                            calories,
                            weight,
                          ));
                        });
                        foodController.text = "";
                        weightController.text = "";
                      }
                    },
                    child: Icon(Icons.add),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF8215466),
                      padding: EdgeInsets.all(16),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget buildfood() => TypeAheadFormField<String?>(
      direction: AxisDirection.up,
      textFieldConfiguration: TextFieldConfiguration(
        controller: foodController,
        decoration: const InputDecoration(
          label: Text('Platos'),
          border: OutlineInputBorder(),
        ),
      ),
      suggestionsCallback: FoodData.getSuggestions,
      itemBuilder: (context, String? suggestion) => ListTile(
            title: Text(suggestion!),
          ),
      onSuggestionSelected: (String? suggestion) {
        foodController.text = suggestion!;
      });
}

class Food {
  String name;
  double calories;
  double carbohydrates;
  double weight;

  Food(this.name, this.calories, this.carbohydrates, this.weight);
}
