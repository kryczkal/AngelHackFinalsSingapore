import 'package:flutter/material.dart';
import 'package:frontend/models/event.dart';
import 'package:frontend/mock_data/mock_events.dart';
import 'package:frontend/widgets/event_card.dart';
import 'package:frontend/widgets/upcoming_events_card.dart';
import 'package:frontend/widgets/your_events_card.dart';
import 'package:frontend/widgets/events_header.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const UpcomingEventsCard(),
                const SizedBox(width: 16),
                const YourEventsCard(),
              ],
            ),
            const SizedBox(height: 24),
            const EventsHeader(),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.8),
                itemCount: MockEvents().events.length,
                itemBuilder: (context, index) {
                  return _buildEventCard(MockEvents().events[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(Event event) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: EventCard(event: event),
    );
  }
}
