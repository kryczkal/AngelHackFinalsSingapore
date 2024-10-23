import 'package:frontend/models/dashboard_card_data.dart';

class AppManagerSingleton {
  static final AppManagerSingleton _instance = AppManagerSingleton._internal();

  factory AppManagerSingleton() => _instance;

  AppManagerSingleton._internal();

  static const List<DashboardCardData> _cardData = [
    DashboardCardData(
      title: 'Total Students',
      mainValue: '12.543',
      subtitle: '80% Increase than before',
      graphType: 'bar',
      graphColors: ['#E0E5FF', '#8676F7'],
    ),
    DashboardCardData(
      title: 'Total Income',
      mainValue: '\$10.123',
      subtitle: '80% Increase in 20 Days',
      graphType: 'line',
      graphColors: ['#FFD6E0', '#E890F7'],
    ),
    DashboardCardData(
      title: 'Total Working Hours',
      mainValue: '32h 42m',
      subtitle: '80% Increase than before',
      graphType: 'wave',
      graphColors: ['#B3E5FF', '#4A90E2'],
    ),
  ];

  List<DashboardCardData> get cardData {
    return _cardData;
  }
}
