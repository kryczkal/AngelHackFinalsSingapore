import 'package:flutter/material.dart';
import 'package:frontend/models/event_categories_enum.dart';
import 'package:frontend/models/event_data.dart';
import 'package:frontend/widgets/events/events_vertical_list_widget.dart';
import 'package:frontend/widgets/events/event_search_bar_widget.dart';
import 'package:frontend/widgets/misc/single_child_scroll_view_web_extended.dart';

class ShowEventsWidget extends StatefulWidget {
  final List<Event> Function() eventsLoader;

  const ShowEventsWidget({super.key, required this.eventsLoader});

  @override
  _ShowEventsWidgetState createState() => _ShowEventsWidgetState();
}

class _ShowEventsWidgetState extends State<ShowEventsWidget> {
  List<Event> _filteredEvents = [];
  String _searchQuery = '';
  EventCategory _selectedCategory = EventCategory.all;
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _updateFilteredEvents();
  }

  void _updateFilteredEvents() {
    setState(() {
      _filteredEvents = widget.eventsLoader().where((event) {
        bool matchesSearch =
            event.title.toLowerCase().contains(_searchQuery.toLowerCase());
        bool matchesCategory = _selectedCategory == EventCategory.all ||
            event.category == _selectedCategory;
        bool matchesDateRange = _selectedDateRange == null ||
            (event.date.isAfter(_selectedDateRange!.start) &&
                event.date.isBefore(_selectedDateRange!.end));

        return matchesSearch && matchesCategory && matchesDateRange;
      }).toList();
    });
  }

  void _onSearchChanged(String query) {
    _searchQuery = query;
    _updateFilteredEvents();
  }

  void _onFilterChanged(Map<String, dynamic> filters) {
    _selectedCategory = filters['category'] as EventCategory;
    _selectedDateRange = filters['dateRange'] as DateTimeRange?;
    _updateFilteredEvents();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: EventSearchBarWidget(
                    onSearchChanged: _onSearchChanged,
                    onFilterChanged: _onFilterChanged,
                  ),
                ),
                EventsVerticalListWidget(events: _filteredEvents),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
