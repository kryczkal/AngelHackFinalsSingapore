import 'package:flutter/material.dart';
import 'package:frontend/mock_data/mock_user.dart';
import 'package:frontend/models/event.dart';
import 'package:frontend/mock_data/mock_events.dart';
import 'package:frontend/widgets/event_card.dart';

class YourEventsPage extends StatelessWidget {
  const YourEventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Events'),
      ),
      body: ListView.builder(
        itemCount: MockEvents().getMyEvents(MockUser().currentUser).length,
        itemBuilder: (context, index) {
          final event = MockEvents().getMyEvents(MockUser().currentUser)[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: EventCard(event: event),
        );
        },
      ),
    );
  }
}
