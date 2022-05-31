class User{
  final String imagePath;
  final String name;
  final String email;
  final String about;
  final String birthday;
  final double weight;
  final double height;
  final bool isDarkMode;
  const User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
    required this.birthday,
    required this.weight,
    required this.height,
    required this.isDarkMode,
  });
}