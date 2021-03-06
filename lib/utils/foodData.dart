// ignore_for_file: file_names

import 'package:faker/faker.dart';

class FoodData {

  static final faker = Faker();

  static final List<String> foods =
        List.generate(50, (index) => faker.food.dish());

        static List<String> getSuggestions(String query)=>
        List.of(foods).where((food){
          final foodLower = food.toLowerCase();
          final queryLower = query.toLowerCase();
          return foodLower.contains(queryLower);
        }).toList();

}