import 'package:flutter/material.dart';

class BarChartPattern {
  final List<double> heights;
  final String name;

  const BarChartPattern({
    required this.heights,
    required this.name,
  });

  static const increasing = BarChartPattern(
    name: 'Increasing',
    heights: [0.2, 0.35, 0.5, 0.7, 0.9],
  );

  static const decreasing = BarChartPattern(
    name: 'Decreasing',
    heights: [0.9, 0.7, 0.5, 0.35, 0.2],
  );

  static const normal = BarChartPattern(
    name: 'Normal Distribution',
    heights: [0.3, 0.7, 0.9, 0.7, 0.3],
  );

  static const random = BarChartPattern(
    name: 'Random',
    heights: [0.5, 0.3, 0.8, 0.4, 0.6],
  );
}

class SimpleBarChart extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  final BarChartPattern pattern;
  final double barWidth;
  final double spacing;

  const SimpleBarChart({
    super.key,
    required this.color,
    required this.pattern,
    this.height = 40,
    this.width = 100,
    this.barWidth = 8,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          pattern.heights.length,
          (index) => Container(
            width: barWidth,
            height: height * pattern.heights[index],
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(barWidth / 2),
            ),
          ),
        ),
      ),
    );
  }
}
