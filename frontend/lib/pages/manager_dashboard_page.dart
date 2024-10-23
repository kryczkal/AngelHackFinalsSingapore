import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_manager.dart';
import 'package:frontend/widgets/dashboard_card_widget.dart';

class ManagerDashboardPage extends StatelessWidget {
  const ManagerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: AppManagerSingleton()
              .cardData
              .map((data) => DashboardCardWidget(data: data))
              .toList(),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
