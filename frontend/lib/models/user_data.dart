import 'package:frontend/models/event_badge.dart';
import 'package:frontend/models/event_categories_enum.dart';
import 'package:frontend/models/event_data.dart';
import 'package:frontend/models/lyf_hotels_enum.dart';

class User {
  final String firstName;
  final String lastName;
  final int age;
  final String profilePic = 'assets/default_profile_pic.png';
  final LyfHotels hotel = LyfHotels.Funan;
  List<EventBadge> userBadges;
  Set<EventCategory> preferences;
  List<Event> createdEvents = [];

  User({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.userBadges,
    this.preferences = const <EventCategory>{},
  });
}
