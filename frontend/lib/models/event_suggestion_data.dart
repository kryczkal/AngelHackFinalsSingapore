import 'package:frontend/models/event_categories_enum.dart';
import 'package:frontend/models/event_data.dart';
import 'package:frontend/models/event_template.dart';

class EventSuggestionData {
  final EventCategory category;
  final String description;
  final double matchScore;
  final List<String> keyPoints;
  final Map<String, dynamic> metrics;
  final Map<String, String> guestDemographics;
  final Map<String, double> amenityUsage;
  final String seasonalTrend;
  final Map<String, String> arguments;
  final EventTemplate eventTemplate;

  EventSuggestionData({
    required this.category,
    required this.description,
    required this.matchScore,
    required this.keyPoints,
    required this.metrics,
    required this.guestDemographics,
    required this.amenityUsage,
    required this.seasonalTrend,
    required this.arguments,
    required this.eventTemplate
  });

  String get formattedMatchScore => '${(matchScore * 100).toStringAsFixed(0)}%';

  String get primaryAmenity => amenityUsage.entries.isEmpty
      ? 'None'
      : amenityUsage.entries.reduce((a, b) => a.value > b.value ? a : b).key;

  List<String> get topDemographics => guestDemographics.entries
      .take(3)
      .map((e) => '${e.key}: ${e.value}')
      .toList();
}
