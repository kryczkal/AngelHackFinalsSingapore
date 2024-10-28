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
    // TODO: Modify the data to match the actual LYF hotel data
    EventSuggestionData(
      category: EventCategory.technology,
      description:
          "AI & Machine Learning Workshop focused on practical applications in hospitality. This hands-on session will cover emerging trends, real-world case studies, and networking opportunities with industry experts.",
      matchScore: 0.94,
      keyPoints: [
        "High concentration of tech-savvy guests (45% increase)",
        "Recent surge in AI-related inquiries",
        "Perfect alignment with Innovation Week",
        "Similar workshops had 92% engagement rate"
      ],
      metrics: {
        "Expected Attendance": "75-100",
        "Duration": "4 hours",
        "Previous Success Rate": "92%"
      },
      guestDemographics: {
        "Tech Professionals": "45%",
        "Business Leaders": "30%",
        "Students": "25%"
      },
      amenityUsage: {"Innovation Lab": 0.88, "Conference Room A": 0.75},
      seasonalTrend: "Peak in Q4",
      arguments: {
        "venue": "Innovation Lab",
        "capacity": "100",
        "equipment": "High-speed internet, Display screens"
      },
      eventTemplate: EventTemplate(
        name: "AI & Machine Learning Workshop",
        icon: Icons.computer, // For a tech-focused event
        description:
            "Hands-on session covering AI trends in hospitality with networking opportunities.",
        category: EventCategory.technology,
        prefilledTitle: "AI & Machine Learning Workshop",
        prefilledDescription:
            "Learn practical AI applications in the industry.",
        isPersonalized: true,
        imageUrl: "https://example.com/ai_workshop.jpg",
      ),
    ),
    EventSuggestionData(
        category: EventCategory.waterSports,
        description:
            "Sunset Beach Yoga & Surf Session combining wellness and water sports. Perfect for beginners and intermediate surfers, includes professional instructors and all necessary equipment.",
        matchScore: 0.89,
        keyPoints: [
          "Beach facilities currently underutilized in evenings",
          "Growing wellness trend among guests",
          "Positive feedback from pilot sessions",
          "Ideal weather conditions predicted"
        ],
        metrics: {
          "Expected Attendance": "20-25",
          "Duration": "2.5 hours",
          "Equipment Utilization": "85%"
        },
        guestDemographics: {
          "Wellness Enthusiasts": "40%",
          "Adventure Seekers": "35%",
          "Beginners": "25%"
        },
        amenityUsage: {"Private Beach": 0.92, "Surf Equipment": 0.78},
        seasonalTrend: "Summer Peak",
        arguments: {
          "venue": "Private Beach",
          "capacity": "25",
          "equipment": "Surfboards, Yoga mats"
        },
        eventTemplate: EventTemplate(
          name: "Sunset Beach Yoga",
          icon: Icons.sports, // Symbolizes water sports and wellness
          description:
              "A combined yoga and surf session for wellness enthusiasts.",
          category: EventCategory.health,
          prefilledTitle: "Sunset Beach Yoga",
          prefilledDescription:
              "A blend of beach yoga and surfing with professional instructors.",
          isPersonalized: true,
          imageUrl: "https://example.com/beach_yoga.jpg",
        )),
    EventSuggestionData(
      category: EventCategory.food,
      description:
          "Farm-to-Table Cooking Masterclass featuring local ingredients and traditional techniques. Participants will learn sustainable cooking practices and enjoy their creations in a communal dining experience.",
      matchScore: 0.91,
      keyPoints: [
        "Local produce partnership opportunity",
        "Aligns with sustainability initiatives",
        "High demand for culinary experiences",
        "Instagram-worthy content potential"
      ],
      metrics: {
        "Expected Attendance": "15-20",
        "Duration": "3 hours",
        "Satisfaction Rate": "95%"
      },
      guestDemographics: {
        "Food Enthusiasts": "50%",
        "Sustainability Advocates": "30%",
        "Photography Enthusiasts": "20%"
      },
      amenityUsage: {"Culinary Studio": 0.95, "Herb Garden": 0.85},
      seasonalTrend: "Year-round",
      arguments: {
        "venue": "Culinary Studio",
        "capacity": "20",
        "requirements": "Fresh ingredients, Cooking stations"
      },
      eventTemplate: EventTemplate(
        name: "Farm-to-Table Cooking",
        icon: Icons.restaurant, // Represents culinary events
        description:
            "Masterclass using local ingredients with sustainable cooking techniques.",
        category: EventCategory.food,
        prefilledTitle: "Farm-to-Table Cooking Masterclass",
        prefilledDescription:
            "Engage in a hands-on culinary experience with fresh ingredients.",
        isPersonalized: true,
        imageUrl: "https://example.com/cooking_masterclass.jpg",
      ),
    ),
    EventSuggestionData(
      category: EventCategory.networking,
      description:
          "Global Entrepreneurs Mixer connecting international business leaders with local startups. Features speed networking, pitch sessions, and interactive panel discussions.",
      matchScore: 0.87,
      keyPoints: [
        "High concentration of business travelers",
        "Partner with local startup hub",
        "Previous networking events sold out",
        "Multiple sponsorship opportunities"
      ],
      metrics: {
        "Expected Attendance": "100-120",
        "Duration": "3 hours",
        "Connection Rate": "85%"
      },
      guestDemographics: {
        "Entrepreneurs": "40%",
        "Investors": "30%",
        "Industry Experts": "30%"
      },
      amenityUsage: {"Grand Ballroom": 0.90, "Business Lounge": 0.82},
      seasonalTrend: "Business Season",
      arguments: {
        "venue": "Grand Ballroom",
        "capacity": "120",
        "setup": "Round tables, Presentation equipment"
      },
      eventTemplate: EventTemplate(
        name: "Global Entrepreneurs Mixer",
        icon: Icons.business_center, // Signifies a business networking theme
        description:
            "Networking mixer with panels, speed networking, and pitch sessions.",
        category: EventCategory.networking,
        prefilledTitle: "Global Entrepreneurs Mixer",
        prefilledDescription:
            "An interactive event connecting startups and business leaders.",
        isPersonalized: false,
        imageUrl: "https://example.com/entrepreneur_mixer.jpg",
      ),
    )
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

  static Map<String, int> nationalityCount = {
    "Singaporean": 50,
    "Malaysian": 20,
    "Australian": 15,
    "American": 10,
    "Chinese": 18,
    "German": 8,
    "Japanese": 12,
    "Indonesian": 25,
    "British": 5,
    "Indian": 7,
  };

  static Map<String, int> ageGroupCount = {
    "0-17": 12,
    "18-25": 35,
    "26-35": 45,
    "36-45": 30,
    "46-55": 25,
    "56-65": 15,
    "66+": 8,
  };

  static Map<EventCategory, int> eventInterestCount = {
    EventCategory.technology: 60, // Tech-savvy and young crowd
    EventCategory.finance: 15, // Some interest in finance-related events
    EventCategory.waterSports:
        12, // Limited interest in outdoor water activities
    EventCategory.music: 50, // High interest in music events
    EventCategory.food: 55, // High interest in food-related events
    EventCategory.alcohol: 35, // Moderate interest in nightlife
    EventCategory.sports: 20, // Interest in sports events
    EventCategory.art: 18, // Some interest in art exhibits
    EventCategory.fashion: 10, // Niche interest in fashion
    EventCategory.health: 25, // Wellness-conscious crowd
    EventCategory.beauty: 15, // Moderate interest in beauty-related events
    EventCategory.travel: 30, // Interest in travel and adventure
    EventCategory.networking: 50, // High interest in networking opportunities
    EventCategory.education: 25, // Interest in learning and workshops
    EventCategory.motorsports: 5, // Limited interest in motorsports
    EventCategory.gaming: 30, // Significant interest in gaming events
    EventCategory.artificialIntelligence: 22, // Growing interest in AI and tech
    EventCategory.engineering: 10, // Niche interest in engineering topics
    EventCategory.science: 18, // Interest in science-related events
    EventCategory.environment: 20, // Environmentally conscious guests
    EventCategory.politics: 8, // Low interest in politics-related events
    EventCategory.business: 30, // Interest in business and entrepreneurship
    EventCategory.entertainment: 45, // High interest in general entertainment
    EventCategory.sustainability: 25, // Interest in sustainable practices
    EventCategory.wellness: 40, // Strong focus on wellness
    EventCategory.pool: 15, // Moderate interest in poolside activities
  };

  static HotelDemography hotelDemography =
      HotelDemography(nationalityCount, ageGroupCount, eventInterestCount);
}
