import 'package:flutter/material.dart';
import 'dart:math';
import 'package:frontend/widgets/misc/blob.dart';

class BlobsBackground extends StatelessWidget {
  const BlobsBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final int blobCount = (screenWidth * screenHeight / 20000).round();
    final List<Widget> blobs = List.generate(blobCount, (index) {
      final random = Random();

      double width = 300 + random.nextInt(300).toDouble();
      double height = width;
      double left = random.nextDouble() * screenWidth - width / 2;
      double top = random.nextDouble() * screenHeight - height / 2;

      final List<Color> colors = [
        Colors.blue.withOpacity(0.1 + random.nextDouble() * 0.1),
        Colors.green.withOpacity(0.1 + random.nextDouble() * 0.1),
        Colors.pink.withOpacity(0.1 + random.nextDouble() * 0.1),
        Colors.orange.withOpacity(0.1 + random.nextDouble() * 0.1),
        Colors.purple.withOpacity(0.1 + random.nextDouble() * 0.1),
        Colors.teal.withOpacity(0.1 + random.nextDouble() * 0.1),
        Colors.red.withOpacity(0.1 + random.nextDouble() * 0.1),
        Colors.yellow.withOpacity(0.05 + random.nextDouble() * 0.1),
      ];
      Color color = colors[random.nextInt(colors.length)];

      return Positioned(
        top: top,
        left: left,
        child: Blob(
          width: width,
          height: height,
          color: color,
        ),
      );
    });

    return Stack(children: blobs);
  }
}
