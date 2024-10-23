import 'package:frontend/models/event_badge.dart';
import 'package:frontend/models/user_data.dart';

class AppUserSingleton {
  static final AppUserSingleton _instance = AppUserSingleton._internal();

  factory AppUserSingleton() => _instance;

  AppUserSingleton._internal();

  final User _currentUser =
      User(firstName: 'Łukasz', lastName: 'Kryczka', age: 20, userBadges: [EventBadge(name: 'Yoga Lover')]);
  static const String _currentLocation = 'Singapore';
  static const String _profileImagePath = 'images/profile/profile.jpg';

  User get currentUser {
    return _currentUser;
  }

  String get currentLocation {
    return _currentLocation;
  }

  String get profileImagePath {
    return _profileImagePath;
  }
}
