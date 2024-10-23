import 'package:flutter/material.dart';

class LineChartPattern {
  final List<double> points;
  const LineChartPattern(this.points);

  static const upward = LineChartPattern([0.6, 0.4, 0.3, 0.2, 0.3, 0.1]);
  static const downward = LineChartPattern([0.2, 0.3, 0.4, 0.5, 0.6, 0.7]);
  static const volatile = LineChartPattern([0.5, 0.2, 0.6, 0.3, 0.7, 0.4]);
}

class LineChartWidget extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  final LineChartPattern pattern;

  const LineChartWidget({
    super.key,
    required this.color,
    required this.pattern,
    this.height = 24,
    this.width = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: ClipPath(
        clipper: CurveClipper(pattern: pattern),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [color.withOpacity(0.8), color.withOpacity(0.1)],
            ),
          ),
          child: CustomPaint(
            painter: LinePainter(color: color, pattern: pattern),
          ),
        ),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  final LineChartPattern pattern;

  CurveClipper({required this.pattern});

  @override
  Path getClip(Size size) {
    final path = Path();
    final points = pattern.points;
    final segmentWidth = size.width / (points.length - 1);

    path.moveTo(0, 0);
    path.lineTo(0, size.height * points[0]);

    for (int i = 0; i < points.length - 1; i++) {
      final x1 = segmentWidth * i;
      final x2 = segmentWidth * (i + 1);
      final y1 = size.height * points[i];
      final y2 = size.height * points[i + 1];

      final controlX = (x1 + x2) / 2;
      path.quadraticBezierTo(
        controlX,
        y1,
        x2,
        y2,
      );
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class LinePainter extends CustomPainter {
  final Color color;
  final LineChartPattern pattern;

  LinePainter({required this.color, required this.pattern});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path();
    final points = pattern.points;
    final segmentWidth = size.width / (points.length - 1);

    path.moveTo(0, size.height * points[0]);

    for (int i = 0; i < points.length - 1; i++) {
      final x1 = segmentWidth * i;
      final x2 = segmentWidth * (i + 1);
      final y1 = size.height * points[i];
      final y2 = size.height * points[i + 1];

      final controlX = (x1 + x2) / 2;
      path.quadraticBezierTo(
        controlX,
        y1,
        x2,
        y2,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
