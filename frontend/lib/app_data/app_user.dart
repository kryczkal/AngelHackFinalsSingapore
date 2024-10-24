import 'package:flutter/material.dart';
import 'package:frontend/models/event_badge.dart';
import 'package:frontend/models/event_data.dart';
import 'package:frontend/models/user_data.dart';

class AppUserSingleton extends ChangeNotifier {
  static final AppUserSingleton _instance = AppUserSingleton._internal();

  factory AppUserSingleton() => _instance;

  AppUserSingleton._internal();

  User _currentUser = User(
      firstName: 'Łukasz',
      lastName: 'Kryczka',
      age: 20,
      userBadges: [EventBadge(name: 'Yoga Lover')],
      isManager: true);
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

  List<Event> getMyCreatedEvents() {
    return _currentUser.createdEvents;
  }

  List<Event> getMyRegisteredEvents() {
    return _currentUser.registeredEvents;
  }

  void addCreatedEvent(Event event) {
    _currentUser.createdEvents.add(event);
    notifyListeners();
  }
}
