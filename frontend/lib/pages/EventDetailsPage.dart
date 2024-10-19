import 'package:flutter/material.dart';
import 'package:frontend/mock_data/mock_events.dart';
import 'package:intl/intl.dart';
import 'package:frontend/models/event.dart';
import 'package:frontend/models/user.dart';
import 'package:intl/intl.dart';

class EventDetailsPage extends StatefulWidget {
  final Event eventDetails;

  EventDetailsPage({required this.eventDetails});

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  bool isUserRegistered() {
    return widget.eventDetails.registeredUsers
        .contains(MockEvents().currentUser);
  }

  void toggleRegistration() {
    setState(() {
      if (isUserRegistered()) {
        widget.eventDetails.registeredUsers.remove(MockEvents().currentUser);
      } else {
        widget.eventDetails.registeredUsers.add(MockEvents().currentUser);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Light pink background color
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Event Image
                Container(
                  height: 420,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://images.pexels.com/photos/2097090/pexels-photo-2097090.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                      ),
                    ),
                  ),
                ),

                // Event Details Container
                Transform.translate(
                  offset: Offset(0, -40), // Move up by 40 pixels
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white, // Light pink background color
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event name
                        Text(
                          widget.eventDetails.title,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Date
                        Text(
                          'Event Date',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.calendar_month,
                                color: Colors.black),
                            const SizedBox(width: 8),
                            Text(
                              DateFormat('EEEE, MMM d')
                                  .format(widget.eventDetails.date),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // event Localization
                        Text(
                          'Event Localization',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.black),
                            const SizedBox(width: 8),
                            Text(
                              widget.eventDetails.localization,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Organizer
                        Text(
                          'Organizer',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.person, color: Colors.black),
                            const SizedBox(width: 8),
                            Text(
                              '${widget.eventDetails.organizer.firstName} ${widget.eventDetails.organizer.lastName}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Badges Section
                        Text(
                          'Badges',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: widget.eventDetails.badges
                              .map((badge) => _buildBadgeTag(badge.name))
                              .toList(),
                        ),

                        const SizedBox(height: 24),

                        // Description
                        Text(
                          'Event Description',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.eventDetails.description,
                          style: const TextStyle(fontSize: 16),
                        ),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Floating Back Button
          Positioned(
            top: 54,
            left: 24,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: toggleRegistration,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 4,
          ),
          child: Text(
            isUserRegistered() ? 'UNREGISTER' : 'REGISTER',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBadgeTag(String badge) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFECAA),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Text(
        badge,
        style: const TextStyle(
          color: Color(0xFF81681E),
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }
}
