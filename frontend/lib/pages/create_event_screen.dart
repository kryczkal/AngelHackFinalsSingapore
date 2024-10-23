// create_event_screen.dart
import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_badges.dart';
import 'package:frontend/app_data/app_events.dart';
import 'package:frontend/app_data/app_user.dart';
import 'package:frontend/models/event_badge.dart';
import 'package:frontend/models/event_categories_enum.dart';
import 'package:frontend/models/event_data.dart';
import 'package:intl/intl.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({Key? key}) : super(key: key);

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
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
      body: SingleChildScrollView(
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
                  locationFocusNode: _locationFocusNode,
                  showLocationSuggestions: _showLocationSuggestions,
                  selectedLocation: _selectedLocation,
                  onLocationSelected: (location) {
                    setState(() => _selectedLocation = location);
                  },
                  onSuggestionsVisibilityChanged: (visible) {
                    setState(() => _showLocationSuggestions = visible);
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
            if (selectedDate == null || selectedTime == null || selectedBadge == null || selectedCategory == null) {
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
              imageUrl: 'images/events/event.jpeg',
              backgroundColor: '#42a5f5',
              localization: selectedLocation,
              hotel: AppUserSingleton().currentUser.hotel,
              description: eventDescription,
              organizer: AppUserSingleton().currentUser,
              category: selectedCategory!,
              registeredUsers: [],
              badges: [selectedBadge!],
            );

            // Handle event creation logic (e.g., save event, navigate to another screen)
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Event created successfully!')),
            );

            // update data
            AppUserSingleton().currentUser.createdEvents.add(newEvent);
            AppUserSingleton().currentUser.registeredEvents.add(newEvent);
            AppEventsSingleton().events.add(newEvent);
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
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFF3F51F5),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
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
            hintText: 'Select event date'
          ),
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
            colorScheme: ColorScheme.light(
              primary: const Color(0xFF3F51F5),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
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
            hintText: 'Select event start time'
          ),
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
                hintText: 'Select event location'
              ),
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

class EventCategoryField extends StatelessWidget {
  final EventCategory? selectedCategory;
  final Function(EventCategory?) onCategorySelected;

  const EventCategoryField({
    Key? key,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

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
