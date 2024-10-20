import 'package:flutter/material.dart';
import 'package:frontend/models/event_badge.dart';
import 'package:frontend/models/event_categories.dart';

class User {
  final String firstName;
  final String lastName;
  final int age;
  final String profilePic = 'assets/default_profile_pic.png';
  List<EventBadge> userBadges;
  Set<EventCategory> preferences;

  User({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.userBadges,
    Set<EventCategory>? preferences,  // Optional named parameter
  }) : preferences = preferences ?? {};  // If null, assign an empty set
}
