import 'package:flutter/material.dart';

class TablePreviewData {
  final List<double> sizes;

  TablePreviewData({required this.sizes});

  factory TablePreviewData.fromVariant(int variant) {
    switch (variant) {
      case 1:
        return TablePreviewData(
          sizes: [1, 1, 1],
        );
      case 2:
        return TablePreviewData(
          sizes: [0.8, 0.6],
        );
      case 3:
        return TablePreviewData(
          sizes: [0.9, 0.7, 0.8, 0.6],
        );
      default:
        return TablePreviewData(sizes: []);
    }
  }
}

class TablePreview extends StatelessWidget {
  final TablePreviewData data;
  final Color color;

  const TablePreview(
      {super.key, required this.data, this.color = Colors.green});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 60),
      painter: TablePreviewPainter(data: data, color: color),
    );
  }
}

class TablePreviewPainter extends CustomPainter {
  final TablePreviewData data;
  final Color color;

  TablePreviewPainter({required this.data, this.color = Colors.green});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < data.sizes.length; i++) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, i * 15.0, size.width * data.sizes[i], 10),
          const Radius.circular(4),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
