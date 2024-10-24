import 'package:frontend/models/event_categories_enum.dart';

class EventSuggestionData {
  final EventCategory category;
  final String description;
  final Map<String, String> arguments;

  EventSuggestionData({
    required this.category,
    required this.description,
    required this.arguments,
  });
}
