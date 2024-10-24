import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/models/time_analysis_data.dart';

class HeatMapChart extends StatelessWidget {
  final TimeAnalysisData data;

  const HeatMapChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      data: data.peoplePerHourPerWeekDay,
      maxValue: _calculateMaxValue(data.peoplePerHourPerWeekDay),
    );
  }

  double _calculateMaxValue(List<List<int>> data) {
    return data.expand((element) => element).reduce(max).toDouble();
  }
}

class HeatMap extends StatelessWidget {
  static const _hourLabelWidth = 32.0;
  static const _dayLabelHeight = 32.0;
  static const _hourHeight = 48.0;
  static const _weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  final List<List<int>> data;
  final double maxValue;

  const HeatMap({
    super.key,
    required this.data,
    required this.maxValue,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dayWidth = _calculateDayWidth(constraints.maxWidth);
        return Column(
          children: [
            _buildDayLabelsRow(dayWidth),
            Expanded(
              child: _buildHeatMapGrid(context, dayWidth),
            ),
          ],
        );
      },
    );
  }

  double _calculateDayWidth(double availableWidth) {
    return (availableWidth - _hourLabelWidth) / 7;
  }

  Widget _buildDayLabelsRow(double dayWidth) {
    return Container(
      height: _dayLabelHeight,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: _hourLabelWidth),
          ..._buildDayLabels(dayWidth),
        ],
      ),
    );
  }

  List<Widget> _buildDayLabels(double dayWidth) {
    return List.generate(7, (day) {
      return SizedBox(
        width: dayWidth,
        child: Center(
          child: Text(
            _weekDays[day],
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildHeatMapGrid(BuildContext context, double dayWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHourLabelsColumn(),
        ..._buildDayColumns(context, dayWidth),
      ],
    );
  }

  Widget _buildHourLabelsColumn() {
    return Container(
      width: _hourLabelWidth,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: List.generate(24, (hour) => _buildHourLabel(hour)),
      ),
    );
  }

  Widget _buildHourLabel(int hour) {
    return Container(
      margin: const EdgeInsets.all(0.5),
      child: SizedBox(
        height: _hourHeight,
        child: Center(
          child: Text(
            hour.toString().padLeft(2, '0'),
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDayColumns(BuildContext context, double dayWidth) {
    return List.generate(7, (day) {
      return SizedBox(
        width: dayWidth,
        child: Column(
          children: List.generate(
            24,
            (hour) => _buildHeatMapCell(context, day, hour, dayWidth),
          ),
        ),
      );
    });
  }

  Widget _buildHeatMapCell(
    BuildContext context,
    int day,
    int hour,
    double dayWidth,
  ) {
    final value = data[day][hour].toDouble();
    final percentage = (value / maxValue).clamp(0.1, 1.0);
    final formattedHour = hour.toString().padLeft(2, '0');
    final message = '${value.round()} people\n$formattedHour:00';

    return Container(
      width: dayWidth,
      height: _hourHeight,
      margin: const EdgeInsets.all(0.5),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(percentage),
        borderRadius: BorderRadius.circular(2),
      ),
      child: _buildCellContent(context, message, value, formattedHour),
    );
  }

  Widget _buildCellContent(
    BuildContext context,
    String tooltipMessage,
    double value,
    String formattedHour,
  ) {
    return Tooltip(
      message: tooltipMessage,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showSnackBar(context, value, formattedHour),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, double value, String formattedHour) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${value.round()} people at $formattedHour:00',
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.black87,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
