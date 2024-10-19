import 'package:frontend/models/user.dart';

class MockUser {
  static final MockUser _instance = MockUser._internal();
  factory MockUser() => _instance;
  MockUser._internal();

  User currentUser = User(firstName: 'Łukasz', lastName: 'Kryczka');
  String currentLocation = 'Singapore';
  String profileImagePath = 'images/profile/profile.jpg';
}
