// ignore_for_file: empty_constructor_bodies

class UserModel {
  String? uid;
  String? firstName;
  String? secondName;
  String? email;
  String? imagePath;
  String? about;
  String? birthday;
  double? weight;
  double? height;
  String? gender;
  bool isDarkMode;
  List<dynamic> glucoseTests = [];
  Map<String, dynamic> mealPlan = {};
  List<dynamic> alarms = [];
  UserModel({
    required this.uid,
    required this.firstName,
    required this.secondName,
    required this.email,
    required this.imagePath,
    required this.about,
    required this.birthday,
    required this.weight,
    required this.height,
    required this.gender,
    required this.isDarkMode,
    glucoseTests,
    mealPlan,
    alarms,
  })  : glucoseTests = glucoseTests ?? [],
        mealPlan = mealPlan == null
            ? {
                "Lunes": [],
                "Martes": [],
                "Miércoles": [],
                "Jueves": [],
                "Viernes": [],
                "Sábado": [],
                "Domingo": [],
              }
            : {
                "Lunes": mealPlan["Lunes"] ?? [],
                "Martes": mealPlan["Martes"] ?? [],
                "Miércoles": mealPlan["Miércoles"] ?? [],
                "Jueves": mealPlan["Jueves"] ?? [],
                "Viernes": mealPlan["Viernes"] ?? [],
                "Sábado": mealPlan["Sábado"] ?? [],
                "Domingo": mealPlan["Domingo"] ?? [],
              },
        alarms = alarms ?? [];
  //recieve data
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      email: map['email'],
      birthday: map['birthday'],
      imagePath: map['imagePath'],
      about: map['about'],
      weight: map['weight'],
      height: map['height'],
      isDarkMode: map['isDarkMode'],
      gender: map['gender'],
      glucoseTests: map['glucoseTests'],
      mealPlan: map['mealPlan'],
      alarms: map['alarms'],
    );
  }
  //send data
  Map<String, dynamic> toMap() {
    return {
      'id': uid,
      'firstName': firstName,
      'secondName': secondName,
      'email': email,
      'birthday': birthday,
      'imagePath': imagePath,
      'about': about,
      'weight': weight,
      'height': height,
      'isDarkMode': isDarkMode,
      'gender': gender,
      'glucoseTests': glucoseTests,
      'mealPlan': mealPlan,
      'alarms': alarms,
    };
  }
}
