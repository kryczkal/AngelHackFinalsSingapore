import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_events.dart';
import 'package:frontend/app_data/app_user.dart';

import 'package:frontend/widgets/event_card.dart';

class JoinedEventsPage extends StatelessWidget {
  const JoinedEventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Events'),
      ),
      body: ListView.builder(
        itemCount: AppUserSingleton().currentUser.registeredEvents.length,
        itemBuilder: (context, index) {
          final event = AppUserSingleton().currentUser.registeredEvents[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: EventCard(event: event),
        );
        },
      ),
    );
  }
}

class CreatedEventsPage extends StatelessWidget {
  const CreatedEventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events Created by You')),
      body: ListView.builder(
        itemCount: AppUserSingleton().currentUser.createdEvents.length,
        itemBuilder: (context, index) {
          final event = AppUserSingleton().currentUser.createdEvents[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: EventCard(event: event),
        );
        },
      ),
    );
  }
}