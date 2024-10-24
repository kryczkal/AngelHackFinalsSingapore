// create_event_screen.dart

import 'package:flutter/material.dart';
import 'package:frontend/models/event_categories_enum.dart';

class EventCategoryField extends StatelessWidget {
  final EventCategory? selectedCategory;
  final Function(EventCategory?) onCategorySelected;

  const EventCategoryField({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Event category',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black),
          ),
          child: DropdownButtonFormField<EventCategory>(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            hint: const Text('Select a category'),
            value: selectedCategory,
            onChanged: (EventCategory? newValue) {
              onCategorySelected(newValue);
            },
            validator: (value) {
              if (value == null) {
                return 'Please select a category';
              }
              return null;
            },
            items: EventCategory.values
                .map<DropdownMenuItem<EventCategory>>((EventCategory category) {
              return DropdownMenuItem<EventCategory>(
                value: category,
                child: Text(
                  category.name[0].toUpperCase() +
                      category.name.substring(1), // Capitalizing first letter
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
