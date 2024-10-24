// create_event_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDateField extends StatelessWidget {
  final TextEditingController dateController;
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const EventDateField({
    Key? key,
    required this.dateController,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      onDateSelected(picked);
      dateController.text = DateFormat('MMM dd, yyyy').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Event date',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: dateController,
          readOnly: true,
          onTap: () => _selectDate(context),
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              filled: true,
              fillColor: Colors.white,
              suffixIcon: Icon(
                Icons.calendar_today,
                color: Colors.grey[600],
              ),
              hintText: 'Select event date'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select event date';
            }
            return null;
          },
        ),
      ],
    );
  }
}
