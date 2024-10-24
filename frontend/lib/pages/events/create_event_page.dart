// create_event_screen.dart
import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_badges.dart';
import 'package:frontend/app_data/app_events.dart';
import 'package:frontend/app_data/app_user.dart';
import 'package:frontend/models/event_badge.dart';
import 'package:frontend/models/event_categories_enum.dart';
import 'package:frontend/models/event_data.dart';
import 'package:frontend/widgets/events/creation_form/create_event_button.dart';
import 'package:frontend/widgets/events/creation_form/event_badge_field.dart';
import 'package:frontend/widgets/events/creation_form/event_category_field.dart';
import 'package:frontend/widgets/events/creation_form/event_date_field.dart';
import 'package:frontend/widgets/events/creation_form/event_location_field.dart';
import 'package:frontend/widgets/events/creation_form/event_time_field.dart';
import 'package:frontend/widgets/misc/single_child_scroll_view_web_extended.dart';
import 'package:intl/intl.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _selectedLocation = '';
  String _eventTitle = '';
  String _eventDescription = '';
  EventBadge? _selectedBadge;
  EventCategory? _selectedCategory;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final FocusNode _locationFocusNode = FocusNode();
  bool _showLocationSuggestions = false;

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _locationController.dispose();
    _locationFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Create Event',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      floatingActionButton: CreateEventButton(
        formKey: _formKey,
        selectedDate: _selectedDate,
        selectedTime: _selectedTime,
        selectedLocation: _selectedLocation,
        eventTitle: _eventTitle,
        eventDescription: _eventDescription,
        selectedBadge: _selectedBadge,
        selectedCategory: _selectedCategory,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollViewWebExtended(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Event title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    _eventTitle = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter event title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                EventDateField(
                  dateController: _dateController,
                  selectedDate: _selectedDate,
                  onDateSelected: (date) {
                    setState(() => _selectedDate = date);
                  },
                ),
                const SizedBox(height: 16.0),
                EventTimeField(
                  timeController: _timeController,
                  selectedTime: _selectedTime,
                  onTimeSelected: (time) {
                    setState(() => _selectedTime = time);
                  },
                ),
                const SizedBox(height: 16.0),
                EventLocationField(
                  locationController: _locationController,
                  selectedLocation: _selectedLocation,
                  onLocationSelected: (location) {
                    setState(() => _selectedLocation = location);
                  },
                ),
                const SizedBox(height: 16.0),
                EventBadgeField(
                  selectedBadge: _selectedBadge,
                  onBadgeSelected: (badge) {
                    setState(() => _selectedBadge = badge);
                  },
                ),
                const SizedBox(height: 16.0),
                EventCategoryField(
                  selectedCategory: _selectedCategory,
                  onCategorySelected: (category) {
                    setState(() => _selectedCategory = category);
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Event description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  maxLines: 3,
                  onChanged: (value) {
                    _eventDescription = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter event description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 70.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
