// create_event_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/events/create_event_page.dart';
import 'package:frontend/widgets/events/creation_form/event_location_field.dart';

class EventLocationField extends StatefulWidget {
  final TextEditingController locationController;
  final FocusNode locationFocusNode;
  final bool showLocationSuggestions;
  final String selectedLocation;
  final Function(String) onLocationSelected;
  final Function(bool) onSuggestionsVisibilityChanged;

  const EventLocationField({
    Key? key,
    required this.locationController,
    required this.locationFocusNode,
    required this.showLocationSuggestions,
    required this.selectedLocation,
    required this.onLocationSelected,
    required this.onSuggestionsVisibilityChanged,
  }) : super(key: key);

  @override
  State<EventLocationField> createState() => _EventLocationFieldState();
}

class _EventLocationFieldState extends State<EventLocationField> {
  final List<String> _predefinedLocations = [
    'Yoga Room',
    'Gym',
    'Conference Room A',
    'Conference Room B',
    'Main Hall',
    'Training Room',
    'Outdoor Area',
  ];

  List<String> _filteredLocations = [];

  @override
  void initState() {
    super.initState();
    _filteredLocations = List.from(_predefinedLocations);
    widget.locationFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    widget.locationFocusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    widget.onSuggestionsVisibilityChanged(widget.locationFocusNode.hasFocus);
  }

  void _filterLocations(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredLocations = List.from(_predefinedLocations);
      } else {
        _filteredLocations = _predefinedLocations
            .where((location) =>
                location.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _selectLocation(String location) {
    widget.onLocationSelected(location);
    widget.locationController.text = location;
    widget.onSuggestionsVisibilityChanged(false);
    widget.locationFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Event Location',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8.0),
        Column(
          children: [
            TextFormField(
              controller: widget.locationController,
              focusNode: widget.locationFocusNode,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: Icon(
                    Icons.location_on,
                    color: Colors.grey[600],
                  ),
                  hintText: 'Select event location'),
              onChanged: (value) {
                if (value != widget.selectedLocation) {
                  _filterLocations(value);
                  widget.onSuggestionsVisibilityChanged(true);
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter event location';
                }
                return null;
              },
            ),
            if (widget.showLocationSuggestions && _filteredLocations.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                constraints: const BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _filteredLocations.length,
                  itemBuilder: (context, index) {
                    final location = _filteredLocations[index];
                    return ListTile(
                      title: Text(location),
                      onTap: () => _selectLocation(location),
                      tileColor: widget.selectedLocation == location
                          ? Colors.grey[100]
                          : null,
                    );
                  },
                ),
              ),
          ],
        ),
      ],
    );
  }
}
