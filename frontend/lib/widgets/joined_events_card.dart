import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_events.dart';
import 'package:frontend/app_data/app_user.dart';
import 'package:frontend/models/event_data.dart';
import 'package:frontend/widgets/event_card.dart';
import 'package:provider/provider.dart';

class JoinedEventsCard extends StatelessWidget {
  const JoinedEventsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppEventsSingleton>(
      builder: (context, appEvents, child) {
        final List<Event> myEvents =
            appEvents.getMyEvents(AppUserSingleton().currentUser);
        final Event? firstEvent = myEvents.isNotEmpty ? myEvents.first : null;

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: firstEvent != null ? Colors.green[100] : Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
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
            Row(
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
          ],
        ),
        const SizedBox(height: 8),
        EventCard(
            event: event,
            less: true), // Using EventCard as in the original code
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
        // const SizedBox(height: 8),
        // Text(
        //   'Discover exciting events happening near you!',
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //     color: Colors.grey[600],
        //     fontSize: 14,
        //   ),
        // ),
        // const SizedBox(height: 16),
        // ElevatedButton.icon(
        //   onPressed: () {
        //     // Add your browse events logic here
        //   },
        //   icon: const Icon(Icons.add_circle_outline),
        //   label: const Text('Browse Events'),
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.green[500],
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
