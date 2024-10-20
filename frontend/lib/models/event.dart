import 'package:frontend/models/event_badge.dart';
import 'package:frontend/models/event_categories.dart';
import 'package:frontend/models/lyf_hotels.dart';
import 'package:frontend/models/user.dart';

class Event {
  final String title;
  final DateTime date;
  final String imageUrl;
  final String backgroundColor;
  final String localization;
  final LyfHotels hotel;
  final String description;
  final bool isHotelOrganized;
  final User organizer;
  final EventCategory category;
  List<User> registeredUsers;
  List<EventBadge> badges;

  Event({
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.backgroundColor,
    required this.localization,
    required this.hotel,
    required this.description,
    required this.organizer,
    required this.registeredUsers,
    required this.badges,
    required this.category,
    this.isHotelOrganized = false,
  });

  DateTime? get dateTime => null;
}
