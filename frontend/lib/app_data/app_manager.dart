import 'package:flutter/material.dart';
import 'package:frontend/models/dashboard_card_data.dart';
import 'package:frontend/widgets/bar_chart_widget.dart';
import 'package:frontend/widgets/line_chart_widget.dart';

class AppManagerSingleton {
  static final AppManagerSingleton _instance = AppManagerSingleton._internal();

  factory AppManagerSingleton() => _instance;

  AppManagerSingleton._internal();

  static final List<DashboardCardData> _cardData = [
    DashboardCardData(
      title: 'Total Students',
      mainValue: '12.543',
      subtitle: '80% Increase than before',
      graphFactory: () => const SimpleBarChart(
          color: Colors.indigoAccent, pattern: BarChartPattern.random),
      graphColors: ['#E0E5FF', '#8676F7'],
    ),
    DashboardCardData(
      title: 'Total Income',
      mainValue: '\$10.123',
      subtitle: '80% Increase in 20 Days',
      graphFactory: () => const SimpleBarChart(
          color: Colors.indigoAccent, pattern: BarChartPattern.decreasing),
      graphColors: ['#FFD6E0', '#E890F7'],
    ),
    DashboardCardData(
      title: 'Total Working Hours',
      mainValue: '32h 42m',
      subtitle: '80% Increase than before',
      graphFactory: () => const LineChartWidget(
        color: Colors.indigoAccent,
        pattern: LineChartPattern.upward,
        height: 80,
        width: 100,
      ),
      graphColors: ['#B3E5FF', '#4A90E2'],
    ),
  ];

  List<DashboardCardData> get cardData {
    return _cardData;
  }
}
