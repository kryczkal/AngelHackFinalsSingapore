import 'package:frontend/models/user.dart';

class AppUserSingleton {
  static final AppUserSingleton _instance = AppUserSingleton._internal();
  factory AppUserSingleton() => _instance;
  AppUserSingleton._internal();

  User currentUser =
      User(firstName: 'Łukasz', lastName: 'Kryczka', age: 20, userBadges: []);
  String currentLocation = 'Singapore';
  String profileImagePath = 'images/profile/profile.jpg';
}
