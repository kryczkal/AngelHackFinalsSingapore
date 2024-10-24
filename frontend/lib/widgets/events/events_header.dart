import 'package:flutter/material.dart';

import '../../pages/events/all_events_page.dart';

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
            fontSize: 21,
            height: 1.2,
            letterSpacing: -0.3,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const AllEventsPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;
                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                      position: offsetAnimation, child: child);
                },
                transitionDuration: const Duration(milliseconds: 250),
              ),
            );
          },
          child: RotatedBox(
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
        ),
      ],
    );
  }
}
