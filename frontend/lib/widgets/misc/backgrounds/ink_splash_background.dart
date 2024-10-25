import 'package:flutter/material.dart';
import 'dart:math';

class InkSplatterBackground extends StatelessWidget {
  InkSplatterBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: Image.asset('images/bg/bg-splatter-t.png')));
  }
}
