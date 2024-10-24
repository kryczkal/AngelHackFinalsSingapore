import 'package:frontend/models/dashboard_card_data.dart';
import 'package:frontend/models/event_suggestion_data.dart';

class ReportData {
  final double cpv;
  final int totalEvents;
  final double averageScore;
  final List<DashboardCardData> cardData;
  final List<EventSuggestionData> suggestionData;

  const ReportData({
    required this.cpv,
    required this.totalEvents,
    required this.averageScore,
    required this.cardData,
    required this.suggestionData,
  });
}
