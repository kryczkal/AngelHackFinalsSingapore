// create_event_screen.dart

import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_events.dart';
import 'package:frontend/app_data/app_user.dart';
import 'package:frontend/models/event_badge.dart';
import 'package:frontend/models/event_categories_enum.dart';
import 'package:frontend/models/event_data.dart';

class CreateEventButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final String selectedLocation;
  final String eventTitle;
  final String eventDescription;
  final EventBadge? selectedBadge;
  final EventCategory? selectedCategory;

  const CreateEventButton({
    Key? key,
    required this.formKey,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedLocation,
    required this.eventTitle,
    required this.eventDescription,
    required this.selectedBadge,
    required this.selectedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      child: FloatingActionButton.extended(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            // Check if the date, time, and badge are selected
            if (selectedDate == null ||
                selectedTime == null ||
                selectedBadge == null ||
                selectedCategory == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please complete all fields.')),
              );
              return;
            }

            // Combine the selected date and time
            final DateTime eventDateTime = DateTime(
              selectedDate!.year,
              selectedDate!.month,
              selectedDate!.day,
              selectedTime!.hour,
              selectedTime!.minute,
            );

            // Create an instance of Event
            final Event newEvent = Event(
              title: eventTitle,
              date: eventDateTime,
              imageUrl: 'images/events/cooking.jpeg',
              backgroundColor: '#42a5f5',
              localization: selectedLocation,
              hotel: AppUserSingleton().currentUser.hotel,
              description: eventDescription,
              organizer: AppUserSingleton().currentUser,
              category: selectedCategory!,
              registeredUsers: [],
              badges: [selectedBadge!],
            );

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Event created successfully!')),
            );

            AppEventsSingleton().addEvent(newEvent);
            AppEventsSingleton().toggleUserRegistration(
                newEvent, AppUserSingleton().currentUser);
            AppUserSingleton().addCreatedEvent(newEvent);

            Navigator.pop(context);
          }
        },
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 4,
        label: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Text(
            'Create event',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
