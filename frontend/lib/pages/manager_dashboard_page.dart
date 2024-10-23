import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_manager.dart';
import 'package:frontend/widgets/dashboard_card_widget.dart';
import 'package:frontend/widgets/manager_header_widget.dart';
import 'package:frontend/widgets/profile_header.dart';

class ManagerDashboardPage extends StatelessWidget {
  const ManagerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 21),
              const ProfileHeader(hasNotification: true),
              const SizedBox(height: 16),
              const ManagerHeaderWidget(),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: AppManagerSingleton()
                        .cardData
                        .map((data) => Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: DashboardCardWidget(data: data)))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
