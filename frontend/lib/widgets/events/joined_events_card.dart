import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_events.dart';
import 'package:frontend/app_data/app_user.dart';
import 'package:frontend/models/event_data.dart';
import 'package:frontend/widgets/events/event_card.dart';
import 'package:provider/provider.dart';

class JoinedEventsCard extends StatelessWidget {
  const JoinedEventsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppEventsSingleton, AppUserSingleton>(
      builder: (context, appEvents, appUser, child) {
        final List<Event> myEvents =
            appEvents.getMyRegisteredEvents(appUser.currentUser);
        final Event? firstEvent = myEvents.isNotEmpty ? myEvents.first : null;

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: firstEvent != null ? Colors.green[100] : Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1.2,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: firstEvent != null
              ? _buildJoinedEventContent(firstEvent, myEvents.length)
              : _buildNoEventsContent(),
        );
      },
    );
  }

  Widget _buildJoinedEventContent(Event event, int eventCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.calendar_today, color: Colors.green[600]),
            const SizedBox(width: 8),
            Text(
              'Joined \nEvents',
              style: TextStyle(
                color: Colors.green[800],
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
            child: Center(
                child: EventCard(event: event, type: EventCardType.lessInfo))),
      ],
    );
  }

  Widget _buildNoEventsContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.group, size: 48, color: Colors.grey[400]),
        const SizedBox(height: 16),
        Text(
          'No events\njoined yet',
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
