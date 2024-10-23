// customwidgete.dart
import 'package:flutter/material.dart';
import 'package:frontend/widgets/dashboard_card_data.dart';

class CustomDashboardWidget extends StatelessWidget {
  final List<DashboardCardData> cardData = [
    DashboardCardData(
      title: 'Total Students',
      mainValue: '12.543',
      subtitle: '80% Increase than before',
      graphType: 'bar',
      graphColors: ['#E0E5FF', '#8676F7'],
    ),
    DashboardCardData(
      title: 'Total Income',
      mainValue: '\$10.123',
      subtitle: '80% Increase in 20 Days',
      graphType: 'line',
      graphColors: ['#FFD6E0', '#E890F7'],
    ),
    DashboardCardData(
      title: 'Total Working Hours',
      mainValue: '32h 42m',
      subtitle: '80% Increase than before',
      graphType: 'wave',
      graphColors: ['#B3E5FF', '#4A90E2'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: cardData.map((data) => buildCard(data)).toList(),
      ),
    );
  }

  Widget buildCard(DashboardCardData data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side: Text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                data.mainValue,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                data.subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          // Right side: Graph and Menu Icon
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.more_horiz,
                color: Colors.grey[400],
                size: 20,
              ),
              SizedBox(height: 16),
              buildGraph(data),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildGraph(DashboardCardData data) {
    switch (data.graphType) {
      case 'bar':
        return buildBarChart(data.graphColors);
      case 'line':
        return buildLineChart(data.graphColors);
      case 'wave':
        return buildWaveChart(data.graphColors);
      default:
        return Container();
    }
  }

  Widget buildBarChart(List<String> colors) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(5, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: 8,
          height: (index + 1) * 12.0,
          decoration: BoxDecoration(
            color: Color(int.parse(colors[1].replaceAll('#', '0xff'))),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  Widget buildLineChart(List<String> colors) {
    // Simplified to return a static line curve-like shape using a container
    return Container(
      width: 60,
      height: 24,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors.map((color) => Color(int.parse(color.replaceAll('#', '0xff')))).toList(),
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget buildWaveChart(List<String> colors) {
    return Container(
      width: 60,
      height: 24,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors.map((color) => Color(int.parse(color.replaceAll('#', '0xff')))).toList(),
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
