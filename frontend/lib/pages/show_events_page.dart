import 'package:flutter/material.dart';
import 'package:frontend/mock_data/mock_events.dart';
import 'package:frontend/models/event.dart';
import 'package:frontend/widgets/filter_dialog.dart';
import 'package:frontend/widgets/search_bar.dart';

class ShowEventsPage extends StatefulWidget {
  const ShowEventsPage({super.key});

  @override
  _ShowEventsPageState createState() => _ShowEventsPageState();
}

class _ShowEventsPageState extends State<ShowEventsPage> {
  List<Event> _filteredEvents = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _updateFilteredEvents();
  }

  void _updateFilteredEvents() {
    setState(() {
      _filteredEvents = MockEvents().getEvents().where((event) {
        return event.title.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    });
  }

  void _onSearchChanged(String query) {
    _searchQuery = query;
    _updateFilteredEvents();
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const FilterDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EventsSearchBar(
          onChanged: _onSearchChanged,
          onFilterTap: _showFilterDialog,
        ),
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
