import 'package:flutter/material.dart';
import 'package:frontend/models/event.dart';
import 'package:frontend/mock_data/mock_events.dart';
import 'package:frontend/widgets/event_card.dart';
import 'package:frontend/widgets/profile_header.dart';
import 'package:frontend/widgets/upcoming_events_card.dart';
import 'package:frontend/widgets/your_events_card.dart';
import 'package:frontend/widgets/events_header.dart';
import 'package:frontend/widgets/ignore_padding_widget.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 37),
              const ProfileHeader(hasNotification: true),
              const SizedBox(height: 37),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UpcomingEventsCard(),
                  SizedBox(width: 16),
                  YourEventsCard(),
                ],
              ),
              const SizedBox(height: 24),
              const EventsHeader(title: 'Events on\nThis month'),
              const SizedBox(height: 16),
              IgnorePaddingWidget(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  child: PageView.builder(
                    controller: PageController(viewportFraction: 0.80),
                    itemCount: MockEvents().events.length,
                    itemBuilder: (context, index) {
                      return _buildEventCard(MockEvents().events[index]);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const EventsHeader(title: 'Events\nAround you'),
              IgnorePaddingWidget(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  child: PageView.builder(
                    controller: PageController(viewportFraction: 0.80),
                    itemCount: MockEvents().events.length,
                    itemBuilder: (context, index) {
                      return _buildEventCard(MockEvents().events[index]);
                    },
                  ),
                ),
              ),
              // CustomBottomNavigationBar(),
            ],
          ),
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
