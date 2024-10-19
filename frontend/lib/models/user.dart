import 'package:flutter/material.dart';
import 'package:frontend/models/EventBadge.dart';

class User {
  final String firstName;
  final String lastName;
  final int age;
  final String profilePic = 'assets/default_profile_pic.png';
  List<EventBadge> userBadges;

  User({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.userBadges
  });
}