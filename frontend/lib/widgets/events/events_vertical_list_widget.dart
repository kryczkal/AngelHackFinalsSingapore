import 'package:flutter/material.dart';
import 'package:frontend/models/event_data.dart';
import 'package:frontend/widgets/misc/scroll_behavior_web_extended.dart';

import 'event_card.dart';

class EventsVerticalListWidget extends StatelessWidget {
  final List<Event> events;

  const EventsVerticalListWidget({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehaviorWebExtended().copyWith(scrollbars: false),
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 250,
            child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: EventCard(event: events[index])),
          );
        },
      ),
    );
  }
}
