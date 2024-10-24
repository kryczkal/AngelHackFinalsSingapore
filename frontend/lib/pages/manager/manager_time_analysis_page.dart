import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/models/time_analysis_data.dart';
import 'package:frontend/widgets/manager/heat_map.dart';

class ManagerTimeAnalysisPage extends StatefulWidget {
  final TimeAnalysisData data;

  const ManagerTimeAnalysisPage({
    super.key,
    required this.data,
  });

  @override
  State<ManagerTimeAnalysisPage> createState() =>
      _ManagerTimeAnalysisPageState();
}

typedef DayStats = Map<String, num>;

class _ManagerTimeAnalysisPageState extends State<ManagerTimeAnalysisPage> {
  final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  // Theme colors
  static const primaryBlue = Color(0xFF1E88E5);
  static const primaryGreen = Color(0xFF2E7D32);
  static const lightBlue = Color(0xFF90CAF9);
  static const lightGreen = Color(0xFF81C784);
  static const backgroundColor = Color(0xFFFAFAFA);
  static const textBlack = Color(0xFF212121);

  @override
  Widget build(BuildContext context) {
    final stats = _calculateStatistics();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: const Text(
          'Time Analysis',
          style: TextStyle(
            color: textBlack,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildPeakTimeCards(stats),
          const SizedBox(height: 24),
          _buildWeeklyPatternsCard(stats),
          const SizedBox(height: 24),
          _buildHeatmapCard(context),
        ],
      ),
    );
  }

  Widget _buildPeakTimeCards(Map<String, dynamic> stats) {
    return Row(
      children: [
        Expanded(
          child: _buildPeakCard(
            title: 'Weekday\nPeak',
            icon: Icons.work_rounded,
            attendance: stats['weekdayPeakAttendance'],
            day: days[stats['weekdayPeakDay']],
            hour: stats['weekdayPeakHour'],
            gradientColors: const [primaryBlue, lightBlue],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildPeakCard(
            title: 'Weekend\nPeak',
            icon: Icons.weekend_rounded,
            attendance: stats['weekendPeakAttendance'],
            day: days[stats['weekendPeakDay']],
            hour: stats['weekendPeakHour'],
            gradientColors: const [primaryGreen, lightGreen],
          ),
        ),
      ],
    );
  }

  Widget _buildPeakCard({
    required String title,
    required IconData icon,
    required num attendance,
    required String day,
    required num hour,
    required List<Color> gradientColors,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(icon, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                attendance.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '$day at ${hour.toString().padLeft(2, '0')}:00',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeeklyPatternsCard(Map<String, dynamic> stats) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Weekly Patterns',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: textBlack,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: lightBlue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.analytics_rounded,
                    color: primaryBlue,
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildStatRow(
              'Average Weekday',
              stats['averageWeekday'].round().toString(),
              'people per day',
              Icons.work_rounded,
              primaryBlue,
            ),
            const SizedBox(height: 16),
            _buildStatRow(
              'Average Weekend',
              stats['averageWeekend'].round().toString(),
              'people per day',
              Icons.weekend_rounded,
              primaryGreen,
            ),
            const SizedBox(height: 24),
            const Text(
              'Daily Peaks',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textBlack,
              ),
            ),
            const SizedBox(height: 16),
            _buildDailyPeaksGrid(stats),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyPeaksGrid(Map<String, dynamic> stats) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 7,
      itemBuilder: (context, index) {
        final dayStats = stats['dailyPeaks'][index];
        final isWeekend = index > 4;
        final color = isWeekend ? primaryGreen : primaryBlue;
        final lightColor = isWeekend ? lightGreen : lightBlue;

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [color, lightColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      days[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'at ${dayStats['peakHour'].toString().padLeft(2, '0')}:00',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.people_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      dayStats['peakAttendance'].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeatmapCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Attendance Heatmap',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: textBlack,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: lightBlue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.grid_4x4_rounded,
                    color: primaryBlue,
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 1220,
              child: HeatMapChart(data: widget.data),
            ),
            const SizedBox(height: 16),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: lightBlue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: primaryBlue.withOpacity(0.3)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.touch_app_rounded, color: primaryBlue, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Tap cells to see detailed attendance',
                      style: TextStyle(
                        color: textBlack,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(
    String label,
    String value,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: textBlack,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: textBlack,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: textBlack,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Statistical calculation methods remain unchanged
  Map<String, dynamic> _calculateStatistics() {
    final dailyStats = List.generate(7, (day) => _getDayStats(day));
    final weekdayStats = dailyStats.sublist(0, 5);
    final weekendStats = dailyStats.sublist(5);

    final busiestWeekday = weekdayStats.reduce((a, b) =>
        (a['peakAttendance'] as num) > (b['peakAttendance'] as num) ? a : b);
    final busiestWeekend = weekendStats.reduce((a, b) =>
        (a['peakAttendance'] as num) > (b['peakAttendance'] as num) ? a : b);

    final weekdayPeakAttendance = busiestWeekday['peakAttendance'] as num;
    final weekendPeakAttendance = busiestWeekend['peakAttendance'] as num;

    return {
      'maxHour': weekdayPeakAttendance > weekendPeakAttendance
          ? busiestWeekday['peakHour']
          : busiestWeekend['peakHour'],
      'maxDay': weekdayPeakAttendance > weekendPeakAttendance
          ? busiestWeekday['day']
          : busiestWeekend['day'],
      'maxAttendance': max(weekdayPeakAttendance, weekendPeakAttendance),
      'weekdayPeakDay': busiestWeekday['day'],
      'weekdayPeakHour': busiestWeekday['peakHour'],
      'weekdayPeakAttendance': weekdayPeakAttendance,
      'weekendPeakDay': busiestWeekend['day'],
      'weekendPeakHour': busiestWeekend['peakHour'],
      'weekendPeakAttendance': weekendPeakAttendance,
      'averageWeekday': weekdayStats
              .map((s) => s['totalAttendance'] as num)
              .reduce((a, b) => a + b) /
          5,
      'averageWeekend': weekendStats
              .map((s) => s['totalAttendance'] as num)
              .reduce((a, b) => a + b) /
          2,
      'dailyPeaks': dailyStats,
    };
  }

  DayStats _getDayStats(int day) {
    var maxHour = 0;
    var maxAttendance = 0;
    var totalAttendance = 0;

    for (int hour = 0; hour < 24; hour++) {
      final attendance = widget.data.peoplePerHourPerWeekDay[day][hour];
      totalAttendance += attendance;
      if (attendance > maxAttendance) {
        maxAttendance = attendance;
        maxHour = hour;
      }
    }

    return {
      'day': day,
      'peakHour': maxHour,
      'peakAttendance': maxAttendance,
      'totalAttendance': totalAttendance,
    };
  }
}
