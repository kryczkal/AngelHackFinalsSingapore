import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/app_data/app_events.dart';
import 'package:frontend/app_data/app_user.dart';
import 'package:frontend/models/event_data.dart';
import 'package:frontend/pages/joined_created_events_page.dart';
import 'package:provider/provider.dart';

class YourEventsCard extends StatelessWidget {
  const YourEventsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppEventsSingleton, AppUserSingleton>(
      builder: (context, appEventsSingleton, appUserSingleton, child) {
        final List<Event> myEvents =
            appEventsSingleton.getMyCreatedEvents(appUserSingleton.currentUser);
        return _buildMyCreatedEventsCard(context, myEvents);
      },
    );
  }

  Column _buildMyCreatedEventsCard(BuildContext context, List<Event> myEvents) {
    return Column(
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
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'Events ',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    WidgetSpan(
                      child: Icon(
                        FontAwesomeIcons.handPointDown,
                        color: Colors.orange,
                        size: 22,
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
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreatedEventsPage(),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 80,
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
                if (myEvents.isEmpty)
                  const SizedBox.shrink()
                else
                  ...myEvents.asMap().entries.take(4).map((entry) {
                    int index = entry.key;
                    Event event = entry.value;
                    return Transform.translate(
                      offset: Offset(-index * 6.5, 0),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(event.imageUrl),
                      ),
                    );
                  }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
