import 'dart:math';

import 'package:frontend/models/report_timeline_enum.dart';

class TimeAnalysisData {
  final List<List<int>> peoplePerHourPerWeekDay;

  TimeAnalysisData({
    required this.peoplePerHourPerWeekDay,
  });
}

class TimeAnalysisMock {
  static final Map<ReportTimeline, TimeAnalysisData> _cache = {};
  static bool hasData(ReportTimeline timeline) => _cache.containsKey(timeline);
  static TimeAnalysisData getData(ReportTimeline time) {
    if (_cache.containsKey(time)) {
      return _cache[time]!;
    }
    final data = switch (time) {
      ReportTimeline.week => _generateData(1.0),
      ReportTimeline.month => _generateData(4.0),
      ReportTimeline.sixMonths => _generateData(24.0),
    };

    _cache[time] = data;
    return data;
  }

  static void clearCache() {
    _cache.clear();
  }

  static (int weekDay, int hour) findBusiestTime(TimeAnalysisData data) {
    int maxPeople = 0;
    int busiestDay = 0;
    int busiestHour = 0;

    for (int day = 0; day < data.peoplePerHourPerWeekDay.length; day++) {
      for (int hour = 0;
          hour < data.peoplePerHourPerWeekDay[day].length;
          hour++) {
        int currentPeople = data.peoplePerHourPerWeekDay[day][hour];
        if (currentPeople > maxPeople) {
          maxPeople = currentPeople;
          busiestDay = day;
          busiestHour = hour;
        }
      }
    }

    return (busiestDay, busiestHour);
  }

  static TimeAnalysisData _generateData(double multiplier) {
    final random = Random(42);
    final List<List<int>> data =
        List.generate(7, (index) => List.filled(24, 0));

    final workdayPattern = [
      0, 0, 0, 0, 0, 2, 5, 10, // 12am-8am
      15, 20, 25, 35, 45, 40, 30, 25, // 8am-4pm
      30, 45, 50, 40, 25, 15, 5, 2 // 4pm-12am
    ];

    final weekendPattern = [
      0, 0, 0, 0, 0, 0, 5, 10, // 12am-8am
      25, 45, 60, 70, 75, 70, 65, 60, // 8am-4pm
      65, 70, 80, 75, 60, 40, 20, 5 // 4pm-12am
    ];

    for (int day = 0; day < 7; day++) {
      for (int hour = 0; hour < 24; hour++) {
        final basePattern =
            (day < 5) ? workdayPattern[hour] : weekendPattern[hour];

        final variance = random.nextDouble() * 0.3 + 0.85;

        final dayMultiplier = switch (day) {
          0 => 0.9, // Monday slightly slower
          4 => 1.1, // Friday slightly busier
          5 => 1.2, // Saturday busiest
          6 => 1.1, // Sunday busy
          _ => 1.0, // Regular weekdays
        };

        final averageAttendance =
            (basePattern * multiplier * variance * dayMultiplier).round();

        if (multiplier > 1.0) {
          final seasonalFactor =
              1.0 + (sin(2 * pi * (random.nextDouble() - 0.5)) * 0.15);
          data[day][hour] = (averageAttendance * seasonalFactor).round();
        } else {
          data[day][hour] = averageAttendance;
        }
      }
    }

    return TimeAnalysisData(peoplePerHourPerWeekDay: data);
  }

  static String getDayOfWeek(int dayNumber) {
    return switch (dayNumber) {
      0 => "Monday",
      1 => "Tuesday",
      2 => "Wednesday",
      3 => "Thursday",
      4 => "Friday",
      5 => "Saturday",
      6 => "Sunday",
      _ => "Invalid day",
    };
  }

  static String convertHourToTimeFormat(int hour) {
    if (hour < 0 || hour >= 24) return "Invalid hour";

    int twelveHourFormat = hour % 12 == 0 ? 12 : hour % 12;
    String period = hour >= 12 ? "PM" : "AM";

    return "$twelveHourFormat:00 $period";
  }
}
