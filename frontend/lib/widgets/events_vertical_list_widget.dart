import 'package:flutter/material.dart';
import 'package:frontend/models/event_data.dart';

import 'event_card.dart';

class EventsVerticalListWidget extends StatelessWidget {
  final List<Event> events;

  const EventsVerticalListWidget({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 250,
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: EventCard(event: events[index])),
        );
      },
    );
  }
}
