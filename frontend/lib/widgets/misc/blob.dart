import 'package:flutter/material.dart';

class Blob extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const Blob({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [
          color,
          color.withOpacity(0.0),
        ], stops: [
          0.0,
          1.0
        ], center: Alignment.center, radius: 0.45),
      ),
    );
  }
}
