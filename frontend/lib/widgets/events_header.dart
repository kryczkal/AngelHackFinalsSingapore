import 'package:flutter/material.dart';

class EventsHeader extends StatelessWidget {
  final String title;
  const EventsHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
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
              const SizedBox(height: 8),
              Container(
                height: 3,
                width: 25,
                color: Colors.grey[700],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
