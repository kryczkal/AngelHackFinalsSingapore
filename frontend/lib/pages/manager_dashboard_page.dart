import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_manager.dart';
import 'package:frontend/models/report_data.dart';
import 'package:frontend/models/report_timeline_enum.dart';
import 'package:frontend/pages/blank_page.dart';
import 'package:frontend/widgets/dashboard_card_widget.dart';
import 'package:frontend/widgets/manager_header_widget.dart';
import 'package:frontend/widgets/profile_header.dart';

class ManagerDashboardPage extends StatefulWidget {
  const ManagerDashboardPage({super.key});

  @override
  State<ManagerDashboardPage> createState() => _ManagerDashboardPageState();
}

class _ManagerDashboardPageState extends State<ManagerDashboardPage> {
  final Map<ReportTimeline, ReportData> _reportData =
      AppManagerSingleton().reportData;
  ReportTimeline _selectedTimeline = ReportTimeline.week;

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
              ManagerHeaderWidget(
                  reportData: _reportData,
                  onTimelineChanged: (timeline) {
                    setState(() {
                      _selectedTimeline = timeline;
                    });
                  },
                  startingTimeline: ReportTimeline.week),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ..._reportData[_selectedTimeline]!.cardData.map((data) =>
                          Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: DashboardCardWidget(data: data))),
                      const SizedBox(height: 64),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the blank page when the button is clicked
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BlankPage()),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
}
