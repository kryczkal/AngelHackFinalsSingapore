import 'package:flutter/material.dart';

class EventDetailsPage extends StatefulWidget {
  final String eventName; // Meal name passed via constructor

  // Constructor to accept the meal name as input
  EventDetailsPage({required this.eventName});

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

// The state class for MealDetailsPage
class _EventDetailsPageState extends State<EventDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Meal Image
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

          Expanded(
            child: Container(
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
                  // event name and like button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.eventName,
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

                  const Row(
                    children: [
                      Icon(Icons.calendar_month, color: Colors.black),
                      SizedBox(width: 8),
                      Text(
                        '20.10.2024 12:00 pm',
                        style: TextStyle(fontSize: 16),
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
                  const Row(
                    children: [
                      Icon(Icons.person, color: Colors.black),
                      SizedBox(width: 8),
                      Text(
                        'Imie Nazwisko',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

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
                    children: [
                      _buildBadgeTag('Badge 1'),
                      _buildBadgeTag('Badge 2'),
                      _buildBadgeTag('Badge 3'),
                      _buildBadgeTag('Badge 4'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeTag(String allergen) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFECAA),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Text(
        allergen,
        style: const TextStyle(
          color: Color(0xFF81681E),
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }
}