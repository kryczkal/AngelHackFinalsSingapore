// create_event_screen.dart

import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_badges.dart';
import 'package:frontend/models/event_badge.dart';

class EventBadgeField extends StatelessWidget {
  final EventBadge? selectedBadge;
  final Function(EventBadge?) onBadgeSelected;

  const EventBadgeField({
    Key? key,
    required this.selectedBadge,
    required this.onBadgeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Event badge',
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
          child: DropdownButtonFormField<EventBadge>(
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
            hint: const Text('Select a badge'),
            value: selectedBadge,
            onChanged: (EventBadge? newValue) {
              onBadgeSelected(newValue);
            },
            validator: (value) {
              if (value == null) {
                return 'Please select a badge';
              }
              return null;
            },
            items: AppBadgesSingleton()
                .definedBadges
                .map<DropdownMenuItem<EventBadge>>((EventBadge badge) {
              return DropdownMenuItem<EventBadge>(
                value: badge,
                child: Text(badge.name),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
