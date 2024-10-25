import 'package:flutter/material.dart';
import 'package:frontend/models/event_data.dart';
import 'event_card.dart';

class EventsVerticalListWidget extends StatelessWidget {
  final List<Event> events;

  const EventsVerticalListWidget({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: events
          .map(
            (event) => SizedBox(
              height: 250,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: EventCard(event: event),
              ),
            ),
          )
          .toList(),
    );
  }
}
