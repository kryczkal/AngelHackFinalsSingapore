import 'package:flutter/material.dart';

class EventsSearchBar extends StatefulWidget {
  final Function(String) onSearchChanged;
  final Function(Map<String, dynamic>) onFilterChanged;

  const EventsSearchBar({
    Key? key,
    required this.onSearchChanged,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  _EventsSearchBarState createState() => _EventsSearchBarState();
}

class _EventsSearchBarState extends State<EventsSearchBar>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isFilterExpanded = false;

  String _selectedCategory = 'All';
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onFocusChange(bool hasFocus) {
    if (hasFocus) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _toggleFilter() {
    setState(() {
      _isFilterExpanded = !_isFilterExpanded;
    });
  }

  void _applyFilter() {
    widget.onFilterChanged({
      'category': _selectedCategory,
      'dateRange': _selectedDateRange,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color:
                        Colors.black.withOpacity(0.1 + _animation.value * 0.1),
                    blurRadius: 10 + _animation.value * 10,
                    offset: Offset(0, 5 + _animation.value * 5),
                  ),
                ],
              ),
              child: child,
            );
          },
          child: Focus(
            onFocusChange: _onFocusChange,
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search events...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          widget.onSearchChanged('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2),
                ),
              ),
              onChanged: widget.onSearchChanged,
            ),
          ),
        ),
        GestureDetector(
          onTap: _toggleFilter,
          onVerticalDragUpdate: (details) {
            if (details.primaryDelta! > 0 && !_isFilterExpanded) {
              _toggleFilter();
            } else if (details.primaryDelta! < 0 && _isFilterExpanded) {
              _toggleFilter();
            }
          },
          child: Icon(
            _isFilterExpanded
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down,
            color: Colors.black,
            size: 40,
            fill: 0.8,
          ),
        ),
        if (_isFilterExpanded) _buildFilterWidget(),
      ],
    );
  }

  Widget _buildFilterWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Category'),
          DropdownButton<String>(
            value: _selectedCategory,
            isExpanded: true,
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue!;
              });
            },
            items: <String>['All', 'Music', 'Sports', 'Art', 'Technology']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          const Text('Date Range'),
          ListTile(
            title: Text(_selectedDateRange == null
                ? 'Select Date Range'
                : '${_selectedDateRange!.start.toString().split(' ')[0]} - ${_selectedDateRange!.end.toString().split(' ')[0]}'),
            trailing: const Icon(Icons.calendar_today),
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
            onPressed: _applyFilter,
            child: const Text('Apply Filters'),
          ),
        ],
      ),
    );
  }
}
