import 'package:flutter/material.dart';
import 'package:frontend/mock_data/mock_events.dart';
import 'package:frontend/models/event.dart';

class ShowEventsPage extends StatefulWidget {
  const ShowEventsPage({super.key});

  @override
  _ShowEventsPageState createState() => _ShowEventsPageState();
}

class _ShowEventsPageState extends State<ShowEventsPage> {
  List<Event> _filteredEvents = [];

  @override
  void initState() {
    super.initState();
    _filteredEvents = MockEvents().getEvents();
  }

  void _filterEvents(String query) {
    setState(() {
      _filteredEvents = MockEvents()
          .getEvents()
          .where((event) =>
              event.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(20.0),
            child: SearchBar(
              onChanged: _filterEvents,
            )),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredEvents.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: ListTile(
                  title: Text(_filteredEvents[index].title),
                  onTap: () {
                    // Handle event tap
                    print('Tapped on: ${_filteredEvents[index].title}');
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
