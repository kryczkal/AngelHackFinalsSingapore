import 'package:frontend/models/dashboard_card_data.dart';

class ReportData {
  final double cpv;
  final int totalEvents;
  final double averageScore;
  final List<DashboardCardData> cardData;

  const ReportData({
    required this.cpv,
    required this.totalEvents,
    required this.averageScore,
    required this.cardData,
  });
}
