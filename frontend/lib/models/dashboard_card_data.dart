// data_model.dart

import 'package:flutter/material.dart';

class DashboardCardData {
  final String title;
  final String mainValue;
  final String subtitle;
  final List<String> graphColors;
  final Widget Function() graphFactory;

  const DashboardCardData({
    required this.title,
    required this.mainValue,
    required this.subtitle,
    required this.graphFactory,
    required this.graphColors,
  });
}
