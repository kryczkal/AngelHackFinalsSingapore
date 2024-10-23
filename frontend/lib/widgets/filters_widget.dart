import 'package:flutter/material.dart';

import '../models/event_categories_enum.dart';

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

class _FiltersWidgetState extends State<FiltersWidget>
    with SingleTickerProviderStateMixin {
  EventCategory? _selectedCategory;
  DateTimeRange? _selectedDateRange;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
    _selectedDateRange = widget.selectedDateRange;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _formatCategoryName(EventCategory category) {
    return category.name
        .split(RegExp('(?=[A-Z])'))
        .map((word) => word.capitalize())
        .join(' ');
  }

  Future<void> _showDateRangePicker() async {
    _animationController.forward();
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.white,
          ),
          child: FadeTransition(
            opacity: _animation,
            child: child,
          ),
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
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
          const SizedBox(height: 8),
          InkWell(
            onTap: _showDateRangePicker,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_selectedDateRange == null
                      ? 'Select Date Range'
                      : '${_selectedDateRange!.start.toString().split(' ')[0]} - ${_selectedDateRange!.end.toString().split(' ')[0]}'),
                  Row(
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
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onFilterChanged(_selectedCategory, _selectedDateRange);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Apply Filters',
                  style: TextStyle(color: Colors.black)),
            ),
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
