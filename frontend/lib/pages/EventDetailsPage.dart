import 'package:flutter/material.dart';
import 'package:frontend/models/event.dart';

class EventDetailsPage extends StatefulWidget {
  final Event eventDetails; // Event name passed via constructor

  // Constructor to accept the event name as input
  EventDetailsPage({required this.eventDetails});

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

// The state class for EventDetailsPage
class _EventDetailsPageState extends State<EventDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Make the entire page scrollable
        child: Column(
          children: [
            // Event Image
            Stack(
              children: [
                Container(
                  height: 450,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://images.pexels.com/photos/2097090/pexels-photo-2097090.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 54, left: 24, right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                        onPressed: () {
                          // Open options or modal bottom sheet
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Event Details
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event name and like button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.eventDetails.title,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite_border_rounded),
                        color: Colors.grey,
                        iconSize: 32,
                        onPressed: () {
                          // Handle favorite toggle
                        },
                      ),
                    ],
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
                      const Icon(Icons.calendar_month, color: Colors.black),
                      const SizedBox(width: 8),
                      Text(
                        widget.eventDetails.date,
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
                    children: widget.eventDetails.badges.map((badge) => _buildBadgeTag(badge.name)).toList(),
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

                   const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            // Handle registration
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 4,
          ),
          child: const Text(
            'REGISTER',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build badge tags
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