import 'package:flutter/material.dart';

import '../models/event_categories.dart';
import 'filters_widget.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onSearchChanged;
  final Function(Map<String, dynamic>) onFilterChanged;

  const SearchBarWidget({
    Key? key,
    required this.onSearchChanged,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  bool _isFilterExpanded = false;
  EventCategory _selectedCategory = EventCategory.all;
  DateTimeRange? _selectedDateRange;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleFilter() {
    setState(() {
      _isFilterExpanded = !_isFilterExpanded;
    });
  }

  void _applyFilter(EventCategory selectedCategory, DateTimeRange? dateRange) {
    widget.onFilterChanged({
      'category': selectedCategory,
      'dateRange': dateRange,
    });
    setState(() {
      _isFilterExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search events...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      widget.onSearchChanged('');
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onChanged: widget.onSearchChanged,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _toggleFilter,
          child: AnimatedRotation(
            turns: _isFilterExpanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 300),
            child: const Icon(
              Icons.keyboard_arrow_down,
              size: 30,
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _isFilterExpanded ? 300 : 0, // Adjust this value as needed
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: AnimatedOpacity(
              opacity: _isFilterExpanded ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: FiltersWidget(
                selectedCategory: _selectedCategory,
                selectedDateRange: _selectedDateRange,
                onFilterChanged: (category, dateRange) {
                  setState(() {
                    if (category != null) _selectedCategory = category;
                    _selectedDateRange = dateRange;
                  });
                  _applyFilter(category ?? EventCategory.all, dateRange);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
