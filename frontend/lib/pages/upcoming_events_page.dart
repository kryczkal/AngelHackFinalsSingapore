import 'package:flutter/material.dart';

class UpcomingEventsPage extends StatelessWidget {
  const UpcomingEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming Events'),
      ),
      body: ListView(
        children: [
          const ListTile(
            leading: Icon(Icons.event),
            title: Text('Event 1'),
            subtitle: Text('Date: 2023-11-01'),
          ),
          const ListTile(
            leading: Icon(Icons.event),
            title: Text('Event 2'),
            subtitle: Text('Date: 2023-11-05'),
          ),
          ListTile(
            leading:  Icon(Icons.event),
            title:  Text('Event 3'),
            subtitle:  Text('Date: 2023-11-10'),
          ),
          // Add more ListTiles for additional events
        ],
      ),
    );
  }
}
