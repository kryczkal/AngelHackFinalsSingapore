import 'package:flutter/material.dart';
import 'package:frontend/pages/events/event_create_page.dart';
import 'package:frontend/pages/events/joined_events_page.dart';
import 'package:frontend/widgets/events/joined_events_card.dart';
import 'package:frontend/widgets/events/your_events_card.dart';

class EventsDashboardHeader extends StatelessWidget {
  const EventsDashboardHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const JoinedEventsPage()),
              );
            },
            child: const SizedBox(
              height: 176,
              child: JoinedEventsCard(),
            ),
          ),
        ),
        const SizedBox(width: 24),
        const Expanded(
          child: Column(
            children: [
              SizedBox(height: 46),
              SizedBox(
                height: 176,
                child: YourEventsCard(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
