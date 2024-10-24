import 'dart:math' show pi;

import 'package:flutter/material.dart';

class PieChartPreviewData {
  List<double> values;
  List<Color> colors;

  PieChartPreviewData({required this.values, required this.colors});

  factory PieChartPreviewData.fromVariant(int variant) {
    switch (variant) {
      case 1:
        return PieChartPreviewData(
          values: [0.7, 0.3],
          colors: [Colors.blue, Colors.red],
        );
      case 2:
        return PieChartPreviewData(
          values: [0.4, 0.35, 0.25],
          colors: [Colors.blue, Colors.green, Colors.red],
        );
      case 3:
        return PieChartPreviewData(
          values: [0.25, 0.25, 0.25, 0.25],
          colors: [Colors.blue, Colors.green, Colors.red, Colors.orange],
        );
      default:
        return PieChartPreviewData(values: [], colors: []);
    }
  }
}

class PieChartPreviewWidget extends StatelessWidget {
  final PieChartPreviewData data;

  const PieChartPreviewWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(60, 60),
      painter: PieChartPreviewPainter(data: data),
    );
  }
}

class PieChartPreviewPainter extends CustomPainter {
  final PieChartPreviewData data;

  PieChartPreviewPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..isAntiAlias = true; // Added for smoother edges

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const startAngle = -pi / 2;

    double currentAngle = startAngle;
    for (int i = 0; i < data.values.length; i++) {
      paint.color = data.colors[i];
      final sweepAngle = 2 * pi * data.values[i];
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        currentAngle,
        sweepAngle,
        true,
        paint,
      );
      currentAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant PieChartPreviewPainter oldDelegate) {
    return oldDelegate.data != data;
  }
}
