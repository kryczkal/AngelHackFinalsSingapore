import 'package:flutter/material.dart';
import 'package:frontend/models/event.dart';
import 'package:frontend/widgets/event_card.dart';
import 'package:frontend/widgets/search_bar_widget.dart';

class ShowEventsWidget extends StatefulWidget {
  final List<Event> Function() eventsLoader;

  const ShowEventsWidget({super.key, required this.eventsLoader});

  @override
  _ShowEventsWidgetState createState() => _ShowEventsWidgetState();
}

class _ShowEventsWidgetState extends State<ShowEventsWidget> {
  List<Event> _filteredEvents = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _updateFilteredEvents();
  }

  void _updateFilteredEvents() {
    setState(() {
      _filteredEvents = widget.eventsLoader().where((event) {
        return event.title.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    });
  }

  void _onSearchChanged(String query) {
    _searchQuery = query;
    _updateFilteredEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: SearchBarWidget(
              onSearchChanged: _onSearchChanged,
              onFilterChanged: (_) => {},
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredEvents.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 250,
                  child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: EventCard(event: _filteredEvents[index])),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
