import 'package:flutter/material.dart';
import 'package:frontend/models/event_badge.dart';
import 'package:frontend/models/event_categories_enum.dart';
import 'package:frontend/models/event_data.dart';
import 'package:frontend/models/user_data.dart';

class AppUserSingleton extends ChangeNotifier {
  static final AppUserSingleton _instance = AppUserSingleton._internal();

  factory AppUserSingleton() => _instance;

  late User _currentUser;

  AppUserSingleton._internal() {
    // Initialize the current user immediately
    _currentUser = users[0];
  }

  final List<User> users = [
    User(
      firstName: 'Łukasz',
      lastName: 'Kryczka',
      age: 20,
      location: 'Singapore',
      profilePic: 'images/profile/lukasz_kryczka.jpg',
      userBadges: [EventBadge(name: 'Yoga Lover')],
      isManager: true),
    // Add more users here
    User(
      firstName: 'Piotr',
      lastName: 'Tyrakowski',
      age: 35,
      location: 'Singapore',
      profilePic: 'images/profile/piotr_tyrakowski.jpg',
      userBadges: [EventBadge(name: 'Tech Enthusiast')],
      isManager: false),

    User(
      firstName: 'Anna',
      lastName: 'Smith',
      age: 25,
      location: 'New York',
      profilePic: 'images/profile/anna_smith.jpg',
      userBadges: [EventBadge(name: 'Tech Enthusiast')],
      isManager: false),
    User(
      firstName: 'John',
      lastName: 'Doe',
      age: 30,
      location: 'London',
      profilePic: 'images/profile/john_doe.jpg',
      userBadges: [EventBadge(name: 'Music Lover')],
      isManager: false),

      User(
        firstName: 'Paul',
        lastName: 'Done',
        age: 30,
        location: 'Singapore',
        profilePic: 'images/profile/default_profile_pic.png',
        userBadges: [EventBadge(name: 'Example Badge')],
        preferences: {EventCategory.artificialIntelligence},
        isManager: true,
    ),
    User(
        firstName: 'Michael',
        lastName: 'Brown',
        age: 28,
        location: 'Singapore',
        profilePic: 'images/profile/profile.jpg',
        userBadges: [],
    ),

    User(
        firstName: 'Sophia',
        lastName: 'Davis',
        age: 26,
        location: 'Singapore',
        profilePic: 'images/profile/profile.jpg',
        userBadges: [],
      ),
    User(
        firstName: 'James',
        lastName: 'Wilson',
        age: 32,
        location: 'Singapore',
        profilePic: 'images/profile/profile.jpg',
        userBadges: [],
      ),
    
     User(
        firstName: 'Olivia',
        lastName: 'Martinez',
        age: 27,
        location: 'Singapore',
        profilePic: 'images/profile/profile.jpg',
        userBadges: [],
      ),
  ];

  

  User get currentUser {
    return _currentUser;
  }

  User getUserByFirstNameAndLastName(String firstName, String lastName) {
    return users.firstWhere((user) => user.firstName == firstName && user.lastName == lastName);
  }

  String get currentLocation {
    return _currentUser.location;
  }

  String get profileImagePath {
    return _currentUser.profilePic;
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
