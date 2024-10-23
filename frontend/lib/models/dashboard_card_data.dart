import 'package:flutter/material.dart';

class DashboardCardData {
  final String title;
  final String mainValue;
  final String subtitle;
  final Widget Function() graphFactory;
  final Widget Function()? pageFactory;

  const DashboardCardData({
    required this.title,
    required this.mainValue,
    required this.subtitle,
    required this.graphFactory,
    this.pageFactory,
  });
}
