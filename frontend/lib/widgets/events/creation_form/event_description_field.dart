// create_event_screen.dart

import 'package:flutter/material.dart';

class EventDescriptionField extends StatelessWidget {
  const EventDescriptionField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Event description',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey[600],
        ),
      ),
      const SizedBox(height: 8.0),
      TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        minLines: 3,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter event description';
          }
          return null;
        },
      ),
    ]);
  }
}
