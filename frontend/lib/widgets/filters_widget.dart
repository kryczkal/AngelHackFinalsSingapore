import 'package:flutter/material.dart';

import '../models/event_categories.dart';

class FiltersWidget extends StatefulWidget {
  final EventCategory? selectedCategory;
  final DateTimeRange? selectedDateRange;
  final Function(EventCategory?, DateTimeRange?) onFilterChanged;

  const FiltersWidget({
    Key? key,
    this.selectedCategory,
    this.selectedDateRange,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  _FiltersWidgetState createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> {
  EventCategory? _selectedCategory;
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
    _selectedDateRange = widget.selectedDateRange;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Category', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16)),
                onTap: () {
                  controller.openView();
                },
                leading: const Icon(Icons.search),
                trailing: [
                  if (_selectedCategory != null)
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _selectedCategory = null;
                        });
                      },
                    ),
                  const Icon(Icons.expand_more),
                ],
                hintText: _selectedCategory != null
                    ? formatCategoryName(_selectedCategory!)
                    : 'Select Category',
              );
            },
            suggestionsBuilder:
                (BuildContext context, SearchController controller) {
              return EventCategory.values
                  .where((category) => formatCategoryName(category)
                      .toLowerCase()
                      .contains(controller.text.toLowerCase()))
                  .map((category) => ListTile(
                        title: Text(formatCategoryName(category)),
                        onTap: () {
                          setState(() {
                            _selectedCategory = category;
                          });
                          controller.closeView(formatCategoryName(category));
                        },
                      ))
                  .toList();
            },
          ),
          const SizedBox(height: 16),
          const Text('Date Range',
              style: TextStyle(fontWeight: FontWeight.bold)),
          ListTile(
            title: Text(_selectedDateRange == null
                ? 'Select Date Range'
                : '${_selectedDateRange!.start.toString().split(' ')[0]} - ${_selectedDateRange!.end.toString().split(' ')[0]}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_selectedDateRange != null)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _selectedDateRange = null;
                      });
                    },
                  ),
                const Icon(Icons.calendar_today),
              ],
            ),
            onTap: () async {
              DateTimeRange? picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) {
                setState(() {
                  _selectedDateRange = picked;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              widget.onFilterChanged(_selectedCategory, _selectedDateRange);
            },
            child: const Text('Apply Filters'),
          ),
        ],
      ),
    );
  }
}

String formatCategoryName(EventCategory category) {
    return category.name
        .split(RegExp('(?=[A-Z])'))
        .map((word) => word.capitalize())
        .join(' ');
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
