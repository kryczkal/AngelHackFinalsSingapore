import 'package:flutter/material.dart';
import 'package:frontend/models/dashboard_card_data.dart';
import 'package:frontend/models/report_data.dart';
import 'package:frontend/models/report_timeline_enum.dart';
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
          color: Colors.green, pattern: BarChartPattern.random),
    ),
    DashboardCardData(
      title: 'Total Income',
      mainValue: '\$10.123',
      subtitle: '80% Increase in 20 Days',
      graphFactory: () => const SimpleBarChart(
          color: Colors.green, pattern: BarChartPattern.decreasing),
    ),
    DashboardCardData(
      title: 'Total Working Hours',
      mainValue: '32h 42m',
      subtitle: '80% Increase than before',
      graphFactory: () => const LineChartWidget(
        color: Colors.green,
        pattern: LineChartPattern.upward,
        height: 80,
        width: 100,
      ),
    ),
  ];

  static final Map<ReportTimeline, ReportData> _reportData = {
    ReportTimeline.week: ReportData(
      cpv: 0.5,
      totalEvents: 12,
      averageScore: 4.5,
      cardData: _cardData,
    ),
    ReportTimeline.month: ReportData(
      cpv: 0.6,
      totalEvents: 42,
      averageScore: 4.7,
      cardData: _cardData,
    ),
    ReportTimeline.sixMonths: ReportData(
      cpv: 0.7,
      totalEvents: 120,
      averageScore: 4.8,
      cardData: _cardData,
    ),
  };

  Map<ReportTimeline, ReportData> get reportData {
    return _reportData;
  }
}