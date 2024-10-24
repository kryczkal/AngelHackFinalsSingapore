import 'package:flutter/material.dart';
import 'package:frontend/models/event_categories_enum.dart';
import 'package:frontend/models/time_analysis_data.dart';
import 'package:frontend/pages/manager/manager_category_ranking_page.dart';
import 'package:frontend/pages/manager/manager_time_analysis_page.dart';
import 'package:frontend/pages/misc/blank_page.dart';
import 'package:frontend/widgets/manager/charts/bar_chart_widget.dart';
import 'package:frontend/widgets/manager/charts/line_chart_widget.dart';
import 'package:frontend/widgets/manager/charts/pie_chart_preview_widget.dart';
import 'package:frontend/widgets/manager/table_preview_widget.dart';

import 'dashboard_card_data.dart';

class ReportCardFixedData {
  List<(double, EventCategory)> categoryRatingTable;
  String ratingSubtitle;
  String timeAllocationMainValue;
  String timeAllocationSubTitle;
  String bestPlaceMainValue;
  String bestPlaceSubTitle;
  String averageInterestMainValue;
  String averageInterestSubTitle;
  TimeAnalysisData timeAnalysisData;

  ReportCardFixedData({
    required this.categoryRatingTable,
    required this.ratingSubtitle,
    required this.timeAllocationMainValue,
    required this.timeAllocationSubTitle,
    required this.bestPlaceMainValue,
    required this.bestPlaceSubTitle,
    required this.averageInterestMainValue,
    required this.averageInterestSubTitle,
    required this.timeAnalysisData,
  });

  List<DashboardCardData> convertToCardData() {
    var sortedTable = categoryRatingTable..sort((a, b) => b.$1.compareTo(a.$1));

    return [
      DashboardCardData(
        title: "Best performing events",
        mainValue:
            "${sortedTable.first.$2 == EventCategory.artificialIntelligence ? "AI" : sortedTable.first.$2.name}: ${sortedTable.first.$1}",
        subtitle: ratingSubtitle,
        graphFactory: () => SizedBox(
            width: 100,
            height: 80,
            child: TablePreview(data: TablePreviewData.fromVariant(1))),
        pageFactory: () =>
            ManagerCategoryRankingPage(categoryRatings: categoryRatingTable),
      ),
      DashboardCardData(
          title: "Time allocation analysis",
          mainValue: timeAllocationMainValue,
          subtitle: timeAllocationSubTitle,
          graphFactory: () => const SimpleBarChart(
              color: Colors.green, pattern: BarChartPattern.normal),
          pageFactory: () => ManagerTimeAnalysisPage(data: timeAnalysisData)),
      DashboardCardData(
        title: "Place usage analysis",
        mainValue: bestPlaceMainValue,
        subtitle: bestPlaceSubTitle,
        graphFactory: () =>
            PieChartPreviewWidget(data: PieChartPreviewData.fromVariant(2)),
        pageFactory: () => const BlankPage(),
      ),
      DashboardCardData(
          title: "Average interest",
          mainValue: averageInterestMainValue,
          subtitle: averageInterestSubTitle,
          graphFactory: () => const LineChartWidget(
              color: Colors.green,
              pattern: LineChartPattern.volatile,
              width: 100,
              height: 80),
          pageFactory: () => const BlankPage())
    ];
  }
}
