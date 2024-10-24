import 'package:flutter/material.dart';
import 'dart:math';

class InkSplatterBackground extends StatelessWidget {
  final double x;
  final double y;
  final double splatterRadius;
  final Color splatterColor;

  InkSplatterBackground({
    super.key,
    required this.x,
    required this.y,
    this.splatterRadius = 50.0,
    this.splatterColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: Image.asset('images/bg/bg-splatter-t.png')));
  }
}
