import 'package:frontend/models/event_categories_enum.dart';
import 'package:frontend/models/event_suggestion_data.dart';
import 'package:frontend/models/report_card_fixed_data.dart';
import 'package:frontend/models/report_data.dart';
import 'package:frontend/models/report_timeline_enum.dart';
import 'package:frontend/models/time_analysis_data.dart';

class AppManagerSingleton {
  static final AppManagerSingleton _instance = AppManagerSingleton._internal();

  factory AppManagerSingleton() => _instance;

  AppManagerSingleton._internal();

  static TimeAnalysisData weeklyData = TimeAnalysisMock.generateWeekData();
  static TimeAnalysisData montlyData = TimeAnalysisMock.generateMonthData();
  static TimeAnalysisData sixMonthData =
      TimeAnalysisMock.generateSixMonthData();

  static final ReportCardFixedData _reportCardFixedDataWeek = ReportCardFixedData(
      categoryRatingTable: [
        (
          4.5,
          EventCategory.food
        ), // Dining experiences in restaurants, special meals
        (3.2, EventCategory.sports), // Gym, pool, tennis, yoga classes
        (
          4.3,
          EventCategory.artificialIntelligence
        ), // AI workshops or tech talks
        (2.1, EventCategory.music), // Live music events, performances
        (1.7, EventCategory.art), // Art galleries or painting workshops
        (3.9, EventCategory.health), // Spa treatments, health workshops
        (
          2.8,
          EventCategory.travel
        ), // Travel packages, guided tours, hotel excursions
        (3.5, EventCategory.beauty), // Beauty services in the spa or salon
      ],
      ratingSubtitle: "Food is new favorite!",
      timeAllocationMainValue: TimeAnalysisMock.convertHourToTimeFormat(
          TimeAnalysisMock.findBusiestTime(weeklyData).$1),
      timeAllocationSubTitle:
          "Most frequent day: ${TimeAnalysisMock.getDayOfWeek(TimeAnalysisMock.findBusiestTime(weeklyData).$1)}",
      bestPlaceMainValue: "Kitchen area",
      bestPlaceSubTitle: "Food events strikes!",
      averageInterestMainValue: "Score: 3.1",
      averageInterestSubTitle: "Interest went slightly down",
      timeAnalysisData: weeklyData);

  static final ReportCardFixedData _reportCardFixedDataMon =
      ReportCardFixedData(
          categoryRatingTable: [
        (4.1, EventCategory.food), // Restaurants, food tastings
        (4.7, EventCategory.sports), // Fitness activities, sports courts
        (4.5, EventCategory.artificialIntelligence), // Tech events, AI meetups
        (2.5, EventCategory.music), // Music concerts, DJ nights
        (1.9, EventCategory.art), // Cultural exhibitions, art fairs
        (4.3, EventCategory.health), // Spa and wellness, massages
        (
          3.2,
          EventCategory.beauty
        ), // Beauty treatments like facials, manicures
        (2.9, EventCategory.networking), // Business networking events or mixers
      ],
          ratingSubtitle: "Sports is new favorite!",
          timeAllocationMainValue: "18:00",
          timeAllocationSubTitle: "Most frequent day: Saturday",
          bestPlaceMainValue: "Gym",
          bestPlaceSubTitle: "Sports events strikes!",
          averageInterestMainValue: "Score: 4.7",
          averageInterestSubTitle: "Interest went up",
          timeAnalysisData: TimeAnalysisMock.generateMonthData());

  static final ReportCardFixedData _reportCardFixedDataHalfYear =
      ReportCardFixedData(
          categoryRatingTable: [
        (
          4.9,
          EventCategory.artificialIntelligence
        ), // Major tech event, AI conference
        (4.2, EventCategory.food), // Dining remains popular, themed dinners
        (3.2, EventCategory.sports), // Consistent interest in sports activities
        (2.1, EventCategory.music), // Concerts and live performances
        (1.7, EventCategory.art), // Art activities, exhibitions
        (
          4.5,
          EventCategory.travel
        ), // Hotel excursions or organized travel activities
        (
          3.8,
          EventCategory.education
        ), // Educational events or workshops hosted by the hotel
        (
          3.1,
          EventCategory.environment
        ), // Eco-friendly or green hotel activities
      ],
          ratingSubtitle: "AI is new favourite!",
          timeAllocationMainValue: "20:00",
          timeAllocationSubTitle: "Most frequent day: Friday",
          bestPlaceMainValue: "Meeting room",
          bestPlaceSubTitle: "AI events strikes!",
          averageInterestMainValue: "Score: 4.4",
          averageInterestSubTitle: "Interest went up",
          timeAnalysisData: TimeAnalysisMock.generateSixMonthData());

  static final List<EventSuggestionData> _suggestions = [
    EventSuggestionData(
        category: EventCategory.art,
        description:
            "This is an example description for a sports event. It provides a detailed overview of the event, limited to 200 characters for clarity and completeness, ensuring all key points are covered.",
        arguments: {"arg1": "desc1", "arg2": "desc2"}),
    EventSuggestionData(
        category: EventCategory.sports,
        description:
            "This is an example description for a sports event. It provides a detailed overview of the event, limited to 200 characters for clarity and completeness, ensuring all key points are covered.",
        arguments: {"arg1": "desc1", "arg2": "desc2"}),
    EventSuggestionData(
        category: EventCategory.networking,
        description:
            "This is an example description for a sports event. It provides a detailed overview of the event, limited to 200 characters for clarity and completeness, ensuring all key points are covered.",
        arguments: {"arg1": "desc1", "arg2": "desc2"}),
  ];

  static final Map<ReportTimeline, ReportData> _reportData = {
    ReportTimeline.week: ReportData(
      cpv: 0.3,
      totalEvents: 210,
      averageScore: 3.1,
      cardData: _reportCardFixedDataWeek.convertToCardData(),
      suggestionData: _suggestions,
    ),
    ReportTimeline.month: ReportData(
      cpv: 0.9,
      totalEvents: 1525,
      averageScore: 4.7,
      cardData: _reportCardFixedDataMon.convertToCardData(),
      suggestionData: _suggestions,
    ),
    ReportTimeline.sixMonths: ReportData(
      cpv: 0.7,
      totalEvents: 9821,
      averageScore: 4.4,
      cardData: _reportCardFixedDataHalfYear.convertToCardData(),
      suggestionData: _suggestions,
    ),
  };

  Map<ReportTimeline, ReportData> get reportData {
    return _reportData;
  }
}
