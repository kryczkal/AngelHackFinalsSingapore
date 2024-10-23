import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({Key? key}) : super(key: key);

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  String _password = '';
  String _passwordStrength = '';
  Color _strengthColor = Colors.grey;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _selectedLocation = '';
  
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final FocusNode _locationFocusNode = FocusNode();
  bool _showLocationSuggestions = false;

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
    _locationFocusNode.addListener(() {
      if (mounted) {  // Add mounted check for safety
        setState(() {
          _showLocationSuggestions = _locationFocusNode.hasFocus;
        });
      }
    });
    _locationController.addListener(() {
      if (_locationController.text != _selectedLocation) {
        _filterLocations(_locationController.text);
      }
    });
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _locationController.dispose();
    _locationFocusNode.dispose();
    super.dispose();
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

  Future<void> _selectLocation(String location) async {
    setState(() {
      _selectedLocation = location;
      
      _locationController.text = location;
      _showLocationSuggestions = false;
      _locationFocusNode.unfocus();
    });
    
    print(location);
    // Update the text selection to the end
    // _locationController.selection = TextSelection.fromPosition(
    //   TextPosition(offset: _locationController.text.length),
    // );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
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

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('MMM dd, yyyy').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
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

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        final hour = picked.hourOfPeriod;
        final minute = picked.minute.toString().padLeft(2, '0');
        final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
        _timeController.text = '$hour:$minute $period';
      });
    }
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
      floatingActionButton: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        child: FloatingActionButton.extended(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Creating event...')),
              );
            }
          },
          backgroundColor: const Color(0xFF3F51F5),
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
                Text(
                  'Event title',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter event title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

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
                  controller: _dateController,
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
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select event date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

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
                  controller: _timeController,
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
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select start time';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

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
                      controller: _locationController,
                      focusNode: _locationFocusNode,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        // hintText: 'Select or type location',
                        suffixIcon: Icon(
                          Icons.location_on,
                          color: Colors.grey[600],
                        ),
                      ),
                      onChanged: (value) {
                        if (value != _selectedLocation) {
                          _filterLocations(value);
                          setState(() {
                            _showLocationSuggestions = true;
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter event location';
                        }
                        return null;
                      },
                    ),
                    if (_showLocationSuggestions &&
                        _filteredLocations.isNotEmpty)
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
                              tileColor: _selectedLocation == location
                                  ? Colors.grey[100]
                                  : null,
                            );
                          },
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 16.0),

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

                const SizedBox(height: 70.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}