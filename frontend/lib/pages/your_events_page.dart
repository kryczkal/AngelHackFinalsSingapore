import 'package:flutter/material.dart';
import 'package:frontend/mock_data/mock_events.dart';
import 'package:frontend/widgets/show_events_widget.dart';

class YourEventsPage extends StatelessWidget {
  const YourEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ShowEventsWidget(eventsLoader: () => MockEvents().getMyEvents()),
        backgroundColor: Colors.white);
  }
}
