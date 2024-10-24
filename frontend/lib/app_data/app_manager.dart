import 'package:frontend/models/event_categories_enum.dart';
import 'package:frontend/models/event_suggestion_data.dart';
import 'package:frontend/models/report_card_fixed_data.dart';
import 'package:frontend/models/report_data.dart';
import 'package:frontend/models/report_timeline_enum.dart';

class AppManagerSingleton {
  static final AppManagerSingleton _instance = AppManagerSingleton._internal();

  factory AppManagerSingleton() => _instance;

  AppManagerSingleton._internal();

  static final ReportCardFixedData _reportCardFixedDataWeek =
      ReportCardFixedData(
          categoryRatingTable: [
        (4.5, EventCategory.food),
        (3.2, EventCategory.sports),
        (4.3, EventCategory.artificialIntelligence),
        (2.1, EventCategory.music),
        (1.7, EventCategory.art),
      ],
          ratingSubtitle: "Food is new favorite!",
          timeAllocationMainValue: "12:00",
          timeAllocationSubTitle: "Most frequent day: Sunday",
          bestPlaceMainValue: "Kitchen area",
          bestPlaceSubTitle: "Food events strikes!",
          averageInterestMainValue: "Score: 3.1",
          averageInterestSubTitle: "Interest went slightly down");

  static final ReportCardFixedData _reportCardFixedDataMon =
      ReportCardFixedData(
    categoryRatingTable: [
      (4.1, EventCategory.food),
      (4.7, EventCategory.sports),
      (4.5, EventCategory.artificialIntelligence),
      (2.5, EventCategory.music),
      (1.9, EventCategory.art),
    ],
    ratingSubtitle: "Sports is new favorite!",
    timeAllocationMainValue: "18:00",
    timeAllocationSubTitle: "Most frequent day: Saturday",
    bestPlaceMainValue: "Gym",
    bestPlaceSubTitle: "Sports events strikes!",
    averageInterestMainValue: "Score: 4.7",
    averageInterestSubTitle: "Interest went up",
  );

  static final ReportCardFixedData _reportCardFixedDataHalfYear =
      ReportCardFixedData(
    categoryRatingTable: [
      (4.9, EventCategory.artificialIntelligence),
      (4.2, EventCategory.food),
      (3.2, EventCategory.sports),
      (2.1, EventCategory.music),
      (1.7, EventCategory.art),
    ],
    ratingSubtitle: "AI is new favourite!",
    timeAllocationMainValue: "20:00",
    timeAllocationSubTitle: "Most frequent day: Friday",
    bestPlaceMainValue: "Meeting room",
    bestPlaceSubTitle: "AI events strikes!",
    averageInterestMainValue: "Score: 4.4",
    averageInterestSubTitle: "Interest went up",
  );

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
