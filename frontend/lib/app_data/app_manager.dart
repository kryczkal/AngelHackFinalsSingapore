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
          timeline: ReportTimeline.month);

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
        }),
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
        }),
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
        }),
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
        })
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
