import 'package:frontend/models/EventBadge.dart';
import 'package:frontend/models/user.dart';

class Event {
  final String title;
  final DateTime date;
  final String imageUrl;
  final String backgroundColor;
  final String localization;
  final String description;
  final User organizer;
  List<User> registeredUsers;
  List<EventBadge> badges;

  Event({
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.backgroundColor,
    required this.localization,
    required this.description,
    required this.organizer,
    required this.registeredUsers,
    required this.badges,
  });
}
