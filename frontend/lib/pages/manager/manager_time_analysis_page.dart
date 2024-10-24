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

  @override
  Widget build(BuildContext context) {
    final stats = _calculateStatistics();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildPeakTimeCards(stats),
          const SizedBox(height: 16),
          _buildWeeklyPatternsCard(stats),
          const SizedBox(height: 16),
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
          title: 'Weekday Peak',
          icon: Icons.work,
          attendance: stats['weekdayPeakAttendance'],
          day: days[stats['weekdayPeakDay']],
          hour: stats['weekdayPeakHour'],
        )),
        const SizedBox(width: 12),
        Expanded(
            child: _buildPeakCard(
          title: 'Weekend Peak',
          icon: Icons.weekend,
          attendance: stats['weekendPeakAttendance'],
          day: days[stats['weekendPeakDay']],
          hour: stats['weekendPeakHour'],
        )),
      ],
    );
  }

  Widget _buildPeakCard({
    required String title,
    required IconData icon,
    required num attendance,
    required String day,
    required num hour,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.grey.shade600),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '$attendance people',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              '$day at ${hour.toString().padLeft(2, '0')}:00',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyPatternsCard(Map<String, dynamic> stats) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Weekly Patterns',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Icon(Icons.analytics, color: Colors.grey.shade600),
              ],
            ),
            const SizedBox(height: 16),
            _buildStatRow(
              'Average Weekday',
              stats['averageWeekday'].round().toString(),
              'people per day',
              Icons.work,
            ),
            _buildStatRow(
              'Average Weekend',
              stats['averageWeekend'].round().toString(),
              'people per day',
              Icons.weekend,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeatmapCard(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Attendance Heatmap',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Icon(Icons.grid_4x4, color: Colors.grey.shade600),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 1220,
              child: HeatMapChart(data: widget.data),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap cells to see detailed attendance',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ... Existing statistical calculation methods remain the same ...
  Map<String, dynamic> _calculateStatistics() {
    final weekdayStats = List.generate(5, (day) => _getDayStats(day));
    final weekendStats = List.generate(2, (day) => _getDayStats(day + 5));

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

  Widget _buildStatRow(
      String label, String value, String subtitle, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.grey.shade700, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
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
}
