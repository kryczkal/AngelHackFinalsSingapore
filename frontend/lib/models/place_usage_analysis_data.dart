import 'package:frontend/models/event_location_enum.dart';
import 'package:frontend/models/report_timeline_enum.dart';
import 'package:frontend/models/time_analysis_data.dart';

class PlaceUsageData {
  final EventLocationEnum location;
  final int participantCount;
  final double averageRating;
  final List<int> weeklyParticipants;
  final double occupancyRate;
  final int totalEvents;

  PlaceUsageData({
    required this.location,
    required this.participantCount,
    required this.averageRating,
    required this.weeklyParticipants,
    required this.occupancyRate,
    required this.totalEvents,
  });
}

class PlaceUsageMockDataGenerator {
  static final Map<ReportTimeline, List<PlaceUsageData>> _cache = {};

  static const Map<EventLocationEnum, int> _locationCapacities = {
    EventLocationEnum.yogaRoom: 20,
    EventLocationEnum.gym: 40,
    EventLocationEnum.conferenceRoomA: 25,
    EventLocationEnum.conferenceRoomB: 25,
    EventLocationEnum.mainHall: 100,
    EventLocationEnum.trainingRoom: 30,
    EventLocationEnum.outdoorArea: 50,
  };

  static const Map<EventLocationEnum, double> _baseRatings = {
    EventLocationEnum.yogaRoom: 4.7,
    EventLocationEnum.gym: 4.5,
    EventLocationEnum.conferenceRoomA: 4.3,
    EventLocationEnum.conferenceRoomB: 4.4,
    EventLocationEnum.mainHall: 4.8,
    EventLocationEnum.trainingRoom: 4.2,
    EventLocationEnum.outdoorArea: 4.9,
  };

  static List<PlaceUsageData> getData(ReportTimeline timeline) {
    if (_cache.containsKey(timeline)) {
      return _cache[timeline]!;
    }

    final timeAnalysisData = TimeAnalysisMock.getData(timeline);
    final data = _generateData(timeline, timeAnalysisData);
    _cache[timeline] = data;
    return data;
  }

  static void clearCache() {
    _cache.clear();
  }

  static List<PlaceUsageData> _generateData(
    ReportTimeline timeline,
    TimeAnalysisData timeData,
  ) {
    final List<PlaceUsageData> placeData = [];

    for (final location in EventLocationEnum.values) {
      final capacity = _locationCapacities[location]!;
      final baseRating = _baseRatings[location]!;

      final weeklyParticipants = _calculateWeeklyParticipants(
        timeData,
        capacity,
        location,
      );

      final (totalParticipants, totalEvents) = _calculateTotals(
        weeklyParticipants,
        timeline,
        location,
      );

      final occupancyRate = _calculateOccupancyRate(
        totalParticipants,
        totalEvents,
        capacity,
        timeline,
      );

      placeData.add(PlaceUsageData(
        location: location,
        participantCount: totalParticipants,
        averageRating: _adjustRating(baseRating, occupancyRate),
        weeklyParticipants: weeklyParticipants,
        occupancyRate: occupancyRate,
        totalEvents: totalEvents,
      ));
    }

    return placeData;
  }

  static List<int> _calculateWeeklyParticipants(
    TimeAnalysisData timeData,
    int capacity,
    EventLocationEnum location,
  ) {
    final List<int> weeklyParticipants = List.filled(7, 0);

    for (int day = 0; day < 7; day++) {
      final peakHours = _getLocationPeakHours(location);

      int dailyTotal = 0;
      for (final hour in peakHours) {
        dailyTotal += timeData.peoplePerHourPerWeekDay[day][hour];
      }

      final adjustedParticipants =
          (dailyTotal * _getLocationUsageFactor(location))
              .round()
              .clamp(0, capacity * peakHours.length);

      weeklyParticipants[day] = adjustedParticipants;
    }

    return weeklyParticipants;
  }

  static (int participants, int events) _calculateTotals(
    List<int> weeklyParticipants,
    ReportTimeline timeline,
    EventLocationEnum location,
  ) {
    final weeksInPeriod = switch (timeline) {
      ReportTimeline.week => 1,
      ReportTimeline.month => 4,
      ReportTimeline.sixMonths => 24,
    };

    final weeklyTotal = weeklyParticipants.reduce((a, b) => a + b);
    final weeklyEvents = _getWeeklyEventsCount(location);

    final diminishingFactor = switch (timeline) {
      ReportTimeline.week => 1.0,
      ReportTimeline.month => 0.85,
      ReportTimeline.sixMonths => 0.65,
    };

    return (
      (weeklyTotal * weeksInPeriod * diminishingFactor).round(),
      (weeklyEvents * weeksInPeriod * diminishingFactor).round(),
    );
  }

  static double _calculateOccupancyRate(
    int totalParticipants,
    int totalEvents,
    int capacity,
    ReportTimeline timeline,
  ) {
    if (totalEvents == 0) return 0.0;

    final variabilityFactor = switch (timeline) {
      ReportTimeline.week => 1.0,
      ReportTimeline.month => 1.3,
      ReportTimeline.sixMonths => 4.2,
    };

    final baseOccupancy = (totalParticipants /
        (totalEvents * capacity * timeline.periodInDays / 7));
    return (baseOccupancy * variabilityFactor).clamp(0.0, 0.95);
  }

  static double _adjustRating(double baseRating, double occupancyRate) {
    final adjustment = (occupancyRate - 0.6) * 0.1;
    return (baseRating + adjustment).clamp(1.0, 5.0);
  }

  static List<int> _getLocationPeakHours(EventLocationEnum location) {
    return switch (location) {
      EventLocationEnum.yogaRoom => [
          6,
          7,
          8,
          17,
          18,
          19
        ], // Early morning and evening
      EventLocationEnum.gym => [
          6,
          7,
          8,
          9,
          16,
          17,
          18,
          19,
          20
        ], // Morning and evening
      EventLocationEnum.conferenceRoomA ||
      EventLocationEnum.conferenceRoomB =>
        [9, 10, 11, 13, 14, 15, 16], // Business hours
      EventLocationEnum.mainHall => [
          9,
          10,
          11,
          12,
          13,
          14,
          15,
          16,
          17,
          18
        ], // All day
      EventLocationEnum.trainingRoom => [
          9,
          10,
          11,
          13,
          14,
          15,
          16
        ], // Business hours
      EventLocationEnum.outdoorArea => [
          8,
          9,
          10,
          11,
          15,
          16,
          17,
          18
        ], // Morning and late afternoon
    };
  }

  static double _getLocationUsageFactor(EventLocationEnum location) {
    return switch (location) {
      EventLocationEnum.yogaRoom => 0.15,
      EventLocationEnum.gym => 0.25,
      EventLocationEnum.conferenceRoomA => 0.12,
      EventLocationEnum.conferenceRoomB => 0.12,
      EventLocationEnum.mainHall => 0.35,
      EventLocationEnum.trainingRoom => 0.15,
      EventLocationEnum.outdoorArea => 0.20,
    };
  }

  static int _getWeeklyEventsCount(EventLocationEnum location) {
    return switch (location) {
      EventLocationEnum.yogaRoom => 28,
      EventLocationEnum.gym => 42,
      EventLocationEnum.conferenceRoomA => 15,
      EventLocationEnum.conferenceRoomB => 12,
      EventLocationEnum.mainHall => 35,
      EventLocationEnum.trainingRoom => 25,
      EventLocationEnum.outdoorArea => 30,
    };
  }
}
