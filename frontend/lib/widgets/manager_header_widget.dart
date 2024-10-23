import 'package:flutter/material.dart';

enum ReportTimeline {
  week(label: '1 week', period: '7d'),
  month(label: '1 month', period: '30d'),
  sixMonths(label: '6 months', period: '180d');

  final String label;
  final String period;

  const ReportTimeline({
    required this.label,
    required this.period,
  });
}

class ManagerHeaderWidget extends StatefulWidget {
  final double rating;
  final int totalEvents;
  final double cpv;

  const ManagerHeaderWidget({
    super.key,
    this.rating = 5.0,
    this.totalEvents = 0,
    this.cpv = 0.0,
  });

  @override
  State<ManagerHeaderWidget> createState() => _ManagerHeaderWidgetState();
}

class _ManagerHeaderWidgetState extends State<ManagerHeaderWidget> {
  ReportTimeline _selectedTimeline = ReportTimeline.week;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.deepPurple.shade400,
            Colors.deepPurple.shade800,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            child: Slider(
              value:
                  ReportTimeline.values.indexOf(_selectedTimeline).toDouble(),
              min: 0,
              max: ReportTimeline.values.length - 1,
              divisions: ReportTimeline.values.length - 1,
              onChanged: (value) {
                setState(() {
                  _selectedTimeline = ReportTimeline.values[value.toInt()];
                });
              },
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Total Events Column
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
                    widget.totalEvents.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // CPV Column
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
                    widget.cpv.toStringAsFixed(2),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // Overall Score Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Overall Score',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: List.generate(5, (index) {
                      final starValue = index + 1;
                      final isPartial =
                          widget.rating > index && widget.rating < starValue;
                      final isFilled = widget.rating >= starValue;

                      return Icon(
                        Icons.star,
                        size: 20,
                        color: isFilled
                            ? Colors.amber
                            : isPartial
                                ? Colors.amber.withOpacity(widget.rating % 1)
                                : Colors.white24,
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
