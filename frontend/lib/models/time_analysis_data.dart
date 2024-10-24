import 'dart:math';

class TimeAnalysisData {
  final List<List<int>> peoplePerHourPerWeekDay;

  TimeAnalysisData({
    required this.peoplePerHourPerWeekDay,
  });
}

class TimeAnalysisMock {
  static TimeAnalysisData generateWeekData() {
    return _generateData(1.0);
  }

  static TimeAnalysisData generateMonthData() {
    return _generateData(4.0);
  }

  static TimeAnalysisData generateSixMonthData() {
    return _generateData(24.0);
  }

  static TimeAnalysisData _generateData(double multiplier) {
    final random = Random();
    final List<List<int>> data =
        List.generate(7, (index) => List.filled(24, 0));

    // Base attendance patterns
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

        // Add some randomness
        final variance = random.nextDouble() * 0.3 + 0.85; // 85%-115% variance

        // Add weekly patterns (busier on certain days)
        final dayMultiplier = switch (day) {
          0 => 0.9, // Monday slightly slower
          4 => 1.1, // Friday slightly busier
          5 => 1.2, // Saturday busiest
          6 => 1.1, // Sunday busy
          _ => 1.0, // Regular weekdays
        };

        // Calculate final attendance
        final averageAttendance =
            (basePattern * multiplier * variance * dayMultiplier).round();

        // Add seasonal variations for longer periods
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
}