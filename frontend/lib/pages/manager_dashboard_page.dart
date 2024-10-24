import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_manager.dart';
import 'package:frontend/models/report_data.dart';
import 'package:frontend/models/report_timeline_enum.dart';
import 'package:frontend/widgets/dashboard_card_widget.dart';
import 'package:frontend/widgets/manager_header_widget.dart';
import 'package:frontend/widgets/pie_chart_preview_widget.dart';
import 'package:frontend/widgets/profile_header.dart';
import 'package:frontend/widgets/table_preview_widget.dart';

class PreviewBox extends StatelessWidget {
  final Widget child;

  const PreviewBox({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class PreviewExample extends StatelessWidget {
  const PreviewExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        SizedBox(
          width: 200,
          child: PreviewBox(
            child: TablePreview(data: TablePreviewData.fromVariant(1)),
          ),
        ),
        SizedBox(
          width: 200,
          child: PreviewBox(
            child: TablePreview(data: TablePreviewData.fromVariant(2)),
          ),
        ),
        SizedBox(
          width: 200,
          child: PreviewBox(
            child: TablePreview(data: TablePreviewData.fromVariant(3)),
          ),
        ),
        PreviewBox(
          child:
              PieChartPreviewWidget(data: PieChartPreviewData.fromVariant(1)),
        ),
        PreviewBox(
          child:
              PieChartPreviewWidget(data: PieChartPreviewData.fromVariant(2)),
        ),
        PreviewBox(
          child:
              PieChartPreviewWidget(data: PieChartPreviewData.fromVariant(3)),
        ),
      ],
    );
  }
}

class BlankPage extends StatelessWidget {
  const BlankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: PreviewExample(),
      ),
    );
  }
}

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
                    children: _reportData[_selectedTimeline]!
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
