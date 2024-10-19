import 'package:flutter/material.dart';
import 'package:frontend/mock_data/mock_events.dart';

class YourEventsCard extends StatelessWidget {
  const YourEventsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                RichText(
                  text: const TextSpan(
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
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 2),
                Container(
                  height: 2,
                  width: 85,
                  color: Colors.black,
                ),
              ],
            ),
          ),
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
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
