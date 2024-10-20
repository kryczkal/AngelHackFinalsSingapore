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
        itemCount: AppEventsSingleton().getMyEvents(AppUserSingleton().currentUser).length,
        itemBuilder: (context, index) {
          final event = AppEventsSingleton().getMyEvents(AppUserSingleton().currentUser)[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: EventCard(event: event),
        );
        },
      ),
    );
  }
}
