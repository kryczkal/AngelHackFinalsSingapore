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
      size: const Size(double.infinity, double.infinity),
      painter: TablePreviewPainter(data: data, color: color),
    );
  }
}

class TablePreviewPainter extends CustomPainter {
  final TablePreviewData data;
  final Color color;
  final double rowPadding = 8.0;
  final double rowHeight = 10.0;

  TablePreviewPainter({required this.data, this.color = Colors.green});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.sizes.isEmpty) return;

    final paint = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final totalRowsHeight = (data.sizes.length * rowHeight) +
        ((data.sizes.length - 1) * rowPadding);

    final startY = (size.height - totalRowsHeight) / 2;

    for (int i = 0; i < data.sizes.length; i++) {
      final yPosition = startY + (i * (rowHeight + rowPadding));

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, yPosition, size.width * data.sizes[i], rowHeight),
          const Radius.circular(4),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
