import 'package:flutter/material.dart';
import 'package:frontend/models/report_data.dart';
import 'package:frontend/models/report_timeline_enum.dart';
import 'package:frontend/widgets/misc/show_case_wrapper_widget.dart';

class ManagerHeaderWidget extends StatefulWidget {
  final Map<ReportTimeline, ReportData> reportData;
  final void Function(ReportTimeline) onTimelineChanged;
  final ReportTimeline startingTimeline;
  final GlobalKey showcaseKey;

  const ManagerHeaderWidget(
      {super.key,
      required this.reportData,
      required this.onTimelineChanged,
      required this.startingTimeline,
      required this.showcaseKey});

  @override
  State<ManagerHeaderWidget> createState() => _ManagerHeaderWidgetState();
}

class _ManagerHeaderWidgetState extends State<ManagerHeaderWidget> {
  late ReportTimeline _selectedTimeline;

  @override
  void initState() {
    super.initState();
    _selectedTimeline = widget.startingTimeline;
  }

  @override
  Widget build(BuildContext context) {
    final currentData = widget.reportData[_selectedTimeline]!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.shade400,
            Colors.green.shade800,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Manager Dashboard',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Report timeline (${_selectedTimeline.period})',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                _selectedTimeline.label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.white24,
              thumbColor: Colors.white,
              overlayColor: Colors.white.withOpacity(0.1),
              valueIndicatorColor: Colors.white,
              tickMarkShape: RoundSliderTickMarkShape(),
              activeTickMarkColor: Colors.white,
              inactiveTickMarkColor: Colors.white24,
            ),
            child: ShowcaseWrapper(
              showcaseKey: widget.showcaseKey,
              title: "Manage report interval!",
              description:
                  "You can change the report interval to view different data and see some simplistic preview",
              child: Slider(
                value:
                    ReportTimeline.values.indexOf(_selectedTimeline).toDouble(),
                min: 0,
                max: ReportTimeline.values.length - 1,
                divisions: ReportTimeline.values.length - 1,
                onChanged: (value) {
                  setState(() {
                    _selectedTimeline = ReportTimeline.values[value.toInt()];
                    widget.onTimelineChanged(_selectedTimeline);
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Events Organized',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    currentData.totalEvents.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'CPV',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    currentData.cpv.toStringAsFixed(2),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Score: ${currentData.averageScore.toStringAsFixed(1)}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: List.generate(5, (index) {
                      final starValue = index + 1;
                      final isPartial = currentData.averageScore > index &&
                          currentData.averageScore < starValue;
                      final isFilled = currentData.averageScore >= starValue;

                      return Icon(
                        Icons.star,
                        size: 20,
                        color: isFilled
                            ? Colors.amber
                            : isPartial
                                ? Colors.amber
                                    .withOpacity(currentData.averageScore % 1)
                                : Colors.white24,
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
