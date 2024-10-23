import 'package:flutter/material.dart';
import 'package:frontend/models/dashboard_card_data.dart';

class DashboardCardWidget extends StatelessWidget {
  final DashboardCardData data;

  const DashboardCardWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            spacing: 8,
            alignment: WrapAlignment.start,
            direction: Axis.vertical,
            children: [
              Text(
                data.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                data.mainValue,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                data.subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Wrap(
            spacing: 16,
            direction: Axis.vertical,
            alignment: WrapAlignment.end,
            children: [
              Icon(
                Icons.more_horiz,
                color: Colors.grey[400],
                size: 20,
              ),
              data.graphFactory(),
            ],
          ),
        ],
      ),
    );
  }
}
