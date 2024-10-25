import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/event_location_enum.dart';
import 'package:frontend/models/place_usage_analysis_data.dart';
import 'package:frontend/widgets/misc/scroll_behavior_web_extended.dart';

class PlaceUsageAnalysisPage extends StatefulWidget {
  final List<PlaceUsageData> data;
  final String period;

  const PlaceUsageAnalysisPage({
    super.key,
    required this.data,
    required this.period,
  });

  @override
  State<PlaceUsageAnalysisPage> createState() => _PlaceUsageAnalysisPageState();
}

class _PlaceUsageAnalysisPageState extends State<PlaceUsageAnalysisPage>
    with SingleTickerProviderStateMixin {
  bool showEvents = false;
  int? selectedPieSection;
  late AnimationController _animationController;
  late Animation<double> _animation;

  final _backgroundKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    selectedPieSection = null;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleDataView() {
    setState(() {
      showEvents = !showEvents;
      if (showEvents) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1A73E8);
    const secondaryColor = Color(0xFF34A853);
    final backgroundColor = Colors.grey[50];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Space Analytics',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehaviorWebExtended().copyWith(scrollbars: false),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildChartCard(
              title: 'Place Usage Overview',
              child: Column(
                children: [
                  _buildToggleSwitch(),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 350,
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return _buildBarChart(widget.data, primaryColor);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildChartCard(
              title: 'Occupancy Rates',
              child: SizedBox(
                height: 250,
                child: _buildLineChart(widget.data, secondaryColor),
              ),
            ),
            const SizedBox(height: 20),
            _buildChartCard(
              title: 'Attendance Distribution',
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: _buildEnhancedPieChart(widget.data, primaryColor),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E88E5).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color: const Color(0xFF1E88E5).withOpacity(0.3)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.touch_app_rounded,
                              color: Color(0xFF1E88E5), size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Tap pie chart sections to view details',
                            style: TextStyle(
                              color: Color(0xFF212121),
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
            const SizedBox(height: 20),
            ...widget.data
                .map((item) => _buildLocationCard(item, primaryColor)),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard({required String title, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 24),
          child,
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: selectedPieSection != null &&
                    selectedPieSection! >= 0 &&
                    selectedPieSection! < widget.data.length &&
                    title == 'Attendance Distribution'
                ? Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: _buildPieChartDetails(
                      widget.data[selectedPieSection!],
                      const Color(0xFF1A73E8),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleSwitch() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildToggleButton(
              text: 'Participants',
              isSelected: !showEvents,
              onTap: () {
                if (showEvents) _toggleDataView();
              },
            ),
            _buildToggleButton(
              text: 'Events',
              isSelected: showEvents,
              onTap: () {
                if (!showEvents) _toggleDataView();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A73E8) : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildBarChart(List<PlaceUsageData> data, Color color) {
    final maxParticipants =
        data.map((e) => e.participantCount.toDouble()).reduce(max);
    final maxEvents = data.map((e) => e.totalEvents.toDouble()).reduce(max);
    final currentMaxValue = showEvents ? maxEvents : maxParticipants;
    final interval = _calculateGridInterval(currentMaxValue);

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceEvenly,
        maxY: currentMaxValue * 1.2,
        barGroups: data.asMap().entries.map((entry) {
          final value = showEvents
              ? entry.value.totalEvents.toDouble()
              : entry.value.participantCount.toDouble();

          return BarChartGroupData(
            x: entry.key,
            barRods: [
              BarChartRodData(
                toY: value,
                color: color,
                width: 20,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          );
        }).toList(),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value < 0 || value >= data.length) return const Text('');
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    data[value.toInt()].location.icon,
                    size: 20,
                    color: Colors.black54,
                  ),
                );
              },
              reservedSize: 60,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                // Only show the value if it's a multiple of the interval
                if (value % interval != 0) return const Text('');
                // Don't show the value if it exceeds our maxY
                if (value > currentMaxValue * 1.2) return const Text('');
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(fontSize: 11, color: Colors.black87),
                );
              },
              interval: interval,
            ),
          ),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: false,
          horizontalInterval: interval,
          getDrawingHorizontalLine: (value) {
            return const FlLine(
              color: Colors.black12,
              strokeWidth: 1,
              dashArray: [5, 5],
            );
          },
        ),
        borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(color: Colors.black12),
          ),
        ),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => Colors.blueGrey.shade900,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final value = rod.toY.toInt();
              return BarTooltipItem(
                '${data[group.x].location.toDisplayString()}\n'
                '${showEvents ? "$value events" : "$value participants"}',
                const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLineChart(List<PlaceUsageData> data, Color color) {
    return LineChart(
      LineChartData(
        gridData: const FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 0.2,
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value < 0 || value >= data.length) return const Text('');
                return Icon(
                  data[value.toInt()].location.icon,
                  size: 20,
                  color: Colors.black54,
                );
              },
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${(value * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black87,
                  ),
                );
              },
            ),
          ),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: data.asMap().entries.map((entry) {
              return FlSpot(entry.key.toDouble(), entry.value.occupancyRate);
            }).toList(),
            isCurved: true,
            color: color,
            barWidth: 3,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, bar, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: Colors.white,
                  strokeWidth: 2,
                  strokeColor: color,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              color: color.withOpacity(0.1),
            ),
          ),
        ],
        minY: 0,
        maxY: 1,
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (_) => Colors.blueGrey.shade900,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final locationName =
                    data[spot.x.toInt()].location.toDisplayString();
                return LineTooltipItem(
                  '$locationName\n${(spot.y * 100).toInt()}% occupied',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedBadge(PlaceUsageData data) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(data.location.icon, size: 20, color: const Color(0xFF1A73E8)),
          const SizedBox(width: 8),
          Text(
            data.location.toDisplayString(),
            style: const TextStyle(
              color: Color(0xFF1A73E8),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedPieChart(List<PlaceUsageData> data, Color baseColor) {
    final totalParticipants =
        data.fold(0, (sum, item) => sum + item.participantCount);

    return GestureDetector(
      key: _backgroundKey,
      onTapDown: (details) {
        setState(() {
          selectedPieSection = null;
        });
      },
      behavior: HitTestBehavior.translucent,
      child: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 40,
          sections: data.asMap().entries.map((entry) {
            final percentage = entry.value.participantCount / totalParticipants;
            final isSelected = selectedPieSection == entry.key;

            return PieChartSectionData(
              color: baseColor.withOpacity(0.3 + (percentage * 0.7)),
              value: entry.value.participantCount.toDouble(),
              title: '${(percentage * 100).toInt()}%',
              radius: isSelected ? 110 : 100,
              titleStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              showTitle: true,
              badgeWidget: isSelected ? _buildSelectedBadge(entry.value) : null,
              badgePositionPercentageOffset: 1.2,
            );
          }).toList(),
          pieTouchData: PieTouchData(
            enabled: true,
            touchCallback: (FlTouchEvent event, PieTouchResponse? response) {
              // Only handle touch down events
              if (event.runtimeType != FlTapDownEvent) return;

              setState(() {
                if (response?.touchedSection != null) {
                  final touchedIndex =
                      response!.touchedSection!.touchedSectionIndex;
                  if (touchedIndex >= 0 && touchedIndex < data.length) {
                    // Toggle selection
                    selectedPieSection = selectedPieSection == touchedIndex
                        ? null
                        : touchedIndex;
                  }
                }
              });
            },
          ),
        ),
      ),
    );
  }

  double _calculateGridInterval(double maxValue) {
    double baseInterval = 1;
    if (maxValue <= 10) {
      baseInterval = 1;
    } else if (maxValue <= 50) {
      baseInterval = 5;
    } else if (maxValue <= 100) {
      baseInterval = 10;
    } else if (maxValue <= 500) {
      baseInterval = 50;
    } else if (maxValue <= 1000) {
      baseInterval = 100;
    } else {
      baseInterval = pow(10, (log(maxValue) / ln10).floor() - 1).toDouble();
    }

    double interval = baseInterval;
    while (maxValue / interval > 10) {
      interval *= 2;
    }

    return interval;
  }

  Widget _buildPieChartDetails(PlaceUsageData data, Color color) {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(data.location.icon, color: color, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.location.toDisplayString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${data.participantCount} participants · ${data.totalEvents} events',
                  style: TextStyle(
                    color: Colors.black87.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Average rating: ${data.averageRating.toStringAsFixed(1)}',
                  style: TextStyle(
                    color: Colors.black87.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard(PlaceUsageData item, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(item.location.icon, color: color),
        ),
        title: Text(
          item.location.toDisplayString(),
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          '${item.totalEvents} events · ${item.participantCount} participants',
          style: const TextStyle(color: Colors.black54),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, size: 18, color: Colors.amber),
              const SizedBox(width: 4),
              Text(
                item.averageRating.toStringAsFixed(1),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.amber[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
