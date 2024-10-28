import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_user.dart';
import 'package:frontend/models/event_categories_enum.dart';
import 'package:frontend/models/event_data.dart';
import 'package:frontend/models/event_suggestion_data.dart';
import 'package:frontend/models/event_template.dart';
import 'package:frontend/models/hotel_demography.dart';
import 'package:frontend/models/lyf_hotels_enum.dart';
import 'package:frontend/models/report_card_fixed_data.dart';
import 'package:frontend/models/report_data.dart';
import 'package:frontend/models/report_timeline_enum.dart';
import 'package:frontend/models/time_analysis_data.dart';

class AppManagerSingleton {
  static final AppManagerSingleton _instance = AppManagerSingleton._internal();

  factory AppManagerSingleton() => _instance;

  AppManagerSingleton._internal();

  static final ReportCardFixedData _reportCardFixedDataWeek = ReportCardFixedData(
      categoryRatingTable: [
        (4.5, EventCategory.food),
        (3.2, EventCategory.sports),
        (4.3, EventCategory.artificialIntelligence),
        (2.1, EventCategory.music),
        (1.7, EventCategory.art),
        (3.9, EventCategory.health),
        (2.8, EventCategory.travel),
        (3.5, EventCategory.beauty),
      ],
      ratingSubtitle: "Food is new favorite!",
      timeAllocationMainValue: TimeAnalysisMock.convertHourToTimeFormat(
          TimeAnalysisMock.findBusiestTime(
                  TimeAnalysisMock.getData(ReportTimeline.week))
              .$1),
      timeAllocationSubTitle:
          "Most frequent day: ${TimeAnalysisMock.getDayOfWeek(TimeAnalysisMock.findBusiestTime(TimeAnalysisMock.getData(ReportTimeline.week)).$1)}",
      bestPlaceMainValue: "Kitchen area",
      bestPlaceSubTitle: "Food events strikes!",
      averageInterestMainValue: "Score: 3.1",
      averageInterestSubTitle: "Interest went slightly down",
      timeline: ReportTimeline.week);

  static final ReportCardFixedData _reportCardFixedDataMon =
      ReportCardFixedData(
          categoryRatingTable: [
        (4.1, EventCategory.food),
        (4.7, EventCategory.sports),
        (4.5, EventCategory.artificialIntelligence),
        (2.5, EventCategory.music),
        (1.9, EventCategory.art),
        (4.3, EventCategory.health),
        (3.2, EventCategory.beauty),
        (2.9, EventCategory.networking),
      ],
          ratingSubtitle: "Sports is new favorite!",
          timeAllocationMainValue: "18:00",
          timeAllocationSubTitle: "Most frequent day: Saturday",
          bestPlaceMainValue: "Gym",
          bestPlaceSubTitle: "Sports events strikes!",
          averageInterestMainValue: "Score: 4.7",
          averageInterestSubTitle: "Interest went up",
          timeline: ReportTimeline.month);

  static final ReportCardFixedData _reportCardFixedDataHalfYear =
      ReportCardFixedData(
          categoryRatingTable: [
        (4.9, EventCategory.artificialIntelligence),
        (4.2, EventCategory.food),
        (3.2, EventCategory.sports),
        (2.1, EventCategory.music),
        (1.7, EventCategory.art),
        (4.5, EventCategory.travel),
        (3.8, EventCategory.education),
        (3.1, EventCategory.environment),
      ],
          ratingSubtitle: "AI is new favourite!",
          timeAllocationMainValue: "20:00",
          timeAllocationSubTitle: "Most frequent day: Friday",
          bestPlaceMainValue: "Meeting room",
          bestPlaceSubTitle: "AI events strikes!",
          averageInterestMainValue: "Score: 4.4",
          averageInterestSubTitle: "Interest went up",
          timeline: ReportTimeline.sixMonths);

  static final List<EventSuggestionData> _suggestions = [
    EventSuggestionData(
      category: EventCategory.food,
      description:
          "Local Snack Tasting, featuring popular snacks from nearby vendors. Guests can sample authentic flavors and enjoy a casual, social evening.",
      matchScore: 0.77,
      keyPoints: [
        "Growing interest in local cuisine",
        "In collaboration with local small businesses",
        "Provides an authentic taste of the city",
        "Positive engagement from previous tasting events"
      ],
      metrics: {
        "Expected Attendance": "15-20",
        "Duration": "1.5 hours",
        "Satisfaction Rate": "93%"
      },
      guestDemographics: {
        "Food Lovers": "45%",
        "Cultural Enthusiasts": "30%",
        "Socializers": "25%"
      },
      amenityUsage: {"Lounge Area": 0.75, "Dining Room": 0.70},
      seasonalTrend: "Year-round",
      arguments: {
        "venue": "Lounge Area",
        "capacity": "20",
        "requirements": "Table setups for tastings"
      },
      eventTemplate: EventTemplate(
        name: "Local Snack Tasting",
        icon: Icons.fastfood,
        description:
            "Sample a variety of local snacks, hosted in a relaxed social setting.",
        category: EventCategory.food,
        prefilledTitle: "Local Snack Tasting",
        prefilledDescription: "Taste authentic local snacks with us!",
        isPersonalized: true,
        imageUrl: "https://example.com/local_snacks.jpg",
      ),
    ),
    EventSuggestionData(
      category: EventCategory.gaming,
      description:
          "Game Night in the lounge! Unwind with classic board games, card games, and light refreshments. Suitable for groups or solo players looking to meet new people.",
      matchScore: 0.80,
      keyPoints: [
        "High interest in casual, social activities",
        "Great for community-building",
        "Easy-to-organize, low-maintenance setup",
        "Consistently positive feedback from previous sessions"
      ],
      metrics: {
        "Expected Attendance": "10-15",
        "Duration": "2.5 hours",
        "Repeat Rate": "85%"
      },
      guestDemographics: {
        "Solo Travelers": "40%",
        "Young Adults": "35%",
        "Families": "25%"
      },
      amenityUsage: {"Lounge": 0.90, "Refreshments Bar": 0.75},
      seasonalTrend: "Popular in cooler months",
      arguments: {
        "venue": "Lounge",
        "capacity": "20",
        "equipment": "Board games, card games"
      },
      eventTemplate: EventTemplate(
        name: "Game Night",
        icon: Icons.casino,
        description:
            "Enjoy a cozy game night with classic board games and snacks.",
        category: EventCategory.gaming,
        prefilledTitle: "Game Night",
        prefilledDescription: "Join us for a relaxed game night at the lounge.",
        isPersonalized: false,
        imageUrl: "https://example.com/game_night.jpg",
      ),
    ),
    EventSuggestionData(
      category: EventCategory.technology,
      description:
          "Casual Coding Jam, where guests can gather to work on fun coding projects or explore new tech skills together. No prior experience needed; it's all about learning and sharing!",
      matchScore: 0.82,
      keyPoints: [
        "Interest in tech among guests (notably young professionals)",
        "Opportunity to collaborate with local coding communities",
        "Low-pressure, hands-on activities",
        "Feedback from similar events shows high engagement"
      ],
      metrics: {
        "Expected Attendance": "10-15",
        "Duration": "2 hours",
        "Satisfaction Rate": "88%"
      },
      guestDemographics: {
        "Young Professionals": "50%",
        "Students": "30%",
        "Tech Enthusiasts": "20%"
      },
      amenityUsage: {"Innovation Lab": 0.65, "Study Lounge": 0.60},
      seasonalTrend: "Year-round interest",
      arguments: {
        "venue": "Innovation Lab",
        "capacity": "20",
        "equipment": "Whiteboards, Wi-Fi, Coffee station"
      },
      eventTemplate: EventTemplate(
        name: "Casual Coding Jam",
        icon: Icons.code,
        description: "Collaborate and explore coding in a casual setting.",
        category: EventCategory.technology,
        prefilledTitle: "Casual Coding Jam",
        prefilledDescription: "Join us for a relaxed evening of coding fun!",
        isPersonalized: false,
        imageUrl: "https://example.com/coding_jam.jpg",
      ),
    ),
    EventSuggestionData(
      category: EventCategory.health,
      description:
          "Sunrise Yoga Session on the rooftop, open to all skill levels. A gentle way to start the day with stretching and mindfulness, overlooking the city skyline.",
      matchScore: 0.85,
      keyPoints: [
        "Popular among wellness-oriented guests",
        "Accessible to all fitness levels",
        "Minimal equipment required",
        "Positive feedback from guests on relaxation benefits"
      ],
      metrics: {
        "Expected Attendance": "8-12",
        "Duration": "1 hour",
        "Satisfaction Rate": "90%"
      },
      guestDemographics: {
        "Wellness Enthusiasts": "60%",
        "Beginners": "25%",
        "Adventure Seekers": "15%"
      },
      amenityUsage: {"Rooftop Terrace": 0.85, "Yoga Mats": 0.80},
      seasonalTrend: "Peak in warmer months",
      arguments: {
        "venue": "Rooftop Terrace",
        "capacity": "15",
        "equipment": "Yoga mats"
      },
      eventTemplate: EventTemplate(
        name: "Sunrise Yoga",
        icon: Icons.self_improvement,
        description: "Start the day with rooftop yoga, open to all levels.",
        category: EventCategory.health,
        prefilledTitle: "Sunrise Yoga",
        prefilledDescription: "An invigorating morning yoga session.",
        isPersonalized: false,
        imageUrl: "https://example.com/sunrise_yoga.jpg",
      ),
    ),
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

  static Map<String, double> nationalityCount = {
    "Singaporean": 25.1,
    "Malaysian": 10.0,
    "Australian": 7.5,
    "American": 5.0,
    "Chinese": 9.0,
    "German": 4.0,
    "Japanese": 6.0,
    "Indonesian": 12.6,
    "British": 2.5,
    "Indian": 3.5,
  };

  static Map<String, double> ageGroupCount = {
    "0-17": 7.1,
    "18-25": 20.8,
    "26-35": 26.8,
    "36-45": 17.9,
    "46-55": 14.9,
    "56-65": 8.9,
    "66+": 4.8,
  };

  static Map<EventCategory, double> eventInterestCount = {
    EventCategory.technology: 10.7,
    EventCategory.finance: 2.7,
    EventCategory.waterSports: 2.1,
    EventCategory.music: 8.9,
    EventCategory.food: 9.8,
    EventCategory.alcohol: 6.3,
    EventCategory.sports: 3.6,
    EventCategory.art: 3.2,
    EventCategory.fashion: 1.8,
    EventCategory.health: 4.5,
    EventCategory.beauty: 2.7,
    EventCategory.travel: 5.4,
    EventCategory.networking: 8.9,
    EventCategory.education: 4.5,
    EventCategory.motorsports: 0.9,
    EventCategory.gaming: 5.4,
    EventCategory.artificialIntelligence: 3.9,
    EventCategory.engineering: 1.8,
    EventCategory.science: 3.2,
    EventCategory.environment: 3.6,
    EventCategory.politics: 1.4,
    EventCategory.business: 5.4,
    EventCategory.entertainment: 8.0,
    EventCategory.sustainability: 4.5,
    EventCategory.wellness: 7.1,
    EventCategory.pool: 2.7,
  };

  static HotelDemography hotelDemography =
      HotelDemography(nationalityCount, ageGroupCount, eventInterestCount);
}
