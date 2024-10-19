import 'package:flutter/material.dart';
import 'package:frontend/models/event.dart';
import 'package:frontend/mock_data/mock_events.dart';
import 'package:frontend/widgets/event_card.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildUpcomingEventsCard(),
                const SizedBox(width: 16),
                _buildYourEventsCard(),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Events on\nThis month',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RotatedBox(
                  quarterTurns: 3,
                  child: Column(
                    children: [
                      Text(
                        'See all',
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 3,
                        width: 25,
                        color: Colors.grey[700],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.8),
                itemCount: MockEvents().events.length,
                itemBuilder: (context, index) {
                  return _buildEventCard(MockEvents().events[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingEventsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[400],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: Text(MockEvents().myEvents.length.toString() + '+',
                    style: TextStyle(
                      color: Colors.green[400],
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                    )),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.star, color: Colors.white, size: 24),
            ],
          ),
          const SizedBox(height: 37),
          const Text(
            'Upcoming Events',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildYourEventsCard() {
    return Expanded(
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Your\n',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'Events ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    WidgetSpan(
                      child: Icon(
                        Icons.push_pin,
                        color: Colors.orange,
                        size: 18,
                      ),
                    ),
                    WidgetSpan(
                      child: Container(
                        height: 2,
                        width: 85,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              )),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                ...MockEvents().getMyEvents().map((event) {
                  return CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage(event.imageUrl),
                  );
                }).toList()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Event event) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: EventCard(event: event),
    );
  }
}
