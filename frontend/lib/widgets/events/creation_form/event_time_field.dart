// create_event_screen.dart

import 'package:flutter/material.dart';

class EventTimeField extends StatelessWidget {
  final TextEditingController timeController;
  final TimeOfDay? selectedTime;
  final Function(TimeOfDay) onTimeSelected;

  const EventTimeField({
    Key? key,
    required this.timeController,
    required this.selectedTime,
    required this.onTimeSelected,
  }) : super(key: key);

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Colors.white,
              hourMinuteShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              dayPeriodShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedTime) {
      onTimeSelected(picked);
      final hour = picked.hourOfPeriod;
      final minute = picked.minute.toString().padLeft(2, '0');
      final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
      timeController.text = '$hour:$minute $period';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Start time',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: timeController,
          readOnly: true,
          onTap: () => _selectTime(context),
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              filled: true,
              fillColor: Colors.white,
              suffixIcon: Icon(
                Icons.access_time,
                color: Colors.grey[600],
              ),
              hintText: 'Select event start time'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select start time';
            }
            return null;
          },
        ),
      ],
    );
  }
}
