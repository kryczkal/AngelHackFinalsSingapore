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

  static final List<DashboardCardData> _cardDataWeek = [
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
        height: 60,
        width: 100,
      ),
    ),
  ];

  /*
  * TODO:
  * - best performing events (table of sorted events (all types) with search)
  * - hour picking analysis (bar chart)
  * - day picking analysis (bar chart)
  * - rating in time (full chart - fl_chart)
  * - most frequently used places (bar chart / pie chart)
  * */

  static final List<DashboardCardData> _cardDataMon = [];

  static final List<DashboardCardData> _cardDataHalfYear = [];

  static final Map<ReportTimeline, ReportData> _reportData = {
    ReportTimeline.week: ReportData(
      cpv: 0.5,
      totalEvents: 12,
      averageScore: 3.1,
      cardData: _cardDataWeek,
    ),
    ReportTimeline.month: ReportData(
      cpv: 0.6,
      totalEvents: 42,
      averageScore: 4.7,
      cardData: _cardDataMon,
    ),
    ReportTimeline.sixMonths: ReportData(
      cpv: 0.7,
      totalEvents: 120,
      averageScore: 1.2,
      cardData: _cardDataHalfYear,
    ),
  };

  Map<ReportTimeline, ReportData> get reportData {
    return _reportData;
  }
}
