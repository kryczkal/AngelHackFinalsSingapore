import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/app_data/app_events.dart';
import 'package:frontend/app_data/app_user.dart';
import 'package:frontend/models/event_data.dart';
import 'package:frontend/models/event_template.dart';
import 'package:frontend/pages/events/event_create_page.dart';
import 'package:frontend/pages/events/event_template_page.dart';
import 'package:frontend/pages/events/joined_events_page.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 16),
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0.8,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    if (myEvents.isEmpty)
                      const SizedBox.shrink()
                    else
                      ...myEvents.asMap().entries.take(4).map((entry) {
                        int index = entry.key;
                        Event event = entry.value;
                        return Transform.translate(
                          offset: Offset(-index * 9.5, 0),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(event.imageUrl),
                          ),
                        );
                      }),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green[400],
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EventTemplatePage()),
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    iconSize: 24,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
