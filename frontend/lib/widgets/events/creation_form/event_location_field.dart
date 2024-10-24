import 'package:flutter/material.dart';

class EventLocationField extends StatefulWidget {
  final TextEditingController locationController;
  final String selectedLocation;
  final Function(String) onLocationSelected;

  EventLocationField({
    Key? key,
    required this.locationController,
    required this.selectedLocation,
    required this.onLocationSelected,
  }) : super(key: key);

  @override
  State<EventLocationField> createState() => _EventLocationFieldState();
}

class _EventLocationFieldState extends State<EventLocationField> {
  final List<String> _predefinedLocations = [
    'Other',
    'Yoga Room',
    'Gym',
    'Conference Room A',
    'Conference Room B',
    'Main Hall',
    'Training Room',
    'Outdoor Area',
  ];

  String? _selectedLocation;
  final TextEditingController _otherLocationController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedLocation =
        widget.selectedLocation.isNotEmpty ? widget.selectedLocation : null;
    if (_selectedLocation != null &&
        !_predefinedLocations.contains(_selectedLocation)) {
      _selectedLocation = 'Other';
      _otherLocationController.text = widget.selectedLocation;
    }
  }

  @override
  void dispose() {
    _otherLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isOtherSelected = _selectedLocation == 'Other';

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
        DropdownButtonFormField<String>(
          value: _selectedLocation,
          items: _predefinedLocations.map((location) {
            return DropdownMenuItem<String>(
              value: location,
              child: Text(location),
            );
          }).toList(),
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
            hintText: 'Select event location',
          ),
          onChanged: (value) {
            setState(() {
              _selectedLocation = value;
              if (value != 'Other') {
                widget.locationController.text = value ?? '';
                widget.onLocationSelected(value ?? '');
                _otherLocationController.clear();
              } else {
                widget.locationController.clear();
                widget.onLocationSelected('');
              }
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select event location';
            }
            return null;
          },
        ),
        if (isOtherSelected) ...[
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _otherLocationController,
            decoration: InputDecoration(
              labelText: 'Specify other location',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              widget.locationController.text = value;
              widget.onLocationSelected(value);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the location';
              }
              return null;
            },
          ),
        ],
      ],
    );
  }
}
