import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_events.dart';

class UpcomingEventsCard extends StatelessWidget {
  const UpcomingEventsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[400],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: Text(
                  '${AppEventsSingleton().myEvents.length}+',
                  style: TextStyle(
                    color: Colors.green[400],
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.star, color: Colors.white, size: 24),
            ],
          ),
          const SizedBox(height: 37),
          const Text(
            'Upcoming Events',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
